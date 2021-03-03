package com.wanxin.api.transaction.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * <P>
 * 标的信息查询对象
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@ApiModel(value = "ProjectQueryDTO", description = "标的信息查询对象")
public class ProjectQueryDTO {

    @ApiModelProperty("标的类型")
    private String type;

    @ApiModelProperty("名称")
    private String name;

    @ApiModelProperty("起止标的期限(单位:天)")
    private Integer startPeriod;

    @ApiModelProperty("起止标的期限(单位:天)")
    private Integer endPeriod;

    @ApiModelProperty("起止年化利率(投资人视图)")
    private BigDecimal startAnnualRate;

    @ApiModelProperty("起止年化利率(投资人视图)")
    private BigDecimal endAnnualRate;

    @ApiModelProperty("年化利率(借款人视图)")
    private BigDecimal borrowerAnnualRate;

    @ApiModelProperty("还款方式")
    private String repaymentWay;

    @ApiModelProperty("标的状态")
    private String projectStatus;

    @ApiModelProperty("标的可用状态")
    private String status;

}
