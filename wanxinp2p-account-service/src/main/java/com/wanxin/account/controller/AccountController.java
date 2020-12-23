package com.wanxin.account.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@RestController
@Api(value = "统一账户服务API", tags = "Account")
public class AccountController {

    @Value("${server.servlet.context-path}")
    private String path;

    @ApiOperation("测试API-hello")
    @GetMapping(path = "/hello")
    public String hello() {
        return "hello " + path;
    }

    @ApiOperation("测试API-hi")
    @PostMapping(path = "/hi")
    @ApiImplicitParam(name = "name", value = "姓名", required = true, dataType = "String")
    public String hi(String name) {
        return "hi," + name;
    }
}
