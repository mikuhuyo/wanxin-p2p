package com.wanxin.repayment.job;

import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@Component
public class RepaymentSimpleJob {
    @Scheduled(cron = "*/5 * * * * ?")
    public void execute() {
        // TODO 定时任务
    }
}
