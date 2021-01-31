package com.wanxin.account.common;

import com.wanxin.common.domain.ErrorCode;

/**
 * 异常编码 0成功, -1熔断,  -2 标准参数校验不通过, -3会话超时
 * 前两位:服务标识
 * 中间两位:模块标识
 * 后两位:异常标识
 * 统一账号服务异常编码 以13开始
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public enum AccountErrorCode implements ErrorCode {
    E_130101(130101, "用户名已存在"),
    E_130104(130104, "用户未注册"),
    E_130105(130105, "用户名或密码错误"),
    E_140141(140141, "注册失败"),

    E_140151(140151, "获取短信验证码失败"),
    E_140152(140152, "验证码错误");

    private int code;
    private String desc;

    private AccountErrorCode(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static AccountErrorCode setErrorCode(int code) {
        for (AccountErrorCode errorCode : AccountErrorCode.values()) {
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
