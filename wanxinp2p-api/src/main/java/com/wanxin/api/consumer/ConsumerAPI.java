package com.wanxin.api.consumer;

import com.wanxin.api.consumer.model.*;
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
     * 生成提现数据
     *
     * @param amount      提现金额
     * @param callbackUrl 回调地址
     * @return
     */
    RestResponse<GatewayRequest> createWithdrawRecord(String amount, String callbackUrl);

    /**
     * 生成充值请求数据
     *
     * @param amount   充值金额
     * @param callback 回调地址
     * @return
     */
    RestResponse<GatewayRequest> createRechargeRecord(String amount, String callback);

    /**
     * 根据用户流水号获取用户余额信息
     *
     * @return
     */
    RestResponse<BalanceDetailsDTO> getBalances() throws IOException;

    /**
     * 获取用户信息
     *
     * @return
     */
    RestResponse<ConsumerDTO> getConsumer();

    /**
     * 获取银行卡信息
     *
     * @return
     */
    RestResponse<BankCardDTO> getBankCard() throws IOException;

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
