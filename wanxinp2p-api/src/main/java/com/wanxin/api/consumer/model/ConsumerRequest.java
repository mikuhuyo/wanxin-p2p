package com.wanxin.api.consumer.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@ApiModel(value = "ConsumerRequest", description = "平台c端用户开户信息")
public class ConsumerRequest {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("真实姓名")
    private String fullname;

    @ApiModelProperty("身份证号")
    private String idNumber;

    @ApiModelProperty("银行编码")
    private String bankCode;

    @ApiModelProperty("银行卡号")
    private String cardNumber;

    @ApiModelProperty("手机号")
    private String mobile;

    @ApiModelProperty("角色")
    private String role;

    @ApiModelProperty("请求流水号")
    private String requestNo;

    @ApiModelProperty("用户编号")
    private String userNo;

    @ApiModelProperty("页面回跳 URL")
    private String callbackUrl;

}
