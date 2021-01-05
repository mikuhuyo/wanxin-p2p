package com.wanxin.api.depository.model;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <P>
 * 开户返回参数信息
 * </p>
 *
 * @author yuelimin
 * @since 1.8
 */
@Data
public class DepositoryConsumerResponse extends DepositoryBaseResponse {
    @ApiModelProperty("银行代码")
    private String bankCode;

    @ApiModelProperty("银行名称")
    private String bankName;
}
