package com.wanxin.depository.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.consumer.model.RechargeRequest;
import com.wanxin.api.consumer.model.WithdrawRequest;
import com.wanxin.api.depository.model.*;
import com.wanxin.api.transaction.model.ModifyProjectStatusDTO;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.common.domain.StatusCode;
import com.wanxin.common.util.EncryptUtil;
import com.wanxin.common.util.RSAUtil;
import com.wanxin.depository.common.cache.RedisCache;
import com.wanxin.depository.common.constant.DepositoryErrorCode;
import com.wanxin.depository.common.constant.DepositoryRequestTypeCode;
import com.wanxin.depository.entity.DepositoryRecord;
import com.wanxin.depository.mapper.DepositoryRecordMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@Service
public class DepositoryRecordServiceImpl implements DepositoryRecordService {
    @Autowired
    private ConfigService configService;
    @Autowired
    private DepositoryRecordMapper depositoryRecordMapper;
    @Autowired
    private OkHttpService okHttpService;
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    private String personalRegistry = "PERSONAL_REGISTER";
    private String recharge = "RECHARGE";
    private String withdraw = "WITHDRAW";

    private GatewayRequest encapsulatedGatewayRequest(String serviceName, Object data, String uri) {
        String depositoryUrl = configService.getDepositoryUrl() + uri;
        String p2pCode = configService.getP2pCode();
        String p2pPrivateKeyKey = configService.getP2pPrivateKey();

        // 签名数据
        String reqData = JSON.toJSONString(data);
        String sign = RSAUtil.sign(reqData, p2pPrivateKeyKey, "utf-8");

        // 签名数据
        reqData = EncryptUtil.encodeURL(EncryptUtil.encodeUTF8StringBase64(reqData));
        sign = EncryptUtil.encodeURL(sign);

        GatewayRequest gatewayRequest = new GatewayRequest();
        gatewayRequest.setServiceName(serviceName);
        gatewayRequest.setPlatformNo(p2pCode);
        gatewayRequest.setReqData(reqData);
        gatewayRequest.setSignature(sign);
        gatewayRequest.setDepositoryUrl(depositoryUrl);

        return gatewayRequest;
    }

    /**
     * 实现幂等性
     *
     * @param depositoryRecord 存管记录信息
     * @return
     */
    private DepositoryResponseDTO<DepositoryBaseResponse> handleIdempotent(DepositoryRecord depositoryRecord) {
        // 根据requestNo查询交易记录
        String requestNo = depositoryRecord.getRequestNo();
        DepositoryRecordDTO depositoryRecordDTO = getByRequestNo(requestNo);
        // 交易记录不存在则新增交易记录
        if (depositoryRecordDTO == null) {
            //保存交易记录
            saveDepositoryRecord(depositoryRecord.getRequestNo(), depositoryRecord.getRequestType(), depositoryRecord.getObjectType(), depositoryRecord.getObjectId());
            return null;
        }

        // 交易记录存在并且数据状态为未同步, 则利用redis原子性自增, 来争夺请求执行权
        if (StatusCode.STATUS_OUT.getCode() == depositoryRecordDTO.getRequestStatus()) {
            RedisCache cache = new RedisCache(stringRedisTemplate);
            // 如果requestNo不存在则返回1, 如果已经存在, 则会返回(requestNo已存在个数+1)
            Long count = cache.incrBy(requestNo, 1L);
            if (count == 1) {
                // 设置requestNo有效期5秒
                cache.expire(requestNo, 5);
                return null;
            }
            // 若count大于1, 说明已有线程在执行该操作, 直接返回"正在处理"
            if (count > 1) {
                throw new BusinessException(DepositoryErrorCode.E_160103);
            }
        }

        // 交易记录存在并且数据状态为已同步, 直接返回处理结果
        return JSONObject.parseObject(
                depositoryRecordDTO.getResponseData(),
                new TypeReference<DepositoryResponseDTO<DepositoryBaseResponse>>() {
                }
        );
    }

    private DepositoryRecordDTO getByRequestNo(String requestNo) {
        DepositoryRecord depositoryRecord = getEntityByRequestNo(requestNo);
        if (depositoryRecord == null) {
            return null;
        }
        DepositoryRecordDTO depositoryRecordDTO = new DepositoryRecordDTO();
        BeanUtils.copyProperties(depositoryRecord, depositoryRecordDTO);
        return depositoryRecordDTO;
    }

    private DepositoryRecord getEntityByRequestNo(String requestNo) {
        return depositoryRecordMapper.selectOne(new LambdaQueryWrapper<DepositoryRecord>().eq(DepositoryRecord::getRequestNo, requestNo));
    }

    @Override
    public DepositoryResponseDTO<DepositoryBaseResponse> modifyProjectStatus(ModifyProjectStatusDTO modifyProjectStatusDTO) {
        DepositoryRecord depositoryRecord = new DepositoryRecord(modifyProjectStatusDTO.getRequestNo(), DepositoryRequestTypeCode.MODIFY_STATUS.getCode(), "Project", modifyProjectStatusDTO.getId());

        // 幂等性实现
        DepositoryResponseDTO<DepositoryBaseResponse> responseDTO = handleIdempotent(depositoryRecord);
        if (responseDTO != null) {
            return responseDTO;
        }
        // 根据requestNo获取交易记录
        handleIdempotent(depositoryRecord);
        depositoryRecord = getEntityByRequestNo(modifyProjectStatusDTO.getRequestNo());
        // loanRequest 转为 json 进行数据签名
        final String jsonString = JSON.toJSONString(modifyProjectStatusDTO);
        // 业务数据报文
        String reqData = EncryptUtil.encodeUTF8StringBase64(jsonString);
        // 拼接银行存管系统请求地址
        String url = configService.getDepositoryUrl() + "/service";
        // 封装通用方法, 请求银行存管系统
        return sendHttpGet("MODIFY_PROJECT", url, reqData, depositoryRecord);
    }

    @Override
    public DepositoryResponseDTO<DepositoryBaseResponse> confirmLoan(LoanRequest loanRequest) {
        DepositoryRecord depositoryRecord = new DepositoryRecord(loanRequest.getRequestNo(), DepositoryRequestTypeCode.FULL_LOAN.getCode(), "LoanRequest", loanRequest.getId());
        // 幂等性实现
        DepositoryResponseDTO<DepositoryBaseResponse> responseDTO = handleIdempotent(depositoryRecord);
        if (responseDTO != null) {
            return responseDTO;
        }
        // 根据requestNo获取交易记录
        depositoryRecord = getEntityByRequestNo(loanRequest.getRequestNo());
        // loanRequest 转为 json 用于数据签名
        final String jsonString = JSON.toJSONString(loanRequest);
        // 业务数据报文, json数据base64编码处理方便传输
        String reqData = EncryptUtil.encodeUTF8StringBase64(jsonString);
        // 拼接银行存管系统请求地址
        String url = configService.getDepositoryUrl() + "/service";
        // 封装通用方法, 请求银行存管系统
        return sendHttpGet("CONFIRM_LOAN", url, reqData, depositoryRecord);
    }

    @Override
    public DepositoryResponseDTO<DepositoryBaseResponse> userAutoPreTransaction(UserAutoPreTransactionRequest userAutoPreTransactionRequest) {
        DepositoryRecord depositoryRecord = new DepositoryRecord(userAutoPreTransactionRequest.getRequestNo(), userAutoPreTransactionRequest.getBizType(), "UserAutoPreTransactionRequest", userAutoPreTransactionRequest.getId());
        // 幂等性实现
        DepositoryResponseDTO<DepositoryBaseResponse> responseDTO = handleIdempotent(depositoryRecord);
        if (responseDTO != null) {
            return responseDTO;
        }

        // 根据requestNo获取交易记录
        getEntityByRequestNo(userAutoPreTransactionRequest.getRequestNo());
        // userAutoPreTransactionRequest 转为 json 用于数据签名
        String jsonString = JSON.toJSONString(userAutoPreTransactionRequest);
        // 业务数据报文, 对json数据进行base64编码处理方便传输
        String reqData = EncryptUtil.encodeUTF8StringBase64(jsonString);
        // 发送请求, 获取结果
        // 拼接银行存管系统请求地址
        String url = configService.getDepositoryUrl() + "/service";
        // 向银行存管系统发送请求
        return sendHttpGet("USER_AUTO_PRE_TRANSACTION", url, reqData, depositoryRecord);
    }

    @Override
    public DepositoryResponseDTO<DepositoryBaseResponse> createProject(ProjectDTO projectDTO) {
        DepositoryRecord depositoryRecord = new DepositoryRecord(
                projectDTO.getRequestNo(),
                DepositoryRequestTypeCode.CREATE.getCode(), "Project",
                projectDTO.getId());

        // 幂等性实现
        DepositoryResponseDTO<DepositoryBaseResponse> responseDTO = handleIdempotent(depositoryRecord);
        if (responseDTO != null) {
            return responseDTO;
        }
        // 根据requestNo获取交易记录
        depositoryRecord = getEntityByRequestNo(projectDTO.getRequestNo());

        // DepositoryRecord depositoryRecord = saveDepositoryRecord(projectDTO.getRequestNo(), DepositoryRequestTypeCode.CREATE.getCode(), "Project", projectDTO.getId());

        ProjectRequestDataDTO projectRequestDataDTO = convertProjectDTOToProjectRequestDataDTO(projectDTO, depositoryRecord.getRequestNo());
        // 转换为JSON
        String jsonString = JSONObject.toJSONString(projectRequestDataDTO);

        //base64编码
        String reqData = EncryptUtil.encodeUTF8StringBase64(jsonString);
        // 往银行存管系统发送数据(标的信息),根据结果修改状态并返回结果
        // url地址
        String url = configService.getDepositoryUrl() + "/service";

        // OKHttpClient 发送Http请求
        return sendHttpGet("CREATE_PROJECT", url, reqData, depositoryRecord);
    }

    private DepositoryResponseDTO<DepositoryBaseResponse> sendHttpGet(String serviceName, String url, String
            reqData, DepositoryRecord depositoryRecord) {
        // 银行存管系统接收的4大参数: serviceName, platformNo, reqData, signature
        // signature会在okHttp拦截器(SignatureInterceptor)中处理
        // 平台编号
        String platformNo = configService.getP2pCode();
        // redData签名
        // 发送请求, 获取结果, 如果检验签名失败, 拦截器会在结果中放入: "signature", "false"
        String responseBody = okHttpService.doSyncGet(url + "?serviceName=" + serviceName
                + "&platformNo=" + platformNo
                + "&reqData=" + reqData);

        depositoryRecord.setResponseData(responseBody);

        DepositoryResponseDTO<DepositoryBaseResponse> depositoryResponse = JSONObject.parseObject(
                responseBody,
                new TypeReference<DepositoryResponseDTO<DepositoryBaseResponse>>() {
                }
        );

        // 响应后, 根据结果更新数据库( 进行签名判断 )
        // 判断签名(signature)是为 false, 如果是说明验签失败!
        if (!"false".equals(depositoryResponse.getSignature())) {
            // 成功 - 设置数据同步状态
            depositoryRecord.setRequestStatus(StatusCode.STATUS_IN.getCode());
            // 设置消息确认时间
            depositoryRecord.setConfirmDate(LocalDateTime.now());
            // 更新数据库
            depositoryRecordMapper.updateById(depositoryRecord);
        } else {
            // 失败 - 设置数据同步状态
            depositoryRecord.setRequestStatus(StatusCode.STATUS_FAIL.getCode());
            // 设置消息确认时间
            depositoryRecord.setConfirmDate(LocalDateTime.now());
            // 更新数据库
            depositoryRecordMapper.updateById(depositoryRecord);
            // 抛业务异常
            throw new BusinessException(DepositoryErrorCode.E_160101);
        }

        return depositoryResponse;
    }

    private ProjectRequestDataDTO convertProjectDTOToProjectRequestDataDTO(ProjectDTO projectDTO, String requestNo) {
        if (projectDTO == null) {
            return null;
        }

        ProjectRequestDataDTO requestDataDTO = new ProjectRequestDataDTO();
        BeanUtils.copyProperties(projectDTO, requestDataDTO);
        requestDataDTO.setRequestNo(requestNo);
        requestDataDTO.setProjectName(projectDTO.getName());
        requestDataDTO.setProjectType(projectDTO.getType());
        requestDataDTO.setProjectAmount(projectDTO.getAmount());
        requestDataDTO.setProjectDesc(projectDTO.getDescription());
        requestDataDTO.setProjectPeriod(projectDTO.getPeriod());
        return requestDataDTO;
    }

    /**
     * 保存交易记录
     */
    private DepositoryRecord saveDepositoryRecord(String requestNo, String requestType, String objectType, Long
            objectId) {
        DepositoryRecord depositoryRecord = new DepositoryRecord();
        // 设置请求流水号
        depositoryRecord.setRequestNo(requestNo);
        // 设置请求类型
        depositoryRecord.setRequestType(requestType);
        // 设置关联业务实体类型
        depositoryRecord.setObjectType(objectType);
        // 设置关联业务实体标识
        depositoryRecord.setObjectId(objectId);
        // 设置请求时间
        depositoryRecord.setCreateDate(LocalDateTime.now());
        // 设置数据同步状态
        depositoryRecord.setRequestStatus(StatusCode.STATUS_OUT.getCode());

        // 保存数据
        depositoryRecordMapper.insert(depositoryRecord);
        return depositoryRecord;
    }

    @Override
    public GatewayRequest withdrawRecords(WithdrawRequest withdrawRequest) {
        return encapsulatedGatewayRequest(this.withdraw, withdrawRequest, "/gateway");
    }

    @Override
    public GatewayRequest rechargeRecords(RechargeRequest rechargeRequest) {
        return encapsulatedGatewayRequest(this.recharge, rechargeRequest, "/gateway");
    }

    @Override
    public Boolean modifyRequestStatus(String requestNo, Integer requestsStatus) {
        DepositoryRecord depositoryRecord = new DepositoryRecord();
        depositoryRecord.setRequestStatus(requestsStatus);
        depositoryRecord.setConfirmDate(LocalDateTime.now());
        return depositoryRecordMapper.update(depositoryRecord, new LambdaQueryWrapper<DepositoryRecord>().eq(DepositoryRecord::getRequestNo, requestNo)) == 1;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public GatewayRequest createConsumer(ConsumerRequest consumerRequest) {
        return encapsulatedGatewayRequest(personalRegistry, consumerRequest, "/gateway");
    }

}
