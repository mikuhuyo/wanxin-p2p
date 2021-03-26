package com.wanxin.repayment.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 借款人还款计划
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@TableName("repayment_plan")
public class RepaymentPlan implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId("ID")
    private Long id;

    /**
     * 发标人用户标识
     */
    @TableField("CONSUMER_ID")
    private Long consumerId;

    /**
     * 发标人用户编码
     */
    @TableField("USER_NO")
    private String userNo;

    /**
     * 标的标识
     */
    @TableField("PROJECT_ID")
    private Long projectId;

    /**
     * 标的编码
     */
    @TableField("PROJECT_NO")
    private String projectNo;

    /**
     * 期数
     */
    @TableField("NUMBER_OF_PERIODS")
    private Integer numberOfPeriods;

    /**
     * 还款利息
     */
    @TableField("INTEREST")
    private BigDecimal interest;

    /**
     * 还款本金
     */
    @TableField("PRINCIPAL")
    private BigDecimal principal;

    /**
     * 本息
     */
    @TableField("AMOUNT")
    private BigDecimal amount;

    /**
     * 应还时间
     */
    @TableField("SHOULD_REPAYMENT_DATE")
    private LocalDateTime shouldRepaymentDate;

    /**
     * 应还状态0.待还,1.已清完.2.部分还款
     */
    @TableField("REPAYMENT_STATUS")
    private String repaymentStatus;

    /**
     * 计划创建时间
     */
    @TableField("CREATE_DATE")
    private LocalDateTime createDate;

    /**
     * 借款人让利
     */
    @TableField("COMMISSION")
    private BigDecimal commission;

}
