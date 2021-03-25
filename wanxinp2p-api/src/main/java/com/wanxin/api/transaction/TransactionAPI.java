package com.wanxin.api.transaction;

import com.wanxin.api.transaction.model.*;
import com.wanxin.common.domain.PageVO;
import com.wanxin.common.domain.RestResponse;

import java.util.List;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface TransactionAPI {
    /**
     * 满标放款审核
     *
     * @param id            标的id
     * @param approveStatus 审核状态
     * @param commission    平台佣金
     * @return
     */
    RestResponse<String> loansApprovalStatus(Long id, String approveStatus, String commission);

    /**
     * 用户投标
     *
     * @param projectInvestDTO
     * @return
     */
    RestResponse<TenderDTO> createTender(ProjectInvestDTO projectInvestDTO);

    /**
     * 根据标的id查询投标记录
     *
     * @param id
     * @return
     */
    RestResponse<List<TenderOverviewDTO>> queryTendersByProjectId(Long id);

    /**
     * 通过ids获取多个标的
     *
     * @param ids 标的id
     * @return
     */
    RestResponse<List<ProjectDTO>> queryProjectsIds(String ids);

    /**
     * 标的信息快速检索
     *
     * @param projectQueryDTO 查询请求体
     * @param pageNo          页码
     * @param pageSize        数据条数
     * @param sortBy          排序
     * @param order           顺序
     * @return
     */
    RestResponse<PageVO<ProjectDTO>> queryProjects(ProjectQueryDTO projectQueryDTO, Integer pageNo, Integer pageSize, String sortBy, String order);

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
