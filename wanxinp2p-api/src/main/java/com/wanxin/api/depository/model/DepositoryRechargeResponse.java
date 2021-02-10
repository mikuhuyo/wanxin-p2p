package com.wanxin.api.depository.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * 存管充值响应信息
 * </p>
 *
 * @author yuelimin
 * @since 1.8
 */
@Data
@ApiModel(value = "RechargeResponse", description = "用户充值请求返回信息")
public class DepositoryRechargeResponse extends DepositoryBaseResponse {

    @ApiModelProperty("交易状态")
    private String transactionStatus;
}
