package com.wanxin.api.account.model;

import lombok.Data;

/**
 * 当前登录用户
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
