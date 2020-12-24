package com.wanxin.account.controller;

import com.wanxin.account.service.AccountService;
import com.wanxin.api.account.AccountAPI;
import com.wanxin.common.domain.RestResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@RestController
@Api(value = "统一账户服务API", tags = "Account")
public class AccountController implements AccountAPI {
    @Autowired
    private AccountService accountService;

    @Override
    @GetMapping("/sms/{mobile}")
    @ApiOperation("获取手机验证码")
    @ApiImplicitParam(name = "mobile", value = "手机号", dataType = "string")
    public RestResponse getSMSCode(@PathVariable("mobile") String mobile) {
        return accountService.getSMSCode(mobile);
    }
}
