package com.wanxin.api.depository.model;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * <P>
 * 银行存管系统返回str, 转换的json对象
 * </p>
 *
 * @author yuelimin
 * @since 1.8
 */
@Data
public class DepositoryResponseDTO<T> implements Serializable {
    /**
     * 业务数据报文, JSON格式
     */
    @ApiModelProperty("业务数据报文，JSON格式")
    private T respData;

    /**
     * 签名
     */
    @ApiModelProperty("签名数据")
    private String signature;
}
