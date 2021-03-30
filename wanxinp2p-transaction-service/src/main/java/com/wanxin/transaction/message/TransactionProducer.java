package com.wanxin.transaction.message;

import com.alibaba.fastjson.JSONObject;
import com.wanxin.api.transaction.model.ProjectWithTendersDTO;
import com.wanxin.transaction.entity.Project;
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
public class TransactionProducer {
    @Resource
    private RocketMQTemplate template;

    public void updateProjectStatusAndStartRepayment(Project project, ProjectWithTendersDTO projectWithTendersDTO) {
        // 构造消息
        JSONObject object = new JSONObject();
        object.put("project", project);
        object.put("projectWithTendersDTO", projectWithTendersDTO);
        Message<String> msg = MessageBuilder.withPayload(object.toJSONString()).build();
        // 发送消息
        template.sendMessageInTransaction("PID_START_REPAYMENT", "TP_START_REPAYMENT", msg, null);
    }
}
