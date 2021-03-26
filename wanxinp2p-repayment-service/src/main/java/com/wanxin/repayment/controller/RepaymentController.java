package com.wanxin.repayment.controller;

import com.wanxin.api.repayment.RepaymentAPI;
import com.wanxin.api.transaction.model.ProjectWithTendersDTO;
import com.wanxin.common.domain.RestResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@RestController
@Api(value = "还款服务", tags = "repayment")
public class RepaymentController implements RepaymentAPI {

    @Override
    @PostMapping("/l/start-repayment")
    @ApiOperation("启动还款")
    @ApiImplicitParam(name = "projectWithTendersDTO", value = "通过id获取标的信息", required = true, dataType = "ProjectWithTendersDTO", paramType = "body")
    public RestResponse<String> startRepayment(@RequestBody ProjectWithTendersDTO projectWithTendersDTO) {
        return null;
    }
}
