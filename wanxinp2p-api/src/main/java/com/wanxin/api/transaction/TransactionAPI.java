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
public interface TransactionAPI {
    /**
     * 管理员审核标的信息
     *
     * @param id            标的id
     * @param approveStatus 审核信息
     * @return
     */
    RestResponse<String> projectsApprovalStatus(Long id, String approveStatus);

    /**
     * 检索标的信息
     *
     * @param projectQueryDTO 封装查询条件
     * @param pageNo          页码
     * @param pageSize        条数
     * @return
     */
    RestResponse<PageVO<ProjectDTO>> queryProjects(ProjectQueryDTO projectQueryDTO, Integer pageNo, Integer pageSize);

    /**
     * 借款人发标
     *
     * @param projectDTO 标的信息
     * @return
     */
    RestResponse<ProjectDTO> createProject(ProjectDTO projectDTO);

    /**
     * 借款人发标资格查询
     *
     * @return
     */
    RestResponse<Integer> qualifications();
}
