package com.wanxin.consumer.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 用户详细信息表
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@TableName("consumer_details")
public class ConsumerDetails implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "ID", type = IdType.AUTO)
    private Long id;

    /**
     * 用户标识
     */
    @TableField("CONSUMER_ID")
    private Long consumerId;

    /**
     * 身份证照片面标识
     */
    @TableField("ID_CARD_PHOTO")
    private String idCardPhoto;

    /**
     * 身份证国徽面标识
     */
    @TableField("ID_CARD_EMBLEM")
    private String idCardEmblem;

    /**
     * 住址
     */
    @TableField("ADDRESS")
    private String address;

    /**
     * 企业邮箱
     */
    @TableField("ENTERPRISE_MAIL")
    private String enterpriseMail;

    /**
     * 联系人关系
     */
    @TableField("CONTACT_RELATION")
    private String contactRelation;

    /**
     * 联系人姓名
     */
    @TableField("CONTACT_NAME")
    private String contactName;

    /**
     * 联系人电话
     */
    @TableField("CONTACT_MOBILE")
    private String contactMobile;

    /**
     * 创建时间
     */
    @TableField("CREATE_DATE")
    private LocalDateTime uploadDate;

}
