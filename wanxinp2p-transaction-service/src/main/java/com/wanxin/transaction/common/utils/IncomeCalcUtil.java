package com.wanxin.transaction.common.utils;

import java.math.BigDecimal;

/**
 * <P>
 * 投资人预期收益计算工具
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class IncomeCalcUtil {

    /**
     * 等额本息 投资人收益计算
     *
     * @param invest   投资金额
     * @param yearRate 年利率
     * @param month    月数
     * @return 总收益
     */
    public static BigDecimal getIncomeTotalInterest(BigDecimal invest, BigDecimal yearRate, int month) {
        // 计算月利率
        double monthRate = yearRate.doubleValue() / 12;
        BigDecimal totalInterest = new BigDecimal(0);
        // 计算月息并累加
        for (int i = 1; i < month + 1; i++) {
            BigDecimal multiply = invest.multiply(new BigDecimal(monthRate));
            BigDecimal sub = new BigDecimal(Math.pow(1 + monthRate, month)).subtract(new BigDecimal(Math.pow(1 + monthRate, i - 1)));
            BigDecimal monthInterest = multiply.multiply(sub).divide(new BigDecimal(Math.pow(1 + monthRate, month) - 1), 6, BigDecimal.ROUND_DOWN);
            monthInterest = monthInterest.setScale(2, BigDecimal.ROUND_DOWN);
            totalInterest = totalInterest.add(monthInterest);
        }
        return totalInterest;
    }
}
