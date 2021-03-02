package com.wanxin.consumer.utils;

import com.wanxin.common.domain.BusinessException;
import com.wanxin.consumer.common.ConsumerErrorCode;

import java.net.URLEncoder;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class BaiDuOrcIdCardUtil {
    private static final String URL = "https://aip.baidubce.com/rest/2.0/ocr/v1/idcard";

    public static String idCardBack(byte[] imgData) {
        try {
            String imgStr = Base64Util.encode(imgData);
            String imgParam = URLEncoder.encode(imgStr, "UTF-8");

            String param = "id_card_side=" + "back" + "&image=" + imgParam;
            String accessToken = BaiDuOrcAuthServiceUtil.getAuth();

            return HttpUtil.post(URL, accessToken, param);
        } catch (Exception e) {
            throw new BusinessException(ConsumerErrorCode.E_140162);
        }
    }

    public static String idCardFront(byte[] imgData) {
        try {
            String imgStr = Base64Util.encode(imgData);
            String imgParam = URLEncoder.encode(imgStr, "UTF-8");

            String param = "id_card_side=" + "front" + "&image=" + imgParam;
            String accessToken = BaiDuOrcAuthServiceUtil.getAuth();

            return HttpUtil.post(URL, accessToken, param);
        } catch (Exception e) {
            throw new BusinessException(ConsumerErrorCode.E_140162);
        }
    }
}
