package com.wanxin.repayment.job;

import com.wanxin.repayment.service.RepaymentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@Component
public class RepaymentSimpleJob {
    @Autowired
    private RepaymentService repaymentService;

    @Scheduled(cron = "*/5 * * * * ?")
    public void execute() {
        // 定时还款任务
        repaymentService.selectDueRepayment(LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE));
    }
}
