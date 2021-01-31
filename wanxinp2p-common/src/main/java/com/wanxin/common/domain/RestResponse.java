package com.wanxin.common.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@JsonInclude(Include.NON_NULL)
@ApiModel(value = "RestResponse<T>", description = "响应通用参数包装")
public class RestResponse<T> {

    @ApiModelProperty("响应错误编码,0为正常")
    private int code;

    @ApiModelProperty("响应错误信息")
    private String msg;

    @ApiModelProperty("响应内容")
    private T result;

    public RestResponse() {
        this(0, "");
    }

    public RestResponse(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public static <T> RestResponse<T> success() {
        return new RestResponse<T>();
    }

    public static <T> RestResponse<T> success(T result) {
        RestResponse<T> response = new RestResponse<T>();
        response.setResult(result);
        return response;
    }

    public static <T> RestResponse<T> validfail(String msg) {
        RestResponse<T> response = new RestResponse<T>();
        response.setCode(-2);
        response.setMsg(msg);
        return response;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getResult() {
        return result;
    }

    public void setResult(T result) {
        this.result = result;
    }

    @JsonIgnore
    public Boolean isSuccessful() {
        return this.code == 0;
    }

    @Override
    public String toString() {
        return "RestResponse [code=" + code + ", msg=" + msg + ", result="
                + result + "]";
    }

}
