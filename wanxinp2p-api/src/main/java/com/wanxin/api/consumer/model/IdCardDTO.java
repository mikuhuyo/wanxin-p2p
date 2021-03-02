package com.wanxin.api.consumer.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@ApiModel(value = "IdCardDTO", description = "百度ORC识别身份证信息")
public class IdCardDTO {
    @ApiModelProperty("正反面")
    private String flag;

    @ApiModelProperty("ORC识别身份证号码")
    private String idCardNo;

    @ApiModelProperty("ORC识别身份证姓名")
    private String idCardName;

    @ApiModelProperty("ORC识别身份证地址")
    private String idCardAddress;

    @ApiModelProperty("ORC识别上传时间")
    private LocalDateTime uploadTime;
}
