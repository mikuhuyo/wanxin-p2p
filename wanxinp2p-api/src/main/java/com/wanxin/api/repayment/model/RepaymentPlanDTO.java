package com.wanxin.api.repayment.model;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
public class RepaymentPlanDTO {
    /**
     * 主键
     */
    private Long id;

    /**
     * 发标人用户标识
     */
    private Long consumerId;

    /**
     * 发标人用户编码
     */
    private String userNo;

    /**
     * 标的标识
     */
    private Long projectId;

    /**
     * 标的编码
     */
    private String projectNo;

    /**
     * 期数
     */
    private Integer numberOfPeriods;

    /**
     * 还款利息
     */
    private BigDecimal interest;

    /**
     * 还款本金
     */
    private BigDecimal principal;

    /**
     * 本息
     */
    private BigDecimal amount;

    /**
     * 应还时间
     */
    private LocalDateTime shouldRepaymentDate;

    /**
     * 应还状态0.待还,1.已清完.2.部分还款
     */
    private String repaymentStatus;

    /**
     * 计划创建时间
     */
    private LocalDateTime createDate;

    /**
     * 借款人让利
     */
    private BigDecimal commission;
}
