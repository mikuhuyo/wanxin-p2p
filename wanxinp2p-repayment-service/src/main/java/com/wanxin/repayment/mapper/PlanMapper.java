package com.wanxin.repayment.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wanxin.repayment.entity.RepaymentPlan;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * 借款人还款计划 Mapper 接口
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Repository
public interface PlanMapper extends BaseMapper<RepaymentPlan> {
}
