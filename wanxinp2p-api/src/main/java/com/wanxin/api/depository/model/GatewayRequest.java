package com.wanxin.api.depository.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 与银行存管系统对接使用的签名请求数据
 *
 * @author yuelimin
 * @since 1.8
 */
@Data
@ApiModel(value = "GatewayRequest", description = "与银行存管系统对接使用的签名请求数据")
public class GatewayRequest {

    @ApiModelProperty("请求的存管接口名")
    private String serviceName;

    @ApiModelProperty("平台编号, 平台与存管系统签约时获取")
    private String platformNo;

    @ApiModelProperty("业务数据报文, json格式")
    private String reqData;

    @ApiModelProperty("对reqData参数的签名")
    private String signature;

    @ApiModelProperty("银行存管系统地址")
    private String depositoryUrl;
}
