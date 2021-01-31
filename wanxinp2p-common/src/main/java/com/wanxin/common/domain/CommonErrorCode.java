package com.wanxin.common.domain;

/**
 * 异常编码: 0成功, -1熔断, -2 标准参数校验不通过, -3会话超时
 * 前两位:服务标识
 * 中间两位:模块标识
 * 后两位:异常标识
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public enum CommonErrorCode implements ErrorCode {

    ////////////////////////////////////公用异常编码 //////////////////////////

    SUCCESS(0, "成功"),
    FUSE(-1, "网关调用熔断"),

    /**
     * 传入参数与接口不匹配
     */
    E_100101(100101, "传入参数与接口不匹配"),
    /**
     * 验证码错误
     */
    E_100102(100102, "验证码错误"),
    /**
     * 验证码为空
     */
    E_100103(100103, "验证码为空"),
    /**
     * 查询结果为空
     */
    E_100104(100104, "查询结果为空"),
    /**
     * ID格式不正确或超出Long存储范围
     */
    E_100105(100105, "ID格式不正确或超出Long存储范围"),

    E_100106(100106, "请求失败"),

    E_999990(999990, "调用微服务-交易中心 被熔断"),
    E_999991(999991, "调用微服务-授权服务 被熔断"),
    E_999992(999992, "调用微服务-用户服务 被熔断"),
    E_999993(999993, "调用微服务-资源服务 被熔断"),
    E_999994(999994, "调用微服务-同步服务 被熔断"),
    E_999995(999995, "调用微服务-统一账户服务 被熔断"),
    E_999996(999996, "调用微服务-存管代理服务 被熔断"),
    /**
     * 调用微服务-还款服务 被熔断
     */
    E_999997(999997, "调用微服务-还款服务 被熔断"),
    CUSTOM(999998, "自定义异常"),
    /**
     * 未知错误
     */
    UNKOWN(999999, "未知错误");


    private int code;
    private String desc;

    private CommonErrorCode(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static CommonErrorCode setErrorCode(int code) {
        for (CommonErrorCode errorCode : CommonErrorCode.values()) {
            if (errorCode.getCode() == code) {
                return errorCode;
            }
        }
        return null;
    }

    @Override
    public int getCode() {
        return code;
    }

    @Override
    public String getDesc() {
        return desc;
    }
}
