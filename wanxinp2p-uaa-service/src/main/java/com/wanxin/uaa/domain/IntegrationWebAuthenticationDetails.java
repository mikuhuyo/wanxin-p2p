package com.wanxin.uaa.domain;

import org.springframework.security.web.authentication.WebAuthenticationDetails;

import javax.servlet.http.HttpServletRequest;

/**
 * web AuthenticationDetails 自定义,
 * 针对web网页用户认证,
 * 由于网页端用户认证(认证码模式, 简化模式)会走UsernamePasswordAuthenticationFilter,
 * 把request中的额外信息增加至WebAuthenticationDetails.
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class IntegrationWebAuthenticationDetails extends WebAuthenticationDetails {

    private final String domain;

    private final String key;

    private final String authenticationType;

    public IntegrationWebAuthenticationDetails(HttpServletRequest request) {
        super(request);
        domain = request.getParameter("domain");
        key = request.getParameter("key");
        authenticationType = request.getParameter("authenticationType");
    }


    public String getDomain() {
        return domain;
    }

    public String getKey() {
        return key;
    }

    public String getAuthenticationType() {
        return authenticationType;
    }

}
