package com.wanxin.common.domain;

/**
 * <P>
 * 还款方式 编码
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public enum RepaymentWayCode {
    /**
     * 一次性还款(含本息)
     */
    ALL("ALL", "一次性还款(含本息)"),

    /**
     * 先息后本
     */
    INTEREST_FIRST("INTEREST_FIRST", "先息后本"),

    /**
     * 等额本息
     */
    FIXED_REPAYMENT("FIXED_REPAYMENT", "等额本息"),

    /**
     * 等额本金
     */
    FIXED_CAPITAL("FIXED_CAPITAL", "等额本金");


    private String code;
    private String desc;

    RepaymentWayCode(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
