package com.wanxin.consumer.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
@TableName("consumer")
public class Consumer implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "ID", type = IdType.AUTO)
    private Long id;

    /**
     * 用户名
     */
    @TableField("USERNAME")
    private String username;

    /**
     * 真实姓名
     */
    @TableField("FULLNAME")
    private String fullname;

    /**
     * 身份证号
     */
    @TableField("ID_NUMBER")
    private String idNumber;

    /**
     * 用户编码,生成唯一,用户在存管系统标识
     */
    @TableField("USER_NO")
    private String userNo;

    /**
     * 平台预留手机号
     */
    @TableField("MOBILE")
    private String mobile;

    /**
     * 用户类型,个人 or 企业, 预留
     */
    @TableField("USER_TYPE")
    private String userType;

    /**
     * 用户角色.借款人 or 投资人
     */
    @TableField("ROLE")
    private String role;

    /**
     * 存管授权列表
     */
    @TableField("AUTH_LIST")
    private String authList;

    /**
     * 是否已绑定银行卡
     */
    @TableField("IS_BIND_CARD")
    private Integer isBindCard;

    /**
     * 可用状态
     */
    @TableField("STATUS")
    private Integer status;

    /**
     * 可贷额度
     */
    @TableField("LOAN_AMOUNT")
    private BigDecimal loanAmount;

    /**
     * 请求流水号
     */
    @TableField("REQUEST_NO")
    private String requestNo;

}
