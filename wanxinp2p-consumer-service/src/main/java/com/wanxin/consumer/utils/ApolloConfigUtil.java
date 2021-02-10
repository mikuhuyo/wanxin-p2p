package com.wanxin.consumer.utils;

import com.ctrip.framework.apollo.Config;
import com.ctrip.framework.apollo.spring.annotation.ApolloConfig;
import com.ctrip.framework.apollo.spring.annotation.EnableApolloConfig;
import org.springframework.stereotype.Service;

/**
 * 本类用于获取配置文件中的配置
 *
 * @author yuelimin
 * @since 1.8
 */
@Service
@EnableApolloConfig
public class ApolloConfigUtil {
    @ApolloConfig
    private static Config config;

    /**
     * 银行存管系统服务地址
     *
     * @return
     */
    public static String getDepositoryUrl() {
        return config.getProperty("depository.url", null);
    }
}
