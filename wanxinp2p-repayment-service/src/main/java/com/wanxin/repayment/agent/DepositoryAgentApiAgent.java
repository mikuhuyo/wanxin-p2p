package com.wanxin.repayment.agent;

import com.wanxin.api.depository.model.UserAutoPreTransactionRequest;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.common.domain.CommonErrorCode;
import com.wanxin.common.domain.RestResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@FeignClient(
        value = "depository-agent-service",
        fallback = DepositoryAgentApiAgentFallback.class,
        configuration = {DepositoryAgentApiAgentConfiguration.class}
)
public interface DepositoryAgentApiAgent {

    /**
     * 还款预处理
     *
     * @param userAutoPreTransactionRequest
     * @return
     */
    @PostMapping("/depository/l/user-auto-pre-transaction")
    RestResponse<String> userAutoPreTransaction(UserAutoPreTransactionRequest userAutoPreTransactionRequest);
}

class DepositoryAgentApiAgentFallback implements DepositoryAgentApiAgent {

    @Override
    public RestResponse<String> userAutoPreTransaction(UserAutoPreTransactionRequest userAutoPreTransactionRequest) {
        throw new BusinessException(CommonErrorCode.E_999996);
    }
}

class DepositoryAgentApiAgentConfiguration {
    @Bean
    public DepositoryAgentApiAgentFallback depositoryAgentApiAgentFallback() {
        return new DepositoryAgentApiAgentFallback();
    }
}
