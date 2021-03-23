package com.wanxin.api.depository.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * <P>
 * 预授权处理请求信息
 * </p>
 *
 * @author yuelimin
 * @since 1.8
 */
@Data
@ApiModel(value = "UserAutoPreTransactionRequest", description = "预授权处理请求信息")
public class UserAutoPreTransactionRequest {

    @ApiModelProperty("冻结金额")
    private BigDecimal amount;

    @ApiModelProperty("请求流水号")
    private String requestNo;

    @ApiModelProperty("投资人用户编码")
    private String userNo;

    @ApiModelProperty("预处理业务类型")
    private String bizType;

    @ApiModelProperty("红包金额")
    private BigDecimal preMarketingAmount;

    @ApiModelProperty("备注")
    private String remark;

    @ApiModelProperty("标的号")
    private String projectNo;

    @ApiModelProperty("债权出让流水号, 购买债权时需填此参数")
    private String creditsaleRequestNo;

    @ApiModelProperty("预处理业务ID")
    private Long id;
}
