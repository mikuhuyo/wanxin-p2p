package com.wanxin.gateway.filter;

import com.alibaba.fastjson.JSON;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import com.wanxin.common.util.EncryptUtil;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * @author yuelimin
 */
@Component
public class AuthFilter extends ZuulFilter {
    @Override
    public boolean shouldFilter() {
        return true;
    }

    @Override
    public String filterType() {
        // 前置过滤器, 可以在请求被路由之前调用
        return "pre";
    }

    @Override
    public int filterOrder() {
        return 0;
    }

    @Override
    public Object run() {
        // 获得请求的上下文
        RequestContext requestContext = RequestContext.getCurrentContext();
        // 获取Spring Security OAuth2的认证信息对象
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof OAuth2Authentication)) {
            // 无token访问网关内资源, 直接返回null
            return null;
        }

        // 将当前登录的用户以及接入客户端的信息放入Map中
        OAuth2Authentication oauth2Authentication = (OAuth2Authentication) authentication;
        Map<String, String> jsonToken = new HashMap<>(oauth2Authentication.getOAuth2Request().getRequestParameters());
        if (jsonToken.get("mobile") != null) {
            requestContext.addZuulRequestHeader("jsonToken", EncryptUtil.encodeUTF8StringBase64(JSON.toJSONString(jsonToken)));
        }
        return null;
    }
}
