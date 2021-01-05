package com.wanxin.depository.config;

import com.wanxin.depository.interceptor.DepositoryNotifyVerificationInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.annotation.Resource;

/**
 * @author yuelimin
 * @since 1.8
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Resource
    private DepositoryNotifyVerificationInterceptor notifyVerificationInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(notifyVerificationInterceptor).addPathPatterns("/gateway/**");
    }
}
