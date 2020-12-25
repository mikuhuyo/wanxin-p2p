package com.wanxin.consumer.common;

import com.wanxin.common.domain.ErrorCode;

/**
 * 异常编码 0成功, -1熔断,  -2 标准参数校验不通过, -3会话超时
 * 前两位:服务标识
 * 中间两位:模块标识
 * 后两位:异常标识
 * 统一账号服务异常编码 以14开始
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public enum ConsumerErrorCode implements ErrorCode {
	////////////////////////////////////c端用户服务异常编码 //////////////////////////
	/**
	 * 不存在的用户信息
	 */
	E_140101(140101,"不存在的用户信息"),
	E_140102(140102,"请求失败"),
	E_140105(140105,"用户已开户"),
	E_140106(140106,"注册失败"),
	E_140107(140107, "用户已存在"),
	E_140108(140108, "身份信息不一致"),

	E_140131(140131,"用户充值失败"),
	E_140132(140132,"用户存管账户未开通成功"),


	E_140141(140141,"用户提现失败"),


	E_140151(140151,"银行卡已被绑定");

	private int code;
	private String desc;

	public int getCode() {
		return code;
	}

	public String getDesc() {
		return desc;
	}

	private ConsumerErrorCode(int code, String desc) {
		this.code = code;
		this.desc = desc;
	}


	public static ConsumerErrorCode setErrorCode(int code) {
       for (ConsumerErrorCode errorCode : ConsumerErrorCode.values()) {
           if (errorCode.getCode()==code) {
               return errorCode;
           }
       }
	       return null;
	}
}
