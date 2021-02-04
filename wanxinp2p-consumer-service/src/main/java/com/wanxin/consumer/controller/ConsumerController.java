package com.wanxin.consumer.controller;

import com.wanxin.api.consumer.ConsumerAPI;
import com.wanxin.api.consumer.model.BankCardDTO;
import com.wanxin.api.consumer.model.ConsumerDTO;
import com.wanxin.api.consumer.model.ConsumerRegisterDTO;
import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.consumer.common.SecurityUtil;
import com.wanxin.consumer.service.BankCardService;
import com.wanxin.consumer.service.ConsumerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

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
