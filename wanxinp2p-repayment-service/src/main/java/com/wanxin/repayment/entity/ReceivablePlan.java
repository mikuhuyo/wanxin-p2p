package com.wanxin.repayment.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 投资人应收明细
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
public class ReceivablePlan implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId("ID")
    private Long id;

    /**
     * 投标人用户标识
     */
    @TableField("CONSUMER_ID")
    private Long consumerId;

    /**
     * 投标人用户编码
     */
    @TableField("USER_NO")
    private String userNo;

    /**
     * 投标信息标识
     */
    @TableField("TENDER_ID")
    private Long tenderId;

    /**
     * 还款计划项标识
     */
    @TableField("REPAYMENT_ID")
    private Long repaymentId;

    /**
     * 期数
     */
    @TableField("NUMBER_OF_PERIODS")
    private Integer numberOfPeriods;

    /**
     * 应收利息
     */
    @TableField("INTEREST")
    private BigDecimal interest;

    /**
     * 应收本金
     */
    @TableField("PRINCIPAL")
    private BigDecimal principal;

    /**
     * 应收本息
     */
    @TableField("AMOUNT")
    private BigDecimal amount;

    /**
     * 应收时间
     */
    @TableField("SHOULD_RECEIVABLE_DATE")
    private LocalDateTime shouldReceivableDate;

    /**
     * 状态：0,.未收 1.已收  2.部分收到
     */
    @TableField("RECEIVABLE_STATUS")
    private Integer receivableStatus;

    /**
     * 创建时间
     */
    @TableField("CREATE_DATE")
    private LocalDateTime createDate;

    /**
     * 投资人让利
     */
    @TableField("COMMISSION")
    private BigDecimal commission;

}
