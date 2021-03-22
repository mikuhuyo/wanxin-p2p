package com.wanxin.api.consumer;

import com.wanxin.api.consumer.model.*;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.RestResponse;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface ConsumerAPI {
    /**
     * 获取借款人用户信息
     *
     * @param id
     * @return
     */
    RestResponse<BorrowerDTO> getBorrower(Long id);

    /**
     * 保存用户详细信息(主要存储身份证文件标识)
     *
     * @param consumerDetailsDTO 封装用户详情信息
     * @return 提示信息-成功或者失败
     */
    RestResponse<String> saveConsumerDetails(ConsumerDetailsDTO consumerDetailsDTO);

    /**
     * 获取文件上传秘钥
     *
     * @return 上传凭证
     */
    RestResponse<FileTokenDTO> applyUploadCertificate();

    /**
     * 提交身份证图片给百度AI进行识别
     *
     * @param multipartFile 上传的身份证图片文件
     * @param flag          身份证正反面(取值 front 或者 back)
     * @return ORC识别信息
     */
    RestResponse<IdCardDTO> imageRecognition(MultipartFile multipartFile, String flag) throws IOException;

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
