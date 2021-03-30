package com.wanxin.consumer.utils;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;

/**
 * okHttp3请求工具类
 *
 * @author yuelimin
 * @since 1.8
 */
public class OkHttpUtil {
    /**
     * okHttp 同步 GET 请求
     *
     * @param url
     * @return
     */
    public static String doSyncGet(String url) throws IOException {
        OkHttpClient okHttpClient = new OkHttpClient();
        Request build = new Request.Builder().url(url).build();
        Response execute = okHttpClient.newCall(build).execute();
        assert execute.body() != null;
        return execute.body().string();
    }
}
