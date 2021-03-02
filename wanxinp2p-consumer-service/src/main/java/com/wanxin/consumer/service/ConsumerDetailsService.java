package com.wanxin.consumer.service;

import com.wanxin.api.consumer.model.ConsumerDetailsDTO;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface ConsumerDetailsService {
    void createConsumerDetails(ConsumerDetailsDTO consumerDetailsDTO, String mobile);
}
