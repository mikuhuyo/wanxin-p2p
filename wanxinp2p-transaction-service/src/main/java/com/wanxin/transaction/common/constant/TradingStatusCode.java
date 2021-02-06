package com.wanxin.transaction.common.constant;

/**
 * <P>
 * 交易状态枚举类
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public enum TradingStatusCode {
    /**
     * 交易已受理
     */
    STATUS_ACCEPT("ACCEPT", "已受理"),
    /**
     * 交易成功
     */
    STATUS_SUCCESS("SUCCESS", "交易成功"),
    /**
     * 交易失败
     */
    STATUS_FAIL("FAIL", "交易失败"),
    /**
     * 债权出让中
     */
    STATUS_ONSALE("ONSALE", "债权出让中"),
    /**
     * 已结束
     */
    STATUS_COMPLETED("COMPLETED", "已结束"),
    /**
     * 初始状态
     */
    STATUS_INIT("INIT", "初始状态"),
    /**
     * 处理中
     */
    STATUS_PROCESSING("PROCESSING", "处理中"),
    /**
     * 已退款
     */
    STATUS_REFUNDED("REFUNDED", "已退款");

    private String code;
    private String desc;

    TradingStatusCode(String code, String desc) {
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
