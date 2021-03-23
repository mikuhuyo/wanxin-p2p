package com.wanxin.api.depository;

import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.consumer.model.RechargeRequest;
import com.wanxin.api.consumer.model.WithdrawRequest;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.api.depository.model.UserAutoPreTransactionRequest;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.common.domain.RestResponse;

/**
 * <p>
 * 银行存管系统代理服务API
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface DepositoryAgentAPI {
    /**
     * 预授权处理
     *
     * @param userAutoPreTransactionRequest 预授权处理信息
     * @return
     */
    RestResponse<String> userAutoPreTransaction(UserAutoPreTransactionRequest userAutoPreTransactionRequest);

    /**
     * 保存标的信息
     *
     * @param projectDTO 标的信息
     * @return 返回提示信息
     */
    RestResponse<String> createProject(ProjectDTO projectDTO);

    /**
     * 生成用户提现数据
     *
     * @param withdrawRequest
     * @return
     */
    RestResponse<GatewayRequest> createWithdrawRecord(WithdrawRequest withdrawRequest);

    /**
     * 生成用户充值数据
     *
     * @param rechargeRequest
     * @return
     */
    RestResponse<GatewayRequest> createRechargeRecord(RechargeRequest rechargeRequest);

    /**
     * 开通存管账户
     *
     * @param consumerRequest 开户信息
     * @return
     */
    RestResponse<GatewayRequest> createConsumer(ConsumerRequest consumerRequest);
}
