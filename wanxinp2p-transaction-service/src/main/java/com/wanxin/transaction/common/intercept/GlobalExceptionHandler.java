package com.wanxin.transaction.common.intercept;

import com.wanxin.common.domain.BusinessException;
import com.wanxin.common.domain.CommonErrorCode;
import com.wanxin.common.domain.RestResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.Nullable;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(value = Exception.class)
    public RestResponse<Nullable> exceptionGet(HttpServletRequest req, HttpServletResponse response, Exception e) {
        if (e instanceof BusinessException) {
            BusinessException be = (BusinessException) e;
            if (CommonErrorCode.CUSTOM.equals(be.getErrorCode())) {
                return new RestResponse<Nullable>(be.getErrorCode().getCode(), be.getMessage());
            } else {
                return new RestResponse<Nullable>(be.getErrorCode().getCode(), be.getErrorCode().getDesc());
            }

        } else if (e instanceof NoHandlerFoundException) {
            return new RestResponse<Nullable>(404, "找不到资源");
        } else if (e instanceof HttpRequestMethodNotSupportedException) {
            return new RestResponse<Nullable>(405, "method 方法不支持");
        } else if (e instanceof HttpMediaTypeNotSupportedException) {
            return new RestResponse<Nullable>(415, "不支持媒体类型");
        }

        log.error("[系统异常]-{}", e);
        return new RestResponse<Nullable>(CommonErrorCode.UNKOWN.getCode(), CommonErrorCode.UNKOWN.getDesc());
    }

}
