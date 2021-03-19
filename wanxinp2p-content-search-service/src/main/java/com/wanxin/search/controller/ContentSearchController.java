package com.wanxin.search.controller;

import com.wanxin.api.search.ContentSearchAPI;
import com.wanxin.api.search.model.ProjectQueryParamsDTO;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.common.domain.PageVO;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.search.service.ContentSearchService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@RestController
@Api(value = "内容检索服务API", tags = "ContentSearch")
public class ContentSearchController implements ContentSearchAPI {
    @Autowired
    private ContentSearchService contentSearchService;

    @Override
    @PostMapping(value = "/l/projects/indexes/q")
    @ApiOperation("检索标的")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "projectQueryParamsDTO", value = "标的检索参数", required = true, dataType = "ProjectQueryParamsDTO", paramType = "body"),
            @ApiImplicitParam(name = "pageNo", value = "页码", required = true, dataType = "int", paramType = "query"),
            @ApiImplicitParam(name = "pageSize", value = "每页记录数", required = true, dataType = "int", paramType = "query"),
            @ApiImplicitParam(name = "sortBy", value = "排序字段", dataType = "String", paramType = "query"),
            @ApiImplicitParam(name = "order", value = "顺序", dataType = "String", paramType = "query")
    })
    public RestResponse<PageVO<ProjectDTO>> queryProjectIndex(@RequestBody ProjectQueryParamsDTO projectQueryParamsDTO,
                                                              @RequestParam("pageNo") Integer pageNo,
                                                              @RequestParam("pageSize") Integer pageSize,
                                                              @RequestParam(value = "sortBy", required = false) String sortBy,
                                                              @RequestParam(value = "order", required = false) String order) {
        return RestResponse.success(contentSearchService.queryProjectIndex(projectQueryParamsDTO, pageNo, pageSize, sortBy, order));
    }
}
