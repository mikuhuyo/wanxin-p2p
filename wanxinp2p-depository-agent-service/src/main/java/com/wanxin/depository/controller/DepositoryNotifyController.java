package com.wanxin.depository.controller;

import com.alibaba.fastjson.JSON;
import com.wanxin.api.depository.model.DepositoryConsumerResponse;
import com.wanxin.common.util.EncryptUtil;
import com.wanxin.depository.message.GatewayMessageProducer;
import com.wanxin.depository.service.DepositoryRecordService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 存管代理服务消息通知
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@RestController
@Api(value = "银行存管系统通知服务", tags = "depository-agent")
public class DepositoryNotifyController {

    @Autowired
    private DepositoryRecordService depositoryRecordService;
    @Autowired
    private GatewayMessageProducer gatewayMessageProducer;

    @ApiOperation("接受银行存管系统开户回调结果")
    @GetMapping(value = "/gateway")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "serviceName", value = "请求的存管接口名", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "platformNo", value = "平台编号, 平台与存管系统签约时获取", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "signature", value = "对reqData参数的签名", required = true, dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "reqData", value = "业务数据报文, json格式", required = true, dataType = "String", paramType = "query")
    })
    public String receiveDepositoryCreateConsumerResult(@RequestParam("serviceName") String serviceName, @RequestParam("platformNo") String platformNo, @RequestParam("signature") String signature, @RequestParam("reqData") String reqData) {
        // 更新数据
        DepositoryConsumerResponse response = JSON.parseObject(EncryptUtil.decodeUTF8StringBase64(reqData), DepositoryConsumerResponse.class);
        depositoryRecordService.modifyRequestStatus(response.getRequestNo(), response.getStatus());
        // 给用户中心发送消息
        gatewayMessageProducer.personalRegister(response);

        // 给银行存管系统返回结果
        return "OK";
    }
}
