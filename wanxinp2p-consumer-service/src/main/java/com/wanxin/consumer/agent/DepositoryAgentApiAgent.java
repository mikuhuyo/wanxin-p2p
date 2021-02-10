package com.wanxin.consumer.agent;

import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.consumer.model.RechargeRequest;
import com.wanxin.api.consumer.model.WithdrawRequest;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.common.domain.CommonErrorCode;
import com.wanxin.common.domain.RestResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@FeignClient(
        value = "depository-agent-service",
        fallback = DepositoryAgentApiAgentFallback.class,
        configuration = {DepositoryAgentApiAgentConfiguration.class})
public interface DepositoryAgentApiAgent {
    /**
     * 生成提现请求数据
     *
     * @param withdrawRequest
     * @return
     */
    @PostMapping("/depository/l/withdraws")
    RestResponse<GatewayRequest> createWithdrawRecord(@RequestBody WithdrawRequest withdrawRequest);

    /**
     * 生成充值请求数据
     *
     * @param rechargeRequest
     * @return
     */
    @PostMapping("/depository/l/recharges")
    RestResponse<GatewayRequest> createRechargeRecord(@RequestBody RechargeRequest rechargeRequest);

    /**
     * 生成用户数据远程调用
     *
     * @param consumerRequest
     * @return
     */
    @PostMapping("/depository/l/consumers")
    RestResponse<GatewayRequest> createConsumer(@RequestBody ConsumerRequest consumerRequest);
}

class DepositoryAgentApiAgentConfiguration {
    @Bean
    public DepositoryAgentApiAgentFallback depositoryAgentApiAgentFallback() {
        return new DepositoryAgentApiAgentFallback();
    }
}

class DepositoryAgentApiAgentFallback implements DepositoryAgentApiAgent {

    @Override
    public RestResponse<GatewayRequest> createWithdrawRecord(WithdrawRequest withdrawRequest) {
        throw new BusinessException(CommonErrorCode.E_999996);
    }

    @Override
    public RestResponse<GatewayRequest> createRechargeRecord(RechargeRequest rechargeRequest) {
        throw new BusinessException(CommonErrorCode.E_999996);
    }

    @Override
    public RestResponse<GatewayRequest> createConsumer(ConsumerRequest consumerRequest) {
        throw new BusinessException(CommonErrorCode.E_999996);
    }
}
