package com.wanxin.depository.message;

import com.wanxin.api.depository.model.DepositoryConsumerResponse;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * <p>
 * 存管代理服务异步通知消息生产者
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Component
public class GatewayMessageProducer {
    @Resource
    private RocketMQTemplate rocketMQTemplate;

    public void personalRegister(DepositoryConsumerResponse response) {
        rocketMQTemplate.convertAndSend("TP_GATEWAY_NOTIFY_AGENT:PERSONAL_REGISTER", response);
    }
}
