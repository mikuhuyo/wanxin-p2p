package com.wanxin.consumer.service;

import com.wanxin.api.consumer.model.ConsumerRegisterDTO;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface ConsumerService {
    /**
     * 检测用户是否存在
     *
     * @param mobile 用户手机号
     * @return
     */
    Integer checkMobile(String mobile);

    /**
     * 用户注册
     *
     * @param consumerRegisterDTO 用户注册信息
     * @return
     */
    void register(ConsumerRegisterDTO consumerRegisterDTO);
}
