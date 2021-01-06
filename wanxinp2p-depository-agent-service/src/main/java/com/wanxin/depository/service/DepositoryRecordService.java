package com.wanxin.depository.service;

import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.depository.model.GatewayRequest;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface DepositoryRecordService {
    /**
     * 开通存管账户
     *
     * @param consumerRequest 开户信息
     * @return
     */
    GatewayRequest createConsumer(ConsumerRequest consumerRequest);
}
