package com.wanxin.uaa.domain;

import org.apache.commons.lang.StringUtils;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.AbstractUserDetailsAuthenticationProvider;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Map;

/**
 * 统一用户认证处理, 集成了网页(简化模式, 授权码模式用户登录)认证  与  password模式认证
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class IntegrationUserDetailsAuthenticationProvider extends AbstractUserDetailsAuthenticationProvider {

    private IntegrationUserDetailsAuthenticationHandler authenticationHandler = null;

    public IntegrationUserDetailsAuthenticationProvider(IntegrationUserDetailsAuthenticationHandler authenticationHandler) {
        this.authenticationHandler = authenticationHandler;
    }

    @Override
    @SuppressWarnings("deprecation")
    protected void additionalAuthenticationChecks(UserDetails userDetails, UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {
        // 仅在父类中验证用户的状态
    }


    @Override
    protected final UserDetails retrieveUser(String username, UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {
        try {

            UserDetails loadedUser = authenticationUser(authentication);
            if (loadedUser == null) {
                throw new InternalAuthenticationServiceException("UserDetailsService returned null, which is an interface contract violation");
            }
            return loadedUser;
        } catch (UsernameNotFoundException ex) {
            throw ex;
        } catch (InternalAuthenticationServiceException ex) {
            throw ex;
        } catch (Exception ex) {
            throw new InternalAuthenticationServiceException(ex.getMessage(), ex);
        }
    }

    private UserDetails authenticationUser(UsernamePasswordAuthenticationToken authentication) {

        Object details = authentication.getDetails();
        String domain = null;
        String authenticationType = null;
        // 网页(简化模式, 授权码模式用户登录)认证
        if (details instanceof IntegrationWebAuthenticationDetails) {
            IntegrationWebAuthenticationDetails webAuthenticationDetails = (IntegrationWebAuthenticationDetails) details;
            domain = webAuthenticationDetails.getDomain();
            authenticationType = webAuthenticationDetails.getAuthenticationType();
        } else if (details instanceof Map) { // password模式认证
            Map<String, String> webAuthenticationDetails = (Map) details;
            domain = webAuthenticationDetails.get("domain");
            authenticationType = webAuthenticationDetails.get("authenticationType");
        } else { // 超出预估的情况
            throw new InternalAuthenticationServiceException("WebAuthenticationDetails type is not support");
        }

        if (StringUtils.isBlank(domain)) {
            throw new InternalAuthenticationServiceException("domain is blank");
        }

        if (StringUtils.isBlank(authenticationType)) {
            throw new InternalAuthenticationServiceException("authenticationType is blank");
        }
        return authenticationHandler.authentication(domain, authenticationType, authentication);
    }

}
