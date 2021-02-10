package com.wanxin.depository.controller;

import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.consumer.model.RechargeRequest;
import com.wanxin.api.consumer.model.WithdrawRequest;
import com.wanxin.api.depository.DepositoryAgentAPI;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.depository.service.DepositoryRecordService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 存管代理服务
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Api(value = "存管代理服务", tags = "depository-agent")
@RestController
public class DepositoryAgentController implements DepositoryAgentAPI {
    @Autowired
    private DepositoryRecordService depositoryRecordService;

    @Override
    @PostMapping("/l/withdraws")
    @ApiOperation("生成提现请求数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "withdrawRequest", value = "提现信息", required = true, dataType = "WithdrawRequest", paramType = "body")
    })
    public RestResponse<GatewayRequest> createWithdrawRecord(WithdrawRequest withdrawRequest) {
        return RestResponse.success(depositoryRecordService.withdrawRecords(withdrawRequest));
    }

    @Override
    @PostMapping("/l/recharges")
    @ApiOperation("生成充值请求数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "rechargeRequest", value = "充值信息", required = true, dataType = "RechargeRequest", paramType = "body")
    })
    public RestResponse<GatewayRequest> createRechargeRecord(@RequestBody RechargeRequest rechargeRequest) {
        return RestResponse.success(depositoryRecordService.rechargeRecords(rechargeRequest));
    }

    @Override
    @PostMapping("/l/consumers")
    @ApiOperation("生成开户请求数据")
    @ApiImplicitParam(name = "consumerRequest", value = "开户信息", required = true, dataType = "ConsumerRequest", paramType = "body")
    public RestResponse<GatewayRequest> createConsumer(@RequestBody ConsumerRequest consumerRequest) {
        return RestResponse.success(depositoryRecordService.createConsumer(consumerRequest));
    }
}
