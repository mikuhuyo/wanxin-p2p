package com.wanxin.transaction;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@EnableDiscoveryClient
@EnableConfigurationProperties
@SpringBootApplication(exclude = {RedisAutoConfiguration.class, DataSourceAutoConfiguration.class})
public class TransactionServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(TransactionServiceApplication.class, args);
    }
}
