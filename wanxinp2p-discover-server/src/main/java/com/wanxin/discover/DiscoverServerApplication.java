package com.wanxin.discover;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@EnableEurekaServer
@SpringBootApplication
public class DiscoverServerApplication {
    public static void main(String[] args) {
        SpringApplication.run(DiscoverServerApplication.class, args);
    }
}
