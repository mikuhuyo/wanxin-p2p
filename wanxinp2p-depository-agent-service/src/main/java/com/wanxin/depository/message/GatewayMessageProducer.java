package com.wanxin.depository.message;

import com.wanxin.api.depository.model.DepositoryConsumerResponse;
import com.wanxin.api.depository.model.DepositoryRechargeResponse;
import com.wanxin.api.depository.model.DepositoryWithdrawResponse;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

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
    @Autowired
    private RocketMQTemplate template;

    public void personalWithdraw(DepositoryWithdrawResponse response) {
        template.convertAndSend("TP_GATEWAY_NOTIFY_AGENT:WITHDRAW", response);
    }

    public void personalRecharge(DepositoryRechargeResponse response) {
        template.convertAndSend("TP_GATEWAY_NOTIFY_AGENT:RECHARGE", response);
    }

    public void personalRegister(DepositoryConsumerResponse response) {
        template.convertAndSend("TP_GATEWAY_NOTIFY_AGENT:PERSONAL_REGISTER", response);
    }
}
