package com.wanxin.depository.service;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.api.consumer.model.ConsumerRequest;
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
        // 保存交易记录
        saveDepositoryRecord(consumerRequest);

        // 签名数据并返回
        String reqData = JSON.toJSONString(consumerRequest);
        String sign = RSAUtil.sign(reqData, configService.getP2pPrivateKey(), "utf-8");
        GatewayRequest gatewayRequest = new GatewayRequest();
        gatewayRequest.setServiceName("PERSONAL_REGISTER");
        gatewayRequest.setPlatformNo(configService.getP2pCode());
        gatewayRequest.setReqData(EncryptUtil.encodeURL(EncryptUtil.encodeUTF8StringBase64(reqData)));
        gatewayRequest.setSignature(EncryptUtil.encodeURL(sign));
        gatewayRequest.setDepositoryUrl(configService.getDepositoryUrl() + "/gateway");
        return gatewayRequest;
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
