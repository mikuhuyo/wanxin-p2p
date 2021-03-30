package com.wanxin.repayment.message;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.wanxin.api.transaction.model.ProjectWithTendersDTO;
import com.wanxin.repayment.service.RepaymentService;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@Component
@RocketMQMessageListener(topic = "TP_START_REPAYMENT", consumerGroup = "CID_START_REPAYMENT")
public class StartRepaymentMessageConsumer implements RocketMQListener<String> {
    @Autowired
    private RepaymentService repaymentService;

    @Override
    public void onMessage(String projectStr) {
        log.info("消息消费-{}", projectStr);
        // 解析消息
        JSONObject jsonObject = JSON.parseObject(projectStr);
        ProjectWithTendersDTO projectWithTendersDTO = JSONObject.parseObject(jsonObject.getString("projectWithTendersDTO"), ProjectWithTendersDTO.class);
        // 调用业务层, 执行本地事务
        repaymentService.startRepayment(projectWithTendersDTO);
    }
}
