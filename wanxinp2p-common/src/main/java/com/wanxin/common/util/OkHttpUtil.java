package com.wanxin.common.util;

import com.alibaba.fastjson.JSON;
import com.wanxin.common.domain.CommonErrorCode;
import com.wanxin.common.domain.RestResponse;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

/**
 * OKHTTP 请求工具类
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class OkHttpUtil {
    private static OkHttpClient okHttpClient = new OkHttpClient().newBuilder().retryOnConnectionFailure(true)
            .connectTimeout(10, TimeUnit.SECONDS)
            .readTimeout(10, TimeUnit.SECONDS)
            .writeTimeout(10, TimeUnit.SECONDS).build();

    private static final MediaType JSON_TYPE = MediaType.parse("application/json; charset=utf-8");

    /**
     * 发送post请求
     *
     * @param url
     * @param json
     * @return
     */
    public static RestResponse post(String url, String json) {
        okhttp3.RequestBody body = okhttp3.RequestBody.create(JSON_TYPE, json);
        Request request = new Request.Builder().url(url).post(body).build();
        try (Response response = okHttpClient.newCall(request).execute()) {
            okhttp3.ResponseBody responseBody = response.body();
            if (responseBody != null) {
                return JSON.parseObject(responseBody.string(), RestResponse.class);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return RestResponse.validfail(CommonErrorCode.E_100106.getDesc());
    }
}
