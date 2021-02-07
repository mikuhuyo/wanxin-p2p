package com.wanxin.transaction.service;

import com.wanxin.api.transaction.model.ProjectDTO;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface ProjectService {

    /**
     * 创建标的
     *
     * @param projectDTO 标的信息
     * @return
     */
    ProjectDTO createProject(ProjectDTO projectDTO);
}
