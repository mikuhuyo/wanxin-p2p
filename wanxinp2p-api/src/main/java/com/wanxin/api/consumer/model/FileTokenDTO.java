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
@ApiModel(value = "FileTokenDTO", description = "上传文件凭证")
public class FileTokenDTO {
    @ApiModelProperty("应用ID")
    private String appId;

    @ApiModelProperty("ak")
    private String accessKey;

    @ApiModelProperty("sk")
    private String secretKey;
}
