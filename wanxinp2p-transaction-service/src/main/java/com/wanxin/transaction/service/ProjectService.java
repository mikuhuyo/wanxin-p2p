package com.wanxin.transaction.service;

import com.wanxin.api.transaction.model.*;
import com.wanxin.common.domain.PageVO;

import java.util.List;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface ProjectService {
    /**
     * 审核标的满标放款
     *
     * @param id
     * @param approveStatus
     * @param commission
     * @return String
     */
    String loansApprovalStatus(Long id, String approveStatus, String commission);

    /**
     * 用户投标
     *
     * @param projectInvestDTO
     * @return
     */
    TenderDTO createTender(ProjectInvestDTO projectInvestDTO);

    /**
     * 根据标的id查询投标记录
     *
     * @param id
     * @return
     */
    List<TenderOverviewDTO> queryTendersByProjectId(Long id);

    /**
     * 通过ids获取多个标的
     *
     * @param ids
     * @return
     */
    List<ProjectDTO> queryProjectsIds(String ids);

    /**
     * ES文档查询
     *
     * @param projectQueryDTO
     * @param order
     * @param pageNo
     * @param pageSize
     * @param sortBy
     * @return
     */
    PageVO<ProjectDTO> queryProjects(ProjectQueryDTO projectQueryDTO, String order, Integer pageNo, Integer pageSize, String sortBy);

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
     * @param pageNo          页码
     * @param pageSize        条数
     * @return
     */
    PageVO<ProjectDTO> queryProjectsByQueryDTO(ProjectQueryDTO projectQueryDTO, Integer pageNo, Integer pageSize);

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
