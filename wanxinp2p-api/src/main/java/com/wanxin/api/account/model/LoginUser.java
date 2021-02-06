package com.wanxin.api.account.model;

import lombok.Data;

/**
 * 当前登录用户
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
public class LoginUser {
    private String tenantId;
    private String departmentId;
    private String payload;
    private String username;
    private String mobile;
    private String userAuthorities;
    private String clientId;
}
