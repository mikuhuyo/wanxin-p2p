package com.wanxin.transaction.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wanxin.api.consumer.model.ConsumerDTO;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.api.transaction.model.ProjectQueryDTO;
import com.wanxin.common.domain.*;
import com.wanxin.common.util.CodeNoUtil;
import com.wanxin.transaction.agent.ConsumerApiAgent;
import com.wanxin.transaction.agent.DepositoryAgentApiAgent;
import com.wanxin.transaction.common.constant.TransactionErrorCode;
import com.wanxin.transaction.entity.Project;
import com.wanxin.transaction.mapper.ProjectMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Service
public class ProjectServiceImpl implements ProjectService {
    @Autowired
    private ConfigService configService;
    @Autowired
    private ConsumerApiAgent consumerApiAgent;
    @Autowired
    private ProjectMapper projectMapper;
    @Autowired
    private DepositoryAgentApiAgent depositoryAgentApiAgent;

    @Override
    public String projectsApprovalStatus(Long id, String approveStatus) {
        // 根据id查询标的信息并转换为DTO对象
        Project project = projectMapper.selectById(id);
        ProjectDTO projectDTO = convertProjectEntityToDTO(project);

        // 生成流水号
        projectDTO.setRequestNo(CodeNoUtil.getNo(CodePrefixCode.CODE_REQUEST_PREFIX));

        // 通过feign远程访问存管代理服务, 把标的信息传输过去
        RestResponse<String> restResponse = depositoryAgentApiAgent.createProject(projectDTO);

        if (DepositoryReturnCode.RETURN_CODE_00000.getCode().equals(restResponse.getResult())) {
            // 根据结果修改状态
            Project pro = new Project();
            pro.setId(project.getId());
            pro.setStatus(Integer.parseInt(approveStatus));
            projectMapper.updateById(pro);
            return "success";
        }

        throw new BusinessException(TransactionErrorCode.E_150113);
    }

    @Override
    public PageVO<ProjectDTO> queryProjectsByQueryDTO(ProjectQueryDTO projectQueryDTO, String order, Integer pageNo, Integer pageSize, String sortBy) {
        LambdaQueryWrapper<Project> queryWrapper = new LambdaQueryWrapper<>();

        if (projectQueryDTO != null) {
            // 标的类型
            if (StringUtils.isNotBlank(projectQueryDTO.getType())) {
                queryWrapper.eq(Project::getType, projectQueryDTO.getType());
            }

            // 起止年化利率(投资人) -- 区间
            if (null != projectQueryDTO.getStartAnnualRate()) {
                queryWrapper.ge(Project::getAnnualRate, projectQueryDTO.getStartAnnualRate());
            }
            if (null != projectQueryDTO.getEndAnnualRate()) {
                queryWrapper.le(Project::getAnnualRate, projectQueryDTO.getStartAnnualRate());
            }
            // 借款期限 -- 区间
            if (null != projectQueryDTO.getStartPeriod()) {
                queryWrapper.ge(Project::getPeriod, projectQueryDTO.getStartPeriod());
            }
            if (null != projectQueryDTO.getEndPeriod()) {
                queryWrapper.le(Project::getPeriod, projectQueryDTO.getEndPeriod());
            }
            // 标的状态
            if (StringUtils.isNotBlank(projectQueryDTO.getProjectStatus())) {
                queryWrapper.eq(Project::getProjectStatus, projectQueryDTO.getProjectStatus());
            }
        }

        // 排序
        if (StringUtils.isNotBlank(order) && StringUtils.isNotBlank(sortBy)) {
            if ("asc".equals(order.toLowerCase())) {
                // sortBy
                queryWrapper.orderByAsc(Project::getId);
            } else if ("desc".equals(order.toLowerCase())) {
                queryWrapper.orderByDesc(Project::getId);
            }
        } else {
            queryWrapper.orderByDesc(Project::getCreateDate);
        }

        // 执行查询
        IPage<Project> iPage = projectMapper.selectPage(new Page<Project>(pageNo, pageSize), queryWrapper);

        // 封装结果
        List<ProjectDTO> projectDTOList = convertProjectEntityListToDTOList(iPage.getRecords());
        return new PageVO<>(projectDTOList, iPage.getTotal(), pageNo, pageSize);
    }

    private List<ProjectDTO> convertProjectEntityListToDTOList(List<Project> projectList) {
        if (projectList == null) {
            return null;
        }
        List<ProjectDTO> dtoList = new ArrayList<>();
        projectList.forEach(project -> {
            ProjectDTO projectDTO = new ProjectDTO();
            BeanUtils.copyProperties(project, projectDTO);
            dtoList.add(projectDTO);
        });
        return dtoList;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ProjectDTO createProject(ProjectDTO projectDTO) {
        RestResponse<ConsumerDTO> consumer = consumerApiAgent.getCurrentLoginConsumer();

        // 设置用户编码
        projectDTO.setUserNo(consumer.getResult().getUserNo());
        // 设置用户id
        projectDTO.setConsumerId(consumer.getResult().getId());
        // 生成标的编码
        projectDTO.setProjectNo(CodeNoUtil.getNo(CodePrefixCode.CODE_PROJECT_PREFIX));
        // 标的状态修改
        projectDTO.setProjectStatus(ProjectCode.COLLECTING.getCode());
        // 标的可用状态修改, 未同步
        projectDTO.setStatus(StatusCode.STATUS_OUT.getCode());
        // 设置标的创建时间
        projectDTO.setCreateDate(new Date());
        // 设置还款方式
        projectDTO.setRepaymentWay(RepaymentWayCode.FIXED_REPAYMENT.getCode());
        // 设置标的类型
        projectDTO.setType("NEW");

        Project project = convertProjectDTOToEntity(projectDTO);
        project.setBorrowerAnnualRate(configService.getBorrowerAnnualRate());
        project.setAnnualRate(configService.getAnnualRate());
        // 年化利率(平台佣金, 利差)
        project.setCommissionAnnualRate(configService.getCommissionAnnualRate());
        // 债权转让
        project.setIsAssignment(0);
        // 判断男女
        String sex = Integer.parseInt(consumer.getResult().getIdNumber().substring(16, 17)) % 2 == 0 ? "女士" : "先生";
        // 构造借款次数查询条件
        LambdaQueryWrapper<Project> eq = new LambdaQueryWrapper<Project>().eq(Project::getConsumerId, consumer.getResult().getId());
        // 设置标的名字, 姓名 + 性别 + 第N次借款
        project.setName(consumer.getResult().getFullname() + sex + "第" + (projectMapper.selectCount(eq) + 1) + "次借款");
        projectMapper.insert(project);

        projectDTO.setId(project.getId());
        projectDTO.setName(project.getName());
        return projectDTO;
    }

    @Override
    public Integer queryQualifications() {
        // 判断是否绑定银行卡
        ConsumerDTO result = consumerApiAgent.getCurrentLoginConsumer().getResult();
        if (!result.getIsBindCard().equals(1)) {
            return 0;
        }

        // 判断是否以发标
        Integer count = projectMapper.selectCount(new LambdaQueryWrapper<Project>().eq(Project::getConsumerId, result.getId()).eq(Project::getStatus, 0));
        if (!count.equals(0)) {
            return 0;
        }
        return 1;
    }

    private Project convertProjectDTOToEntity(ProjectDTO projectDTO) {
        if (projectDTO == null) {
            return null;
        }
        Project project = new Project();
        BeanUtils.copyProperties(projectDTO, project);
        return project;
    }

    private ProjectDTO convertProjectEntityToDTO(Project project) {
        if (project == null) {
            return null;
        }
        ProjectDTO projectDTO = new ProjectDTO();
        BeanUtils.copyProperties(project, projectDTO);
        return projectDTO;
    }

}
