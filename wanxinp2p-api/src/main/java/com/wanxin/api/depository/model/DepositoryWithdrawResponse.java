package com.wanxin.api.depository.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * 存管提现响应信息
 * </p>
 *
 * @author yuelimin
 * @since 1.8
 */
@Data
@ApiModel(value = "WithdrawResponse", description = "用户提现请求返回信息")
public class DepositoryWithdrawResponse extends DepositoryBaseResponse {

    @ApiModelProperty("交易状态")
    private String transactionStatus;
}
