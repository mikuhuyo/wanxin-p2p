package com.wanxin.repayment.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Configuration
@EnableScheduling
public class SchedulerConfig {
    @Bean
    public TaskScheduler taskScheduler() {
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
        // 线程池大小
        scheduler.setPoolSize(2);
        // 线程名字前缀
        scheduler.setThreadNamePrefix("spring-task-thread");
        return scheduler;
    }
}
