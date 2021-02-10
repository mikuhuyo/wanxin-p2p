package com.wanxin.consumer.controller;

import com.wanxin.api.consumer.ConsumerAPI;
import com.wanxin.api.consumer.model.*;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.consumer.common.SecurityUtil;
import com.wanxin.consumer.service.BankCardService;
import com.wanxin.consumer.service.ConsumerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@RestController
@Api(value = "用户服务API", tags = "Consumer")
public class ConsumerController implements ConsumerAPI {
    @Autowired
    private ConsumerService consumerService;
    @Autowired
    private BankCardService bankCardService;

    @Override
    @GetMapping("/my/withdraw-records")
    @ApiOperation("生成提现请求数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "amount", value = "金额", required = true, dataType = "string", paramType = "query"),
            @ApiImplicitParam(name = "callbackUrl", value = "通知结果回调URL", required = true, dataType = "string", paramType = "query")
    })
    public RestResponse<GatewayRequest> createWithdrawRecord(@RequestParam("amount") String amount, @RequestParam("callbackUrl") String callbackUrl) {
        return consumerService.createWithdrawRecord(amount, callbackUrl, SecurityUtil.getUser().getMobile());
    }

    @Override
    @GetMapping("/my/recharge-records")
    @ApiOperation("生成充值请求数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "amount", value = "金额", required = true, dataType = "string", paramType = "query"),
            @ApiImplicitParam(name = "callbackUrl", value = "通知结果回调URL", required = true, dataType = "string", paramType = "query")
    })
    public RestResponse<GatewayRequest> createRechargeRecord(@RequestParam("amount") String amount, @RequestParam("callbackUrl") String callbackUrl) {
        return consumerService.createRechargeRecord(amount, callbackUrl, SecurityUtil.getUser().getMobile());
    }

    @Override
    @ApiOperation("获取用户余额信息")
    @GetMapping("/my/balances")
    public RestResponse<BalanceDetailsDTO> getBalances() throws IOException {
        String userNo = consumerService.getConsumerByMobile(SecurityUtil.getUser().getMobile()).getUserNo();
        return RestResponse.success(consumerService.getBalanceDetailsByUserNo(userNo));
    }

    @Override
    @GetMapping("/my/consumers")
    @ApiOperation("获取用户信息")
    public RestResponse<ConsumerDTO> getConsumer() {
        return RestResponse.success(consumerService.getConsumerByMobile(SecurityUtil.getUser().getMobile()));
    }

    @Override
    @GetMapping("/my/bank-cards")
    @ApiOperation("获取用户银行卡信息")
    public RestResponse<BankCardDTO> getBankCard() {
        return RestResponse.success(bankCardService.getByUserMobile(SecurityUtil.getUser().getMobile()));
    }

    @Override
    @PostMapping("/my/consumers")
    @ApiOperation("生成开户请求数据")
    @ApiImplicitParam(name = "consumerRequest", value = "开户信息", required = true, dataType = "ConsumerRequest", paramType = "body")
    public RestResponse<GatewayRequest> createConsumer(@RequestBody ConsumerRequest consumerRequest) throws IOException {
        consumerRequest.setMobile(SecurityUtil.getUser().getMobile());
        return consumerService.createConsumer(consumerRequest);
    }

    @Override
    @PostMapping("/consumers")
    @ApiOperation("用户注册")
    @ApiImplicitParam(name = "consumerRegisterDTO", value = "注册信息", required = true, dataType = "AccountRegisterDTO", paramType = "body")
    public RestResponse register(@RequestBody ConsumerRegisterDTO consumerRegisterDTO) {
        consumerService.register(consumerRegisterDTO);
        return RestResponse.success();
    }
}
