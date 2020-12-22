package com.wanxin.common.util;

import org.apache.commons.lang.StringUtils;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class CommonUtil {

    public static String hiddenMobile(String mobile) {
        if (StringUtils.isBlank(mobile)) {
            return "";
        }
        return mobile.replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2");
    }

}

