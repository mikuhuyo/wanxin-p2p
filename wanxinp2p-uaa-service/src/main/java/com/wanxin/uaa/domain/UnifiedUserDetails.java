package com.wanxin.uaa.domain;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.*;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class UnifiedUserDetails implements UserDetails {

    private static final long serialVersionUID = 3957586021470480642L;

    /**
     * 用户的授权集合
     */
    protected List<GrantedAuthority> grantedAuthorities = new ArrayList<>();

    private String username;

    private String password;

    /**
     * 手机号
     */
    private String mobile;

    /**
     * 租户id
     */
    private String tenantId;

    /**
     * 部门id
     */
    private String departmentId;


    /**
     * 用户的角色权限集合, key为角色, value为角色下权限集合
     */
    private Map<String, List<String>> userAuthorities = new HashMap<>();


    /**
     * 用户附加信息,json字符串,统一认证透传
     */
    private Map<String, Object> payload = new HashMap<>();


    public UnifiedUserDetails(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public UnifiedUserDetails(String username, String password, List<GrantedAuthority> authorities) {
        this.username = username;
        this.password = password;
        grantedAuthorities.addAll(authorities);
    }


    @Override
    public Collection<GrantedAuthority> getAuthorities() {
        return this.grantedAuthorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    public Map<String, Object> getPayload() {
        return payload;
    }

    public void setPayload(Map<String, Object> payload) {
        this.payload = payload;
    }


    /* 账户是否未过期 */
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    /*账户是否未锁定 */
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    /* 密码是否未过期 */
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    /*账户是否启用,默认true (启用)*/
    @Override
    public boolean isEnabled() {
        return true;
    }


    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public Map<String, List<String>> getUserAuthorities() {
        return userAuthorities;
    }

    public void setUserAuthorities(Map<String, List<String>> userAuthorities) {
        this.userAuthorities = userAuthorities;
    }


}
