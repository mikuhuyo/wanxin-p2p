package com.wanxin.transaction.interceptor;

import feign.RequestInterceptor;
import feign.RequestTemplate;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@Configuration
public class OpenFeignInterceptor implements RequestInterceptor {

    @Override
    public void apply(RequestTemplate requestTemplate) {

        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        // 注意: RequestContextHolder依赖于 ThreadLocal,
        // 所以在hystrix的隔离策略为THREAD, MQ的消费者, 定时任务调用FeignClient时, 此处应为null.
        if (attributes == null) {
            return;
        }

        HttpServletRequest request = attributes.getRequest();
        String jsonToken = request.getHeader("jsonToken");
        if (jsonToken != null) {
            requestTemplate.header("jsonToken", jsonToken);
        }
    }
}
