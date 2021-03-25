package com.wanxin.api.transaction.model;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * <P>
 * 标的还款信息
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Data
public class ProjectWithTendersDTO {
    /**
     * 标的信息
     */
    private ProjectDTO project;

    /**
     * 标的对应的所有投标记录
     */
    private List<TenderDTO> tenders;

    /**
     * 投资人让出利率 (投资人让利)
     */
    private BigDecimal commissionInvestorAnnualRate;

    /**
     * 借款人给平台的利率 (借款人让利)
     */
    private BigDecimal commissionBorrowerAnnualRate;
}
