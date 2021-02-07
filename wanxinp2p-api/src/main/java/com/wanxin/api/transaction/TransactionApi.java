package com.wanxin.api.transaction;

import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.api.transaction.model.ProjectQueryDTO;
import com.wanxin.common.domain.PageVO;
import com.wanxin.common.domain.RestResponse;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface TransactionApi {
    /**
     * 检索标的信息
     *
     * @param projectQueryDTO 封装查询条件
     * @param order           排序
     * @param pageNo          页码
     * @param pageSize        条数
     * @param sortBy          查询条件
     * @return
     */
    RestResponse<PageVO<ProjectDTO>> queryProjects(ProjectQueryDTO projectQueryDTO, String order, Integer pageNo, Integer pageSize, String sortBy);

    /**
     * 借款人发标
     *
     * @param projectDTO 标的信息
     * @return
     */
    RestResponse<ProjectDTO> createProject(ProjectDTO projectDTO);
}
