package com.wanxin.api.depository.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 存管交易记录表
 * </p>
 *
 * @author yuelimin
 * @since 1.8
 */
@Data
@EqualsAndHashCode(callSuper = false)
@ApiModel(value = "DepositoryRecordDTO对象", description = "存管交易记录表")
public class DepositoryRecordDTO implements Serializable {
    @ApiModelProperty(value = "主键")
    private Long id;

    @ApiModelProperty(value = "请求流水号")
    private String requestNo;

    @ApiModelProperty(value = "请求类型:1.用户信息(新增, 编辑) 2.绑卡信息")
    private String requestType;

    @ApiModelProperty(value = "业务实体类型")
    private String objectType;

    @ApiModelProperty(value = "关联业务实体标识")
    private Long objectId;

    @ApiModelProperty(value = "请求时间")
    private LocalDateTime createDate;

    @ApiModelProperty(value = "是否是同步调用")
    private Integer isSyn;

    @ApiModelProperty(value = "数据同步状态")
    private Integer requestStatus;

    @ApiModelProperty(value = "消息确认时间")
    private LocalDateTime confirmDate;

    @ApiModelProperty("返回数据")
    private String responseData;
}
