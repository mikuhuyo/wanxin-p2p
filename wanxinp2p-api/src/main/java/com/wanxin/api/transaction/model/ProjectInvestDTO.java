package com.wanxin.api.transaction.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <P>
 * 投标信息
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@ApiModel(value = "ProjectInvestDTO", description = "用户投标信息")
public class ProjectInvestDTO {

    @ApiModelProperty("标的标识")
    private Long id;

    @ApiModelProperty("投标金额")
    private String amount;
}
