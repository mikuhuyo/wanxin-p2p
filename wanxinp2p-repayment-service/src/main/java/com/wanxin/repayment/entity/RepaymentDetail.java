package com.wanxin.repayment.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 借款人还款明细, 针对一个还款计划可多次进行还款
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("repayment_detail")
public class RepaymentDetail implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId("ID")
    private Long id;

    /**
     * 还款计划项标识
     */
    @TableField("REPAYMENT_PLAN_ID")
    private Long repaymentPlanId;

    /**
     * 实还本息
     */
    @TableField("AMOUNT")
    private BigDecimal amount;

    /**
     * 实际还款时间
     */
    @TableField("REPAYMENT_DATE")
    private LocalDateTime repaymentDate;

    /**
     * 冻结用户资金请求流水号(用于解冻合并整体还款),
     * 有漏洞, 存管不支持单次“确定还款”, 合并多个还款预处理的操作, 折中做法.
     */
    @TableField("REQUEST_NO")
    private String requestNo;

    /**
     * 可用状态
     */
    @TableField("STATUS")
    private Integer status;
}
