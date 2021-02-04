package com.wanxin.consumer.service;

import com.wanxin.api.consumer.model.ConsumerDTO;
import com.wanxin.api.consumer.model.ConsumerRegisterDTO;
import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.depository.model.DepositoryConsumerResponse;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.RestResponse;

import java.io.IOException;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface ConsumerService {
    /**
     * 根据手机号获取用户信息
     *
     * @param mobile 手机号
     * @return
     */
    ConsumerDTO getConsumerByMobile(String mobile);

    /**
     * 更新开户结果
     *
     * @param response
     * @return
     */
    Boolean modifyResult(DepositoryConsumerResponse response);

    /**
     * 生成开户数据
     *
     * @param consumerRequest
     * @return
     */
    RestResponse<GatewayRequest> createConsumer(ConsumerRequest consumerRequest) throws IOException;

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
