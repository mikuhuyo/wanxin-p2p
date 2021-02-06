package com.wanxin.api.transaction.model;

import lombok.Data;

/**
 * <P>
 * 修改标的状态DTO
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
public class ModifyProjectStatusDTO {
    /**
     * 请求流水号
     */
    private String requestNo;
    /**
     * 标的号
     */
    private String projectNo;
    /**
     * 更新标的状态
     */
    private String projectStatus;

    /**
     * 业务实体id
     */
    private Long id;
}
