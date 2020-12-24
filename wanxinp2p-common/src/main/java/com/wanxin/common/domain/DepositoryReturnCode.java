package com.wanxin.common.domain;

/**
 * <P>
 * 存管系统返回状态码
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public enum DepositoryReturnCode {
    /**
     * 成功标记
     */
    RETURN_CODE_00000("00000", "成功"),
    /**
     * 系统异常
     */
    RETURN_CODE_00001("00001", "系统异常"),
    /**
     * 系统内部错误
     */
    RETURN_CODE_00002("00002", "系统内部错误"),
    /**
     * 系统内部错误
     */
    RETURN_CODE_00003("00003", "参数校验不通过"),
    /**
     * 系统内部错误
     */
    RETURN_CODE_00004("00004", "签名验证失败");

    private String code;
    private String desc;

    DepositoryReturnCode(String code, String desc) {
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
