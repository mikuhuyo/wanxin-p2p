package com.wanxin.repayment.utils;

import com.wanxin.api.repayment.model.EqualInterestRepayment;
import com.wanxin.api.repayment.model.EqualPrincipalRepayment;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * <P>
 * 还款计算工具类
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class RepaymentUtil {
    /**
     * 生成等额本息还款计划
     *
     * @param invest   本金
     * @param month    分期, 期数( 单位月 )
     * @param yearRate 年利率
     * @return
     */
    public static EqualInterestRepayment fixedRepayment(BigDecimal invest, BigDecimal yearRate, int month, BigDecimal commission) {
        // 计算月利率
        double monthRate = yearRate.doubleValue() / 12;
        // 封装数据
        EqualInterestRepayment equalInterestRepayment = new EqualInterestRepayment();
        // 每月还款本息
        equalInterestRepayment.setAmount(getRepaymentAmount(invest, monthRate, month));
        // 每月还款利息
        equalInterestRepayment.setInterestMap(getRepaymentList(invest, monthRate, month));
        // 每月还款本金
        equalInterestRepayment.setPrincipalMap(getRepaymentPrincipalList(invest, monthRate, month));
        // 本息总和
        equalInterestRepayment.setTotalAmount(getRepaymentTotalAmount(invest, monthRate, month));
        // 总利息
        equalInterestRepayment.setTotalInterest(getRepaymentTotalInterest(invest, monthRate, month));
        // 设置平台抽息
        double comMonthRateRate = commission.doubleValue() / 12;
        equalInterestRepayment.setCommissionMap(getRepaymentList(invest, comMonthRateRate, month));
        // 返回结果
        return equalInterestRepayment;
    }

    /**
     * 等额本息计算获取还款方式为等额本息的每月偿还本金和利息
     * 公式: 每月偿还本息=〔贷款本金×月利率×(1＋月利率)＾还款月数〕÷〔(1＋月利率)＾还款月数-1〕
     *
     * @param invest    总借款额(贷款本金)
     * @param monthRate 月利率
     * @param month     还款总月数
     * @return 每月偿还本金和利息, 不四舍五入, 直接截取小数点最后两位
     */
    private static BigDecimal getRepaymentAmount(BigDecimal invest, Double monthRate, int month) {
        return invest.multiply(new BigDecimal(monthRate * Math.pow(1 + monthRate, month)))
                .divide(new BigDecimal(Math.pow(1 + monthRate, month) - 1), 2, BigDecimal.ROUND_DOWN);
    }

    /**
     * 等额本息计算获取还款方式为等额本息的每月偿还利息
     * 公式: 每月偿还利息=贷款本金×月利率×〔(1+月利率)^还款月数-(1+月利率)^(还款月序号-1)〕÷〔(1+月利率)^还款月数-1〕
     *
     * @param invest    总借款额(贷款本金)
     * @param monthRate 月利率
     * @param month     还款总月数
     * @return 每月偿还利息
     */
    private static Map<Integer, BigDecimal> getRepaymentList(BigDecimal invest, Double monthRate, int month) {
        Map<Integer, BigDecimal> map = new HashMap<Integer, BigDecimal>();
        BigDecimal monthInterest;
        for (int i = 1; i < month + 1; i++) {
            BigDecimal multiply = invest.multiply(new BigDecimal(monthRate));
            BigDecimal sub = new BigDecimal(Math.pow(1 + monthRate, month)).subtract(new BigDecimal(Math.pow(1 + monthRate, i - 1)));
            monthInterest = multiply.multiply(sub).divide(new BigDecimal(Math.pow(1 + monthRate, month) - 1), 6, BigDecimal.ROUND_DOWN);
            monthInterest = monthInterest.setScale(2, BigDecimal.ROUND_DOWN);
            map.put(i, monthInterest);
        }
        return map;
    }

    /**
     * 等额本息计算获取还款方式为等额本息的每月偿还本金
     *
     * @param invest    总借款额(贷款本金)
     * @param monthRate 月利率
     * @param month     还款总月数
     * @return 每月偿还本金
     */
    private static Map<Integer, BigDecimal> getRepaymentPrincipalList(BigDecimal invest, Double monthRate, int month) {
        BigDecimal monthIncome = invest.multiply(new BigDecimal(monthRate * Math.pow(1 + monthRate, month)))
                .divide(new BigDecimal(Math.pow(1 + monthRate, month) - 1), 2, BigDecimal.ROUND_DOWN);
        Map<Integer, BigDecimal> mapInterest = getRepaymentList(invest, monthRate, month);
        Map<Integer, BigDecimal> mapPrincipal = new HashMap<Integer, BigDecimal>();
        for (Map.Entry<Integer, BigDecimal> entry : mapInterest.entrySet()) {
            mapPrincipal.put(entry.getKey(), monthIncome.subtract(entry.getValue()));
        }
        return mapPrincipal;
    }

    /**
     * 等额本息计算获取还款方式为等额本息的总利息
     *
     * @param invest    总借款额(贷款本金)
     * @param monthRate 年利率
     * @param month     还款总月数
     * @return 总利息
     */
    private static BigDecimal getRepaymentTotalInterest(BigDecimal invest, Double monthRate, int month) {
        BigDecimal count = new BigDecimal(0);
        Map<Integer, BigDecimal> mapInterest = getRepaymentList(invest, monthRate, month);
        for (Map.Entry<Integer, BigDecimal> entry : mapInterest.entrySet()) {
            count = count.add(entry.getValue());
        }
        return count;
    }

    /**
     * 应还本金总和
     *
     * @param invest    总借款额(贷款本金)
     * @param monthRate 年利率
     * @param month     还款总月数
     * @return 应还本金总和
     */
    private static BigDecimal getRepaymentTotalAmount(BigDecimal invest, double monthRate, int month) {
        BigDecimal perMonthInterest = invest.multiply(new BigDecimal(monthRate * Math.pow(1 + monthRate, month)))
                .divide(new BigDecimal(Math.pow(1 + monthRate, month) - 1), 2, BigDecimal.ROUND_DOWN);
        BigDecimal count = perMonthInterest.multiply(new BigDecimal(month));
        count = count.setScale(2, BigDecimal.ROUND_DOWN);
        return count;
    }


    /**
     * 生成等额本金计划
     *
     * @param invest   本金
     * @param month    分期, 期数
     * @param yearRate 年利率
     * @return
     */
    public static EqualPrincipalRepayment fixedCapital(BigDecimal invest, BigDecimal yearRate, int month, BigDecimal commission) {
        // 计算月利率
        double monthRate = yearRate.doubleValue() / 12;
        // 封装数据
        EqualPrincipalRepayment equalPrincipalRepayment = new EqualPrincipalRepayment();
        // 每月还款本息
        equalPrincipalRepayment.setAmountMap(getCapitalAmountList(invest, monthRate, month));
        // 每月还款利息
        equalPrincipalRepayment.setInterestMap(getCapitalInterestList(invest, monthRate, month));
        // 每月还款本金
        equalPrincipalRepayment.setPrincipal(getCapitalPrincipal(invest, month));
        // 总利息
        equalPrincipalRepayment.setTotalInterest(getCapitalTotalInterest(invest, monthRate, month));
        // 本息总和
        equalPrincipalRepayment.setTotalAmount(invest.add(equalPrincipalRepayment.getTotalInterest()));
        // 设置平台抽息
        double comMonthRateRate = commission.doubleValue() / 12;
        equalPrincipalRepayment.setCommissionMap(getCapitalInterestList(invest, comMonthRateRate, month));
        // 返回结果
        return equalPrincipalRepayment;
    }

    /**
     * 等额本金计算获取还款方式为等额本金的每月偿还本金和利息
     * 公式: 每月偿还本金=(贷款本金÷还款月数)+(贷款本金-已归还本金累计额)×月利率
     *
     * @param invest    总借款额(贷款本金)
     * @param monthRate 年利率
     * @param month     还款总月数
     * @return 每月偿还本金和利息, 不四舍五入, 直接截取小数点最后两位
     */
    private static Map<Integer, BigDecimal> getCapitalAmountList(BigDecimal invest, double monthRate, int month) {
        Map<Integer, BigDecimal> map = new HashMap<Integer, BigDecimal>();
        // 每月本金
        double monthPri = getCapitalPrincipal(invest, month).doubleValue();
        monthRate = new BigDecimal(monthRate).setScale(6, BigDecimal.ROUND_DOWN).doubleValue();
        for (int i = 1; i <= month; i++) {
            BigDecimal monthRes = new BigDecimal(monthPri + (invest.doubleValue() - monthPri * (i - 1)) * monthRate);
            monthRes = monthRes.setScale(2, BigDecimal.ROUND_DOWN);
            map.put(i, monthRes);
        }
        return map;
    }

    /**
     * 等额本金计算获取还款方式为等额本金的每月偿还本金
     * 公式: 每月应还本金=贷款本金÷还款月数
     *
     * @param invest 总借款额(贷款本金)
     * @param month  还款总月数
     * @return 每月偿还本金
     */
    private static BigDecimal getCapitalPrincipal(BigDecimal invest, int month) {
        BigDecimal monthIncome = invest.divide(new BigDecimal(month), 2, BigDecimal.ROUND_DOWN);
        return monthIncome;
    }

    /**
     * 等额本金计算获取还款方式为等额本金的每月偿还利息
     * 公式: 每月应还利息=剩余本金×月利率=(贷款本金-已归还本金累计额)×月利率
     *
     * @param invest    总借款额(贷款本金)
     * @param monthRate 年利率
     * @param month     还款总月数
     * @return 每月偿还利息
     */
    private static Map<Integer, BigDecimal> getCapitalInterestList(BigDecimal invest, double monthRate, int month) {
        Map<Integer, BigDecimal> inMap = new HashMap<Integer, BigDecimal>();
        BigDecimal principal = getCapitalPrincipal(invest, month);
        Map<Integer, BigDecimal> map = getCapitalAmountList(invest, monthRate, month);
        for (Map.Entry<Integer, BigDecimal> entry : map.entrySet()) {
            BigDecimal interestBigDecimal = entry.getValue().subtract(principal);
            interestBigDecimal = interestBigDecimal.setScale(2, BigDecimal.ROUND_DOWN);
            inMap.put(entry.getKey(), interestBigDecimal);
        }
        return inMap;
    }

    /**
     * 等额本金计算获取还款方式为等额本金的总利息
     *
     * @param invest    总借款额(贷款本金)
     * @param monthRate 年利率
     * @param month     还款总月数
     * @return 总利息
     */
    public static BigDecimal getCapitalTotalInterest(BigDecimal invest, double monthRate, int month) {
        BigDecimal count = new BigDecimal(0);
        Map<Integer, BigDecimal> mapInterest = getCapitalInterestList(invest, monthRate, month);
        for (Map.Entry<Integer, BigDecimal> entry : mapInterest.entrySet()) {
            count = count.add(entry.getValue());
        }
        return count;
    }
}
