package com.wanxin.api.consumer.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * <P>
 * 封装平台c端用户详细信息
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@ApiModel(value = "ConsumerDetailsDTO", description = "平台c端用户详细信息")
public class ConsumerDetailsDTO {

    @ApiModelProperty("用户id")
    private Long id;

    @ApiModelProperty("用户标识")
    private Long consumerId;

    @ApiModelProperty("身份证号")
    private String idCardNo;

    @ApiModelProperty("身份证照片面标识")
    private String idCardPhoto;

    @ApiModelProperty("身份证国徽面标识")
    private String idCardEmblem;

    @ApiModelProperty("住址")
    private String address;

    @ApiModelProperty("企业邮箱")
    private String enterpriseMail;

    @ApiModelProperty("联系人关系")
    private String contactRelation;

    @ApiModelProperty("身份证姓名")
    private String contactName;

    @ApiModelProperty("联系人电话")
    private String contactMobile;

    @ApiModelProperty("创建时间")
    private LocalDateTime uploadDate;

    @ApiModelProperty("真实姓名")
    private String fullname;

    @ApiModelProperty("身份证号")
    private String idNumber;

}
