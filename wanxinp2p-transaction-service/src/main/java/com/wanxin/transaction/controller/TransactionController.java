package com.wanxin.transaction.controller;

import com.wanxin.api.transaction.TransactionAPI;
import com.wanxin.api.transaction.model.*;
import com.wanxin.common.domain.PageVO;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.transaction.service.ProjectService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    @PostMapping("/my/tenders")
    @ApiOperation("用户投标")
    @ApiImplicitParam(name = "projectInvestDTO", value = "投标信息", required = true, dataType = "ProjectInvestDTO", paramType = "body")
    public RestResponse<TenderDTO> createTender(@RequestBody ProjectInvestDTO projectInvestDTO) {
        return RestResponse.success(projectService.createTender(projectInvestDTO));
    }

    @Override
    @GetMapping("/tenders/projects/{id}")
    @ApiOperation("根据标的id查询投标记录")
    @ApiImplicitParam(name = "id", value = "标的id", required = true, dataType = "string", paramType = "path")
    public RestResponse<List<TenderOverviewDTO>> queryTendersByProjectId(@PathVariable("id") Long id) {
        return RestResponse.success(projectService.queryTendersByProjectId(id));
    }

    @Override
    @GetMapping("/projects/{ids}")
    @ApiOperation("通过ids获取多个标的")
    @ApiImplicitParam(name = "ids", value = "标的id", required = true, dataType = "string", paramType = "path")
    public RestResponse<List<ProjectDTO>> queryProjectsIds(@PathVariable("ids") String ids) {
        return RestResponse.success(projectService.queryProjectsIds(ids));
    }

    @Override
    @PostMapping("/projects/indexes/q")
    @ApiOperation("从ES检索标的信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "projectQueryDTO", value = "标的信息条件对象", required = true, dataType = "ProjectQueryDTO", paramType = "body"),
            @ApiImplicitParam(name = "pageNo", value = "页码", required = true, dataType = "int", paramType = "query"),
            @ApiImplicitParam(name = "pageSize", value = "每页记录数", required = true, dataType = "int", paramType = "query"),
            @ApiImplicitParam(name = "sortBy", value = "排序字段", required = false, dataType = "string", paramType = "query"),
            @ApiImplicitParam(name = "order", value = "顺序", required = false, dataType = "string", paramType = "query")
    })
    public RestResponse<PageVO<ProjectDTO>> queryProjects(@RequestBody ProjectQueryDTO projectQueryDTO, @RequestParam("pageNo") Integer pageNo, @RequestParam("pageSize") Integer pageSize, @RequestParam(value = "sortBy", required = false) String sortBy, @RequestParam(value = "order", required = false) String order) {

        PageVO<ProjectDTO> projects = projectService.queryProjects(projectQueryDTO, order, pageNo, pageSize, sortBy);
        return RestResponse.success(projects);
    }

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
