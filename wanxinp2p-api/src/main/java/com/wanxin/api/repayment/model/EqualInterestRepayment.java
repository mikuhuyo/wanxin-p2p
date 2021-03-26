package com.wanxin.api.repayment.model;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Map;

/**
 * <P>
 * 等额本息还款: 即借款人每月按相等的金额偿还贷款本息, 其中每月贷款利息按月初剩余贷款本金计算并逐月结清,
 * 把按揭贷款的本金总额与利息总额相加, 然后平均分摊到还款期限的每个月中.
 * 作为还款人, 每个月还给银行固定金额, 但每月还款额中的本金比重逐月递增, 利息比重逐月递减.
 * </p>
 *
 * @author yuelimin
 * @since 1.8
 */
@Data
public class EqualInterestRepayment {
    /**
     * 每月还款本息
     */
    private BigDecimal amount;
    /**
     * 每月还款利息, 期数:利息
     */
    private Map<Integer, BigDecimal> interestMap;
    /**
     * 每月还款本金, 期数:本金
     */
    private Map<Integer, BigDecimal> principalMap;
    /**
     * 本息总和
     */
    private BigDecimal totalAmount;
    /**
     * 总利息
     */
    private BigDecimal totalInterest;
    /**
     * 平台抽息
     */
    private Map<Integer, BigDecimal> commissionMap;
}
