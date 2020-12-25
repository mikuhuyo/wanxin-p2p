package com.wanxin.uaa.config;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.springframework.security.oauth2.common.exceptions.OAuth2Exception;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@JsonSerialize(using = RestOAuthExceptionJacksonSerializer.class)
public class RestOAuth2Exception extends OAuth2Exception {

    public RestOAuth2Exception(String msg, Throwable t) {
        super(msg, t);
    }

    public RestOAuth2Exception(String msg) {
        super(msg);
    }
}
