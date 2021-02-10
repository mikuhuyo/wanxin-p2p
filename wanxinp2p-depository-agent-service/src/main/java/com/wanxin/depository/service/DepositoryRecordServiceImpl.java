package com.wanxin.depository.service;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.consumer.model.RechargeRequest;
import com.wanxin.api.consumer.model.WithdrawRequest;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.StatusCode;
import com.wanxin.common.util.EncryptUtil;
import com.wanxin.common.util.RSAUtil;
import com.wanxin.depository.common.constant.DepositoryRequestTypeCode;
import com.wanxin.depository.entity.DepositoryRecord;
import com.wanxin.depository.mapper.DepositoryRecordMapper;
import lombok.extern.slf4j.Slf4j;
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
