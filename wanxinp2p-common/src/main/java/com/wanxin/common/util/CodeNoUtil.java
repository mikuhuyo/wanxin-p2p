package com.wanxin.common.util;

import com.wanxin.common.domain.CodePrefixCode;

import java.util.UUID;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class CodeNoUtil {
    /**
     * 使用UUID使用编码
     *
     * @param prefixCode 前缀用与标识不同业务, 已用枚举类型规定业务名称
     * @return java.lang.String
     */
    public static String getNo(CodePrefixCode prefixCode) {

        return prefixCode.getCode() + UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
    }
}
