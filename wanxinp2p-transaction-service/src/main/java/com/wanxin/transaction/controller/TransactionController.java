package com.wanxin.transaction.controller;

import com.wanxin.api.transaction.TransactionApi;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.transaction.service.ProjectService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@RestController
@Api(value = "支付服务中心API", tags = "Transaction")
public class TransactionController implements TransactionApi {
    @Autowired
    private ProjectService transactionService;

    @Override
    @PostMapping("/my/projects")
    @ApiOperation("借款人发标")
    @ApiImplicitParam(name = "project", value = "标的信息", required = true, dataType = "Project", paramType = "body")
    public RestResponse<ProjectDTO> createProject(@RequestBody ProjectDTO projectDTO) {
        return RestResponse.success(transactionService.createProject(projectDTO));
    }
}
