package com.wanxin.api.repayment.model;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Map;

/**
 * <P>
 * 等额本金: 是指一种贷款的还款方式, 是在还款期内把贷款数总额等分,
 * 每月偿还同等数额的本金和剩余贷款在该月所产生的利息, 这样由于每月的还款本金额固定,
 * 而利息越来越少, 借款人起初还款压力较大, 但是随时间的推移每月还款数也越来越少.
 * 公式: 每月偿还本金=(贷款本金÷还款月数) + (贷款本金-已归还本金累计额) × 月利率
 * </p>
 *
 * @author yuelimin
 * @since 1.8
 */
@Data
public class EqualPrincipalRepayment {
    /**
     * 每月还款本息
     */
    private Map<Integer, BigDecimal> amountMap;
    /**
     * 每月还款利息, 期数:利息
     */
    private Map<Integer, BigDecimal> interestMap;
    /**
     * 每月还款本金, 期数:本金
     */
    private BigDecimal principal;
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
