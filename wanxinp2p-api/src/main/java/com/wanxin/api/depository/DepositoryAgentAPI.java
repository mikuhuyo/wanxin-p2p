package com.wanxin.api.depository;

import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.RestResponse;

/**
 * <p>
 * 银行存管系统代理服务API
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface DepositoryAgentAPI {
    /**
     * 开通存管账户
     *
     * @param consumerRequest 开户信息
     * @return
     */
    RestResponse<GatewayRequest> createConsumer(ConsumerRequest consumerRequest);
}
