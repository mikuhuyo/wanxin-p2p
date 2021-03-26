package com.wanxin.api.repayment;

import com.wanxin.api.transaction.model.ProjectWithTendersDTO;
import com.wanxin.common.domain.RestResponse;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface RepaymentAPI {
    /**
     * 启动还款
     *
     * @param projectWithTendersDTO
     * @return
     */
    RestResponse<String> startRepayment(ProjectWithTendersDTO projectWithTendersDTO);
}
