package com.wanxin.uaa.config;

import com.wanxin.uaa.domain.OauthClientDetails;
import com.wanxin.uaa.service.OauthService;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.provider.AuthorizationRequest;
import org.springframework.security.oauth2.provider.approval.TokenStoreUserApprovalHandler;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class OauthUserApprovalHandler extends TokenStoreUserApprovalHandler {

    private OauthService oauthService;

    public OauthUserApprovalHandler() {
    }

    @Override
    public boolean isApproved(AuthorizationRequest authorizationRequest, Authentication userAuthentication) {
        if (super.isApproved(authorizationRequest, userAuthentication)) {
            return true;
        }
        if (!userAuthentication.isAuthenticated()) {
            return false;
        }

        OauthClientDetails clientDetails = oauthService.loadOauthClientDetails(authorizationRequest.getClientId());
        return clientDetails != null && clientDetails.trusted();

    }

    public void setOauthService(OauthService oauthService) {
        this.oauthService = oauthService;
    }
}
