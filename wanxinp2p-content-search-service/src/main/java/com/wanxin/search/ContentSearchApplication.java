package com.wanxin.search;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@SpringBootApplication
@EnableDiscoveryClient
public class ContentSearchApplication {
    public static void main(String[] args) {
        SpringApplication.run(ContentSearchApplication.class, args);
    }
}
