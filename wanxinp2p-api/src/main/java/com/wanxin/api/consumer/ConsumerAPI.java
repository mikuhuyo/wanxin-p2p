package com.wanxin.api.consumer;

import com.wanxin.api.consumer.model.BankCardDTO;
import com.wanxin.api.consumer.model.ConsumerRegisterDTO;
import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.RestResponse;

import java.io.IOException;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface ConsumerAPI {
    /**
     * 获取银行卡信息
     *
     * @return
     */
    RestResponse<BankCardDTO> getBankCard();

    /**
     * 生成开户请求数据
     *
     * @param consumerRequest 开户数据
     * @return
     */
    RestResponse<GatewayRequest> createConsumer(ConsumerRequest consumerRequest) throws IOException;


    /**
     * 用户注册
     *
     * @param consumerRegisterDTO
     * @return
     */
    RestResponse register(ConsumerRegisterDTO consumerRegisterDTO);
}
