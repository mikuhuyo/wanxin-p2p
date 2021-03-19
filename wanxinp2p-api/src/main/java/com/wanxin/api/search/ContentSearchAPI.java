package com.wanxin.api.search;

import com.wanxin.api.search.model.ProjectQueryParamsDTO;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.common.domain.PageVO;
import com.wanxin.common.domain.RestResponse;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface ContentSearchAPI {
    /**
     * 检索标的
     *
     * @param projectQueryParamsDTO
     * @return
     */
    RestResponse<PageVO<ProjectDTO>> queryProjectIndex(ProjectQueryParamsDTO projectQueryParamsDTO, Integer pageNo, Integer pageSize, String sortBy, String order);
}
