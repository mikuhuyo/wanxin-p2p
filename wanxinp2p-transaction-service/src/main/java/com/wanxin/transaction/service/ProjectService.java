package com.wanxin.transaction.service;

import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.api.transaction.model.ProjectQueryDTO;
import com.wanxin.common.domain.PageVO;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface ProjectService {
    /**
     * 管理员审核标的信息
     *
     * @param id            标的id
     * @param approveStatus 状态
     * @return String
     */
    String projectsApprovalStatus(Long id, String approveStatus);

    /**
     * 根据分页条件检索标的信息
     *
     * @param projectQueryDTO 查询实体
     * @param order           排序
     * @param pageNo          页码
     * @param pageSize        条数
     * @param sortBy          查询条件
     * @return
     */
    PageVO<ProjectDTO> queryProjectsByQueryDTO(ProjectQueryDTO projectQueryDTO, String order, Integer pageNo, Integer pageSize, String sortBy);

    /**
     * 创建标的
     *
     * @param projectDTO 标的信息
     * @return
     */
    ProjectDTO createProject(ProjectDTO projectDTO);

    /**
     * 查询借款人发标(也就是借钱)资格
     *
     * @return 是否有资格发标-0 无资格 1 有资格
     */
    Integer queryQualifications();
}
