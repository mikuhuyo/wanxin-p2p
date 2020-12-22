package com.wanxin.gateway.common.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.wanxin.common.domain.RestResponse;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class HttpUtil {
    public static void writerError(RestResponse restResponse, HttpServletResponse response) throws IOException {
        response.setContentType("application/json,charset=utf-8");
        response.setStatus(restResponse.getCode());
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.writeValue(response.getOutputStream(), restResponse);
    }
}
