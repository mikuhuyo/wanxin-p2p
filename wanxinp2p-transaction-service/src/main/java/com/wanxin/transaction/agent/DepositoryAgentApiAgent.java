package com.wanxin.transaction.agent;

import com.wanxin.api.depository.model.UserAutoPreTransactionRequest;
import com.wanxin.api.transaction.model.ProjectDTO;
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
        configuration = {DepositoryAgentApiAgentConfiguration.class}
)
public interface DepositoryAgentApiAgent {
    /**
     * 预处理冻结远程调用
     *
     * @param userAutoPreTransactionRequest 预处理信息
     * @return
     */
    @PostMapping("/depository/l/user-auto-pre-transaction")
    RestResponse<String> userAutoPreTransaction(UserAutoPreTransactionRequest userAutoPreTransactionRequest);

    /**
     * 存管代理新增项目
     *
     * @param projectDTO 项目信息
     * @return 提示信息
     */
    @PostMapping(value = "/depository/l/create-project")
    RestResponse<String> createProject(@RequestBody ProjectDTO projectDTO);
}

class DepositoryAgentApiAgentFallback implements DepositoryAgentApiAgent {

    @Override
    public RestResponse<String> userAutoPreTransaction(UserAutoPreTransactionRequest userAutoPreTransactionRequest) {
        throw new BusinessException(CommonErrorCode.E_999996);
    }

    @Override
    public RestResponse<String> createProject(ProjectDTO projectDTO) {
        throw new BusinessException(CommonErrorCode.E_999996);
    }
}

class DepositoryAgentApiAgentConfiguration {
    @Bean
    public DepositoryAgentApiAgentFallback depositoryAgentApiAgentFallback() {
        return new DepositoryAgentApiAgentFallback();
    }
}
