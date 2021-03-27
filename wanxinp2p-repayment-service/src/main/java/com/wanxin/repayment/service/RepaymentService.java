package com.wanxin.repayment.service;

import com.wanxin.api.transaction.model.ProjectWithTendersDTO;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface RepaymentService {
    /**
     * 启动还款
     *
     * @param projectWithTendersDTO
     * @return
     */
    String startRepayment(ProjectWithTendersDTO projectWithTendersDTO);
}
