package com.wanxin.consumer.service;

import com.wanxin.api.consumer.model.BankCardDTO;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface BankCardService {
    /**
     * 获取银行卡信息
     *
     * @param consumerId 用户id
     * @return
     */
    BankCardDTO getByConsumerId(Long consumerId);

    /**
     * 获取银行卡信息
     *
     * @param cardNumber 卡号
     * @return
     */
    BankCardDTO getByCardNumber(String cardNumber);
}
