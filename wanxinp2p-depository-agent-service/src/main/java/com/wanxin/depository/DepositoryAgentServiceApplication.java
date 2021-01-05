package com.wanxin.depository;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@SpringBootApplication
@EnableDiscoveryClient
@EnableTransactionManagement
public class DepositoryAgentServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(DepositoryAgentServiceApplication.class, args);
    }
}
