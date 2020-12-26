package com.wanxin.uaa.agent;

import com.wanxin.api.account.model.AccountDTO;
import com.wanxin.api.account.model.AccountLoginDTO;
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
@FeignClient(value = "account-service",
        configuration = AccountApiAgentConfig.class,
        fallback = AccountApiAgentFallback.class)
public interface AccountApiAgent {
    @PostMapping(value = "/account/l/accounts/session")
    RestResponse<AccountDTO> login(@RequestBody AccountLoginDTO accountLoginDTO);
}

class AccountApiAgentConfig {
    @Bean
    public AccountApiAgentFallback accountApiAgentFallback() {
        return new AccountApiAgentFallback();
    }
}

class AccountApiAgentFallback implements AccountApiAgent {
    @Override
    public RestResponse<AccountDTO> login(AccountLoginDTO accountLoginDTO) {
        throw new BusinessException(CommonErrorCode.E_999995);
    }
}
