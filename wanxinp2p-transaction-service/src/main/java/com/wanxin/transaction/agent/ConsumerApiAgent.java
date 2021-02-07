package com.wanxin.transaction.agent;

import com.wanxin.api.consumer.model.ConsumerDTO;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.common.domain.CommonErrorCode;
import com.wanxin.common.domain.RestResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@FeignClient(
        value = "consumer-service",
        fallback = ConsumerApiAgentFallback.class,
        configuration = {ConsumerApiAgentConfiguration.class}
)
public interface ConsumerApiAgent {
    /**
     * 获取当前登录用户信息
     *
     * @return
     */
    @GetMapping("/my/consumers")
    RestResponse<ConsumerDTO> getCurrentLoginConsumer();
}

class ConsumerApiAgentFallback implements ConsumerApiAgent {
    @Override
    public RestResponse<ConsumerDTO> getCurrentLoginConsumer() {
        throw new BusinessException(CommonErrorCode.E_999995);
    }
}

class ConsumerApiAgentConfiguration {
    @Bean
    public ConsumerApiAgentFallback consumerApiAgentFallback() {
        return new ConsumerApiAgentFallback();
    }
}
