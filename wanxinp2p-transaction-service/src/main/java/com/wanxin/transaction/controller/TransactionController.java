package com.wanxin.transaction.controller;

import com.wanxin.api.transaction.TransactionAPI;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.api.transaction.model.ProjectQueryDTO;
import com.wanxin.common.domain.PageVO;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.transaction.service.ProjectService;
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
@Api(value = "支付服务中心API", tags = "Transaction")
public class TransactionController implements TransactionAPI {
    @Autowired
    private ProjectService projectService;

    @Override
    @PutMapping("/m/projects/{id}/projectStatus/{approveStatus}")
    @ApiOperation("管理员审核标的信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "标的id", required = true, dataType = "long", paramType = "path"),
            @ApiImplicitParam(name = "approveStatus", value = "审批状态", required = true, dataType = "string", paramType = "path")
    })
    public RestResponse<String> projectsApprovalStatus(@PathVariable("id") Long id, @PathVariable("approveStatus") String approveStatus) {
        String result = projectService.projectsApprovalStatus(id, approveStatus);
        return RestResponse.success(result);
    }

    @Override
    @PostMapping("/projects/q")
    @ApiOperation("检索标的信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "projectQueryDTO", value = "标的信息查询对象", required = false, dataType = "ProjectQueryDTO", paramType = "body"),
            @ApiImplicitParam(name = "pageNo", value = "页码", required = true, dataType = "int", paramType = "query", example = "1"),
            @ApiImplicitParam(name = "pageSize", value = "每页记录数", required = true, dataType = "int", paramType = "query", example = "5")
    })
    public RestResponse<PageVO<ProjectDTO>> queryProjects(
            @RequestBody(required = false) ProjectQueryDTO projectQueryDTO,
            @RequestParam(value = "pageNo", required = true, defaultValue = "1") Integer pageNo,
            @RequestParam(value = "pageSize", required = true, defaultValue = "5") Integer pageSize) {
        return RestResponse.success(projectService.queryProjectsByQueryDTO(projectQueryDTO, pageNo, pageSize));
    }

    @Override
    @PostMapping("/my/projects")
    @ApiOperation("借款人发标")
    @ApiImplicitParam(name = "project", value = "标的信息", required = true, dataType = "Project", paramType = "body")
    public RestResponse<ProjectDTO> createProject(@RequestBody ProjectDTO projectDTO) {
        return RestResponse.success(projectService.createProject(projectDTO));
    }

    @Override
    @GetMapping("/my/qualifications")
    @ApiOperation("借款人发标资格查询")
    public RestResponse<Integer> qualifications() {
        return RestResponse.success(projectService.queryQualifications());
    }
}
