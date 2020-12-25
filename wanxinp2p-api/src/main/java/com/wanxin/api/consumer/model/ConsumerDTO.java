package com.wanxin.api.consumer.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@ApiModel(value = "ConsumerDTO", description = "平台c端用户信息")
public class ConsumerDTO {

    @ApiModelProperty("用户id")
    private Long id;

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("真实姓名")
    private String fullname;

    @ApiModelProperty("身份证号")
    private String idNumber;

    @ApiModelProperty("用户编码, 用户在存管系统标识, 不允许重复")
    private String userNo;

    @ApiModelProperty("手机号")
    private String mobile;

    @ApiModelProperty("用户类型, 个人 or 企业, 预留")
    private String userType;

    @ApiModelProperty("角色")
    private String role;

    @ApiModelProperty("存管授权列表")
    private String authList;

    @ApiModelProperty("是否已绑定银行卡")
    private Integer isBindCard;

    @ApiModelProperty("启用状态")
    private Integer status;

    @ApiModelProperty("可贷额度")
    private BigDecimal loanAmount;

}
