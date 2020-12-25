package com.wanxin.account.controller;

import com.wanxin.account.service.AccountService;
import com.wanxin.api.account.AccountAPI;
import com.wanxin.api.account.model.AccountDTO;
import com.wanxin.api.account.model.AccountLoginDTO;
import com.wanxin.api.account.model.AccountRegisterDTO;
import com.wanxin.common.domain.RestResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    @PostMapping(value = "/l/accounts/session")
    @ApiOperation("用户登录")
    @ApiImplicitParam(
            name = "accountLoginDTO", value = "登录信息", required = true,
            dataType = "AccountLoginDTO", paramType = "body")
    public RestResponse<AccountDTO> login(AccountLoginDTO accountLoginDTO) {
        return RestResponse.success(accountService.login(accountLoginDTO));
    }

    @Override
    @PostMapping(value = "/l/accounts")
    @ApiOperation("用户注册")
    @ApiImplicitParam(
            name = "accountRegisterDTO", value = "账户注册信息", required = true,
            dataType = "AccountRegisterDTO", paramType = "body")
    public RestResponse<AccountDTO> registry(@RequestBody AccountRegisterDTO accountRegisterDTO) {
        return RestResponse.success(accountService.registry(accountRegisterDTO));
    }

    @Override
    @GetMapping("/mobiles/{mobile}/key/{key}/code/{code}")
    @ApiOperation("手机号与验证码校验")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "mobile", value = "手机号", dataType = "string"),
            @ApiImplicitParam(name = "key", value = "秘钥", dataType = "string"),
            @ApiImplicitParam(name = "code", value = "验证码", dataType = "string")
    })
    public RestResponse<Integer> checkMobile(
            @PathVariable("mobile") String mobile,
            @PathVariable("key") String key,
            @PathVariable("code") String code) {
        return RestResponse.success(accountService.checkMobile(mobile, key, code));
    }

    @Override
    @GetMapping("/sms/{mobile}")
    @ApiOperation("获取手机验证码")
    @ApiImplicitParam(name = "mobile", value = "手机号", dataType = "string")
    public RestResponse getSMSCode(@PathVariable("mobile") String mobile) {
        return accountService.getSMSCode(mobile);
    }
}
