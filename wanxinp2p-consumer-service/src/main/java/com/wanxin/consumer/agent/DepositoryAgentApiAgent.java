package com.wanxin.consumer.agent;

import com.wanxin.api.consumer.model.ConsumerRequest;
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
     * 生成用户数据远程调用
     *
     * @param consumerRequest
     * @return
     */
    @PostMapping("/depository-agent/l/consumers")
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
    public RestResponse<GatewayRequest> createConsumer(ConsumerRequest consumerRequest) {
        throw new BusinessException(CommonErrorCode.E_999996);
    }
}
