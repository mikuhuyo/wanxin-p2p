package com.wanxin.uaa.domain;

import com.wanxin.common.util.DateUtil;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class OauthClientDetails implements Serializable {
    private static final long serialVersionUID = -6947822646185526939L;

    private LocalDateTime createTime = DateUtil.now();
    private boolean archived = false;

    private String clientId;
    private String resourceIds;

    private String clientSecret;
    /**
     * Available values: read,write
     */
    private String scope;

    /**
     * grant types include
     * "authorization_code", "password", "assertion", and "refresh_token".
     * Default value is "authorization_code,refresh_token".
     */
    private String authorizedGrantTypes = "authorization_code,refresh_token";

    /**
     * The re-direct URI(s) established during registration (optional, comma separated).
     */
    private String webServerRedirectUri;

    /**
     * Authorities that are granted to the client (comma-separated). Distinct from the authorities
     * granted to the user on behalf of whom the client is acting.
     * <p/>
     * For example: ROLE_USER
     */
    private String authorities;

    /**
     * The access token validity period in seconds (optional).
     * If unspecified a global default will be applied by the token services.
     */
    private Integer accessTokenValidity;

    /**
     * The refresh token validity period in seconds (optional).
     * If unspecified a global default will  be applied by the token services.
     */
    private Integer refreshTokenValidity;

    // optional
    private String additionalInformation;

    /**
     * The client is trusted or not. If it is trust, will skip approve step
     * default false.
     */
    private boolean trusted = false;

    /**
     * Value is 'true' or 'false',  default 'false'
     */
    private String autoApprove;

    public OauthClientDetails() {
    }

    public String autoApprove() {
        return autoApprove;
    }

    public OauthClientDetails autoApprove(String autoApprove) {
        this.autoApprove = autoApprove;
        return this;
    }

    public boolean trusted() {
        return trusted;
    }

    public LocalDateTime createTime() {
        return createTime;
    }

    public OauthClientDetails createTime(LocalDateTime createTime) {
        this.createTime = createTime;
        return this;
    }

    public boolean archived() {
        return archived;
    }

    public String clientId() {
        return clientId;
    }

    public String resourceIds() {
        return resourceIds;
    }

    public String clientSecret() {
        return clientSecret;
    }

    public String scope() {
        return scope;
    }

    public String authorizedGrantTypes() {
        return authorizedGrantTypes;
    }

    public String webServerRedirectUri() {
        return webServerRedirectUri;
    }

    public String authorities() {
        return authorities;
    }

    public Integer accessTokenValidity() {
        return accessTokenValidity;
    }

    public Integer refreshTokenValidity() {
        return refreshTokenValidity;
    }

    public String additionalInformation() {
        return additionalInformation;
    }


    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder();
        sb.append("OauthClientDetails");
        sb.append("{createTime=").append(createTime);
        sb.append(", archived=").append(archived);
        sb.append(", clientId='").append(clientId).append('\'');
        sb.append(", resourceIds='").append(resourceIds).append('\'');
        sb.append(", clientSecret='").append(clientSecret).append('\'');
        sb.append(", scope='").append(scope).append('\'');
        sb.append(", authorizedGrantTypes='").append(authorizedGrantTypes).append('\'');
        sb.append(", webServerRedirectUri='").append(webServerRedirectUri).append('\'');
        sb.append(", authorities='").append(authorities).append('\'');
        sb.append(", accessTokenValidity=").append(accessTokenValidity);
        sb.append(", refreshTokenValidity=").append(refreshTokenValidity);
        sb.append(", additionalInformation='").append(additionalInformation).append('\'');
        sb.append(", trusted=").append(trusted);
        sb.append('}');
        return sb.toString();
    }

    public OauthClientDetails clientId(String clientId) {
        this.clientId = clientId;
        return this;
    }

    public OauthClientDetails clientSecret(String clientSecret) {
        this.clientSecret = clientSecret;
        return this;
    }

    public OauthClientDetails resourceIds(String resourceIds) {
        this.resourceIds = resourceIds;
        return this;
    }

    public OauthClientDetails authorizedGrantTypes(String authorizedGrantTypes) {
        this.authorizedGrantTypes = authorizedGrantTypes;
        return this;
    }

    public OauthClientDetails scope(String scope) {
        this.scope = scope;
        return this;
    }

    public OauthClientDetails webServerRedirectUri(String webServerRedirectUri) {
        this.webServerRedirectUri = webServerRedirectUri;
        return this;
    }

    public OauthClientDetails authorities(String authorities) {
        this.authorities = authorities;
        return this;
    }

    public OauthClientDetails accessTokenValidity(Integer accessTokenValidity) {
        this.accessTokenValidity = accessTokenValidity;
        return this;
    }

    public OauthClientDetails refreshTokenValidity(Integer refreshTokenValidity) {
        this.refreshTokenValidity = refreshTokenValidity;
        return this;
    }

    public OauthClientDetails trusted(boolean trusted) {
        this.trusted = trusted;
        return this;
    }

    public OauthClientDetails additionalInformation(String additionalInformation) {
        this.additionalInformation = additionalInformation;
        return this;
    }

    public OauthClientDetails archived(boolean archived) {
        this.archived = archived;
        return this;
    }
}
