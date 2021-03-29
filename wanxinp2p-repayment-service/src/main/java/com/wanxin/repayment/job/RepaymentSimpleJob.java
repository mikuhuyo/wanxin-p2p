package com.wanxin.repayment.job;

import lombok.extern.slf4j.Slf4j;
import org.apache.shardingsphere.elasticjob.api.ShardingContext;
import org.apache.shardingsphere.elasticjob.simple.job.SimpleJob;
import org.springframework.stereotype.Component;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@Component
public class RepaymentSimpleJob implements SimpleJob {
    @Override
    public void execute(ShardingContext shardingContext) {
        // TODO 定时任务
    }
}
