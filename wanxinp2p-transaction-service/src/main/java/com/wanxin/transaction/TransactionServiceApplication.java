package com.wanxin.transaction;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@EnableDiscoveryClient
@SpringBootApplication
@EnableConfigurationProperties
@EnableFeignClients(basePackages = {"com.wanxin.transaction.agent"})
public class TransactionServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(TransactionServiceApplication.class, args);
    }
}
