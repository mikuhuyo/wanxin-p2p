package com.wanxin.repayment.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.api.repayment.model.EqualInterestRepayment;
import com.wanxin.api.repayment.model.RepaymentPlanDTO;
import com.wanxin.api.transaction.model.ProjectDTO;
import com.wanxin.api.transaction.model.ProjectWithTendersDTO;
import com.wanxin.api.transaction.model.TenderDTO;
import com.wanxin.common.domain.CodePrefixCode;
import com.wanxin.common.domain.DepositoryReturnCode;
import com.wanxin.common.domain.RepaymentWayCode;
import com.wanxin.common.domain.StatusCode;
import com.wanxin.common.util.CodeNoUtil;
import com.wanxin.common.util.DateUtil;
import com.wanxin.repayment.entity.ReceivablePlan;
import com.wanxin.repayment.entity.RepaymentDetail;
import com.wanxin.repayment.entity.RepaymentPlan;
import com.wanxin.repayment.mapper.RepaymentDetailMapper;
import com.wanxin.repayment.mapper.RepaymentPlanMapper;
import com.wanxin.repayment.mapper.ReceivablePlanMapper;
import com.wanxin.repayment.utils.RepaymentUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Service
public class RepaymentServiceImpl implements RepaymentService {
    @Autowired
    private RepaymentPlanMapper planMapper;
    @Autowired
    private ReceivablePlanMapper receivablePlanMapper;
    @Autowired
    private RepaymentDetailMapper repaymentDetailMapper;

    @Override
    public RepaymentDetail saveRepaymentDetail(RepaymentPlan repaymentPlan) {
        RepaymentDetail repaymentDetail = repaymentDetailMapper.selectOne(new LambdaQueryWrapper<RepaymentDetail>().eq(RepaymentDetail::getRepaymentPlanId, repaymentPlan.getId()));

        if (repaymentDetail == null) {
            repaymentDetail = new RepaymentDetail();
            // 还款计划项标识
            repaymentDetail.setRepaymentPlanId(repaymentPlan.getId());
            // 实还本息
            repaymentDetail.setAmount(repaymentPlan.getAmount());
            // 实际还款时间
            repaymentDetail.setRepaymentDate(LocalDateTime.now());
            // 请求流水号
            repaymentDetail.setRequestNo(CodeNoUtil.getNo(CodePrefixCode.CODE_REQUEST_PREFIX));
            // 未同步
            repaymentDetail.setStatus(StatusCode.STATUS_OUT.getCode());
            // 保存数据
            repaymentDetailMapper.insert(repaymentDetail);
        }

        return repaymentDetail;
    }

    @Override
    public List<RepaymentPlanDTO> selectDueRepayment(String date) {
        return convertEntityList2DtoList(planMapper.selectDueRepayment(date));
    }

    private List<RepaymentPlanDTO> convertEntityList2DtoList(List<RepaymentPlan> repaymentPlanList) {
        if (repaymentPlanList == null) {
            return null;
        }

        List<RepaymentPlanDTO> repaymentPlanDTOList = new ArrayList<>();
        repaymentPlanList.forEach(repaymentPlan -> {
            RepaymentPlanDTO repaymentPlanDTO = new RepaymentPlanDTO();
            BeanUtils.copyProperties(repaymentPlan, repaymentPlanDTO);
            repaymentPlanDTOList.add(repaymentPlanDTO);
        });

        return repaymentPlanDTOList;
    }

    @Override
    public String startRepayment(ProjectWithTendersDTO projectWithTendersDTO) {
        // 生成借款人还款计划
        // 获取标的信息
        ProjectDTO projectDTO = projectWithTendersDTO.getProject();
        // 获取投标信息
        List<TenderDTO> tenders = projectWithTendersDTO.getTenders();
        // 计算还款的月数
        double ceil = Math.ceil(projectDTO.getPeriod() / 30.0);
        int month = (int) ceil;
        // 还款方式, 只针对等额本息
        String repaymentWay = projectDTO.getRepaymentWay();

        if (repaymentWay.equals(RepaymentWayCode.FIXED_REPAYMENT)) {
            // 生成还款计划
            EqualInterestRepayment fixedRepayment = RepaymentUtil.fixedRepayment(projectDTO.getAmount(), projectDTO.getBorrowerAnnualRate(), month, projectDTO.getCommissionAnnualRate());

            // 保存还款计划
            List<RepaymentPlan> planList = saveRepaymentPlan(projectDTO, fixedRepayment);

            // 生成投资人应收明细
            // 根据投标信息生成应收明细
            tenders.forEach(tender -> {
                // 当前投标人的收款明细
                final EqualInterestRepayment receipt = RepaymentUtil.fixedRepayment(tender.getAmount(), tender.getProjectAnnualRate(), month, projectWithTendersDTO.getCommissionInvestorAnnualRate());
                // 由于投标人的收款明细需要还款信息,所有遍历还款计划, 把还款期数与投资人应收期数对应上
                planList.forEach(plan -> {
                    // 保存应收明细到数据库
                    saveReceivablePlan(plan, tender, receipt);
                });
            });
        } else {
            return "-1";
        }

        return DepositoryReturnCode.RETURN_CODE_00000.getCode();
    }

    /**
     * 保存还款计划到数据库
     *
     * @param projectDTO
     * @param fixedRepayment
     * @return
     */
    private List<RepaymentPlan> saveRepaymentPlan(ProjectDTO projectDTO, EqualInterestRepayment fixedRepayment) {
        List<RepaymentPlan> repaymentPlanList = new ArrayList<>();
        // 获取每期利息
        final Map<Integer, BigDecimal> interestMap = fixedRepayment.getInterestMap();
        // 平台收取利息
        final Map<Integer, BigDecimal> commissionMap = fixedRepayment.getCommissionMap();

        // 获取每期本金
        fixedRepayment.getPrincipalMap().forEach((k, v) -> {
            // 还款计划封装数据
            final RepaymentPlan repaymentPlan = new RepaymentPlan();
            // 标的id
            repaymentPlan.setProjectId(projectDTO.getId());
            // 发标人用户标识
            repaymentPlan.setConsumerId(projectDTO.getConsumerId());
            // 发标人用户编码
            repaymentPlan.setUserNo(projectDTO.getUserNo());
            // 标的编码
            repaymentPlan.setProjectNo(projectDTO.getProjectNo());
            // 期数
            repaymentPlan.setNumberOfPeriods(k);
            // 当期还款利息
            repaymentPlan.setInterest(interestMap.get(k));
            // 还款本金
            repaymentPlan.setPrincipal(v);
            // 本息 = 本金 + 利息
            repaymentPlan.setAmount(repaymentPlan.getPrincipal().add(repaymentPlan.getInterest()));
            // 应还时间 = 当前时间 + 期数( 单位月 )
            repaymentPlan.setShouldRepaymentDate(DateUtil.localDateTimeAddMonth(DateUtil.now(), k));
            // 应还状态, 当前业务为待还
            repaymentPlan.setRepaymentStatus("0");
            // 计划创建时间
            repaymentPlan.setCreateDate(DateUtil.now());
            // 设置平台佣金( 借款人让利 ) 注意这个地方是 具体佣金
            repaymentPlan.setCommission(commissionMap.get(k));
            // 保存到数据库
            planMapper.insert(repaymentPlan);
            repaymentPlanList.add(repaymentPlan);
        });

        return repaymentPlanList;
    }

    /**
     * 保存应收明细到数据库
     *
     * @param repaymentPlan
     * @param tender
     * @param receipt
     */
    private void saveReceivablePlan(RepaymentPlan repaymentPlan, TenderDTO tender, EqualInterestRepayment receipt) {
        // 应收本金
        final Map<Integer, BigDecimal> principalMap = receipt.getPrincipalMap();
        // 应收利息
        final Map<Integer, BigDecimal> interestMap = receipt.getInterestMap();
        // 平台收取利息
        final Map<Integer, BigDecimal> commissionMap = receipt.getCommissionMap();
        // 封装投资人应收明细
        ReceivablePlan receivablePlan = new ReceivablePlan();
        // 投标信息标识
        receivablePlan.setTenderId(tender.getId());
        // 设置期数
        receivablePlan.setNumberOfPeriods(repaymentPlan.getNumberOfPeriods());
        // 投标人用户标识
        receivablePlan.setConsumerId(tender.getConsumerId());
        // 投标人用户编码
        receivablePlan.setUserNo(tender.getUserNo());
        // 还款计划项标识
        receivablePlan.setRepaymentId(repaymentPlan.getId());
        // 应收利息
        receivablePlan.setInterest(interestMap.get(repaymentPlan.getNumberOfPeriods()));
        // 应收本金
        receivablePlan.setPrincipal(principalMap.get(repaymentPlan.getNumberOfPeriods()));
        // 应收本息 = 应收本金 + 应收利息
        receivablePlan.setAmount(receivablePlan.getInterest().add(receivablePlan.getPrincipal()));
        // 应收时间
        receivablePlan.setShouldReceivableDate(repaymentPlan.getShouldRepaymentDate());
        // 应收状态, 当前业务为未收
        receivablePlan.setReceivableStatus(0);
        // 创建时间
        receivablePlan.setCreateDate(DateUtil.now());
        // 设置投资人让利, 注意这个地方是具体: 佣金
        receivablePlan.setCommission(commissionMap.get(repaymentPlan.getNumberOfPeriods()));
        // 保存
        receivablePlanMapper.insert(receivablePlan);
    }

}
