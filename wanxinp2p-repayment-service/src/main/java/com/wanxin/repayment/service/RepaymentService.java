package com.wanxin.repayment.service;

import com.wanxin.api.repayment.model.RepaymentPlanDTO;
import com.wanxin.api.transaction.model.ProjectWithTendersDTO;
import com.wanxin.repayment.entity.RepaymentDetail;
import com.wanxin.repayment.entity.RepaymentPlan;

import java.util.List;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface RepaymentService {

    /**
     * 还款预处理-冻结借款人应还金额
     *
     * @param repaymentPlan
     * @param preRequestNo
     * @return
     */
    Boolean preRepayment(RepaymentPlan repaymentPlan, String preRequestNo);

    /**
     * 根据还款计划生成还款明细并保存
     *
     * @param repaymentPlan
     * @return
     */
    RepaymentDetail saveRepaymentDetail(RepaymentPlan repaymentPlan);

    /**
     * 查询到期还款计划
     *
     * @param date yyyy-MM-dd
     * @return
     */
    List<RepaymentPlanDTO> selectDueRepayment(String date);

    /**
     * 启动还款
     *
     * @param projectWithTendersDTO
     * @return
     */
    String startRepayment(ProjectWithTendersDTO projectWithTendersDTO);
}
