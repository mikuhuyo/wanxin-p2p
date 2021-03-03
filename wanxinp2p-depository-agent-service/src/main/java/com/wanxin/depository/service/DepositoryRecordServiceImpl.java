package com.wanxin.depository.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.consumer.model.RechargeRequest;
import com.wanxin.api.consumer.model.WithdrawRequest;
import com.wanxin.api.depository.model.DepositoryBaseResponse;
import com.wanxin.api.depository.model.DepositoryResponseDTO;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.api.depository.model.ProjectRequestDataDTO;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.common.domain.StatusCode;
import com.wanxin.common.util.EncryptUtil;
import com.wanxin.common.util.RSAUtil;
import com.wanxin.depository.common.constant.DepositoryErrorCode;
import com.wanxin.depository.common.constant.DepositoryRequestTypeCode;
import com.wanxin.depository.entity.DepositoryRecord;
import com.wanxin.depository.mapper.DepositoryRecordMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Override
    public DepositoryResponseDTO<DepositoryBaseResponse> createProject(ProjectDTO projectDTO) {
        DepositoryRecord depositoryRecord = saveDepositoryRecord(projectDTO.getRequestNo(), DepositoryRequestTypeCode.CREATE.getCode(), "Project", projectDTO.getId());

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

    private DepositoryResponseDTO<DepositoryBaseResponse> sendHttpGet(String serviceName, String url, String reqData, DepositoryRecord depositoryRecord) {
        // 银行存管系统接收的4大参数: serviceName, platformNo, reqData, signature
        // signature会在okHttp拦截器(SignatureInterceptor)中处理
        // 平台编号
        String platformNo = configService.getP2pCode();
        // redData签名
        // 发送请求, 获取结果, 如果检验签名失败, 拦截器会在结果中放入: "signature", "false"
        String responseBody = okHttpService.doSyncGet(url + "?serviceName=" + serviceName
                + "&platformNo=" + platformNo
                + "&reqData=" + reqData);

        DepositoryResponseDTO<DepositoryBaseResponse> depositoryResponse = JSONObject.parseObject(responseBody, DepositoryResponseDTO.class);

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
    private DepositoryRecord saveDepositoryRecord(String requestNo, String requestType, String objectType, Long objectId) {
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

        System.out.println(depositoryRecord);

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

    private void saveDepositoryRecord(ConsumerRequest consumerRequest) {
        DepositoryRecord depositoryRecord = new DepositoryRecord();
        depositoryRecord.setRequestNo(consumerRequest.getRequestNo());
        depositoryRecord.setRequestType(DepositoryRequestTypeCode.CONSUMER_CREATE.getCode());
        depositoryRecord.setObjectType("Consumer");
        depositoryRecord.setObjectId(consumerRequest.getId());
        depositoryRecord.setCreateDate(LocalDateTime.now());
        depositoryRecord.setRequestStatus(StatusCode.STATUS_OUT.getCode());
        depositoryRecordMapper.insert(depositoryRecord);
    }

}
