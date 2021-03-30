package com.wanxin.consumer.service;

import com.wanxin.api.consumer.model.BorrowerDTO;
import com.wanxin.api.consumer.model.ConsumerDTO;
import com.wanxin.api.consumer.model.ConsumerRegisterDTO;
import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.depository.model.DepositoryConsumerResponse;
import com.wanxin.api.depository.model.DepositoryRechargeResponse;
import com.wanxin.api.depository.model.DepositoryWithdrawResponse;
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
     * 获取借款人基本信息
     *
     * @param id
     * @return
     */
    BorrowerDTO getBorrower(Long id);

    /**
     * 生成用户提现数据
     *
     * @param amount      提现金额
     * @param fallbackUrl 回调地址
     * @param mobile      手机号
     * @return
     */
    RestResponse<GatewayRequest> createWithdrawRecord(String amount, String fallbackUrl, String mobile);

    /**
     * 更新提现回调回调状态
     *
     * @param depositoryWithdrawResponse
     * @return
     */
    Boolean modifyWithdrawRecordResult(DepositoryWithdrawResponse depositoryWithdrawResponse);

    /**
     * 生成用户充值数据
     *
     * @param amount   充值金额
     * @param fallback 回调地址
     * @param mobile   手机号
     * @return
     */
    RestResponse<GatewayRequest> createRechargeRecord(String amount, String fallback, String mobile);

    /**
     * 更新充值回调状态
     *
     * @param depositoryRechargeResponse
     * @return
     */
    Boolean modifyRechargeRecordResult(DepositoryRechargeResponse depositoryRechargeResponse);

    /**
     * 根据用户流水号查询用户余额信息
     *
     * @param userNo 用户流水号
     * @return
     */
    // BalanceDetailsDTO getBalanceDetailsByUserNo(String userNo) throws IOException;

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
