package com.wanxin.transaction.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

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
@TableName(value = "tender")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
public class Tender implements Serializable {

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
     * 投标人用户名
     */
    @TableField("CONSUMER_USERNAME")
    private String consumerUsername;

    /**
     * 投标人用户编码
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
     * 投标冻结金额
     */
    @TableField("AMOUNT")
    private BigDecimal amount;

    /**
     * 投标状态
     */
    @TableField("TENDER_STATUS")
    private String tenderStatus;

    /**
     * 创建时间
     */
    @TableField("CREATE_DATE")
    // private LocalDateTime createDate;
    private Date createDate;

    /**
     * 投标/债权转让 请求流水号
     */
    @TableField("REQUEST_NO")
    private String requestNo;

    /**
     * 可用状态
     */
    @TableField("STATUS")
    private Integer status;

    /**
     * 标的名称
     */
    @TableField("PROJECT_NAME")
    private String projectName;

    /**
     * 标的期限(单位:天) -- 冗余字段
     */
    @TableField("PROJECT_PERIOD")
    private Integer projectPeriod;

    /**
     * 年化利率(投资人视图) -- 冗余字段
     */
    @TableField("PROJECT_ANNUAL_RATE")
    private BigDecimal projectAnnualRate;
}
