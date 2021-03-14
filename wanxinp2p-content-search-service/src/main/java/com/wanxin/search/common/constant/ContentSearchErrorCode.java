package com.wanxin.search.common.constant;

import com.wanxin.common.domain.ErrorCode;

/**
 * 异常编码: 0成功, -1熔断, -2标准参数校验不通过, -3会话超时
 * 前两位: 服务标识
 * 中间两位: 模块标识
 * 后两位: 异常标识
 * 以19开始
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public enum ContentSearchErrorCode implements ErrorCode {
    /**
     * 不存在的用户信息
     */
    E_190102(190102, "请求失败"),
    ;

    private int code;
    private String desc;

    @Override
	public int getCode() {
        return code;
    }

    @Override
	public String getDesc() {
        return desc;
    }

    private ContentSearchErrorCode(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }


    public static ContentSearchErrorCode setErrorCode(int code) {
        for (ContentSearchErrorCode errorCode : ContentSearchErrorCode.values()) {
            if (errorCode.getCode() == code) {
                return errorCode;
            }
        }
        return null;
    }
}
