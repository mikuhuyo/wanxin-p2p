package com.wanxin.consumer.utils;

import com.alibaba.fastjson.JSONObject;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.consumer.common.ConsumerErrorCode;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;
import java.util.Map;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class CheckBankCardUtil {
    public static void checkBankCard(String cardNumber) throws IOException {
        OkHttpClient client = new OkHttpClient().newBuilder().build();
        Request request = new Request.Builder()
                .url("https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardNo=" + cardNumber + "&cardBinCheck=true")
                .method("GET", null)
                .addHeader("Cookie", "JSESSIONID=E9479B7122FF4D7DFD789422E5F2FE5B; spanner=QPUjmjZ36a0Oy1dCyZ/e4NZpyo/Q9t1O4EJoL7C0n0A=")
                .build();
        Response execute = client.newCall(request).execute();
        assert execute.body() != null;
        String response = execute.body().string();

        Map map = JSONObject.parseObject(response, Map.class);
        if (!(Boolean) map.get("validated")) {
            throw new BusinessException(ConsumerErrorCode.E_140109);
        }
    }
}
