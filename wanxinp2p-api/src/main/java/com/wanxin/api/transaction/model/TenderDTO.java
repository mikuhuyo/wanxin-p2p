package com.wanxin.api.transaction.model;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 投标信息表
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
public class TenderDTO {
    /**
     * 主键
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    /**
     * 投标人用户标识
     */
    private Long consumerId;

    /**
     * 投标人用户名
     */
    private String consumerUsername;

    /**
     * 投标人用户编码
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
     * 投标冻结金额
     */
    private BigDecimal amount;

    /**
     * 投标状态
     */
    private String tenderStatus;

    /**
     * 创建时间
     */
    private LocalDateTime createDate;

    /**
     * 投标/债权转让 请求流水号
     */
    private String requestNo;

    /**
     * 可用状态
     */
    private Integer status;

    /**
     * 标的名称
     */
    private String projectName;

    /**
     * 标的期限(单位:天) -- 冗余字段
     */
    private Integer projectPeriod;

    /**
     * 年化利率(投资人视图) -- 冗余字段
     */
    private BigDecimal projectAnnualRate;

    /**
     * 标的信息
     */
    private ProjectDTO project;

    /**
     * 预期收益
     */
    private BigDecimal expectedIncome;

}
