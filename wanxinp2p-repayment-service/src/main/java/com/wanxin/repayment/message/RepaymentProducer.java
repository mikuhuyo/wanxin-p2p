package com.wanxin.repayment.message;

import com.alibaba.fastjson.JSONObject;
import com.wanxin.api.repayment.model.RepaymentRequest;
import com.wanxin.repayment.entity.RepaymentPlan;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.messaging.Message;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Component
public class RepaymentProducer {
    @Resource
    private RocketMQTemplate rocketMQTemplate;

    public void confirmRepayment(RepaymentPlan repaymentPlan, RepaymentRequest repaymentRequest) {
        // 构造消息
        JSONObject object = new JSONObject();
        object.put("repaymentPlan", repaymentPlan);
        object.put("repaymentRequest", repaymentRequest);
        Message<String> msg = MessageBuilder.withPayload(object.toJSONString()).build();
        // 发送消息
        rocketMQTemplate.sendMessageInTransaction("PID_CONFIRM_REPAYMENT", "TP_CONFIRM_REPAYMENT", msg, null);
    }
}
