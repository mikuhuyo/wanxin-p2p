package com.wanxin.common.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Base64;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class EncryptUtil {

    public static String encodeBase64(byte[] bytes) {
        String encoded = Base64.getEncoder().encodeToString(bytes);
        return encoded;
    }

    public static byte[] decodeBase64(String str) {
        byte[] bytes = null;
        bytes = Base64.getDecoder().decode(str);
        return bytes;
    }

    public static String encodeUTF8StringBase64(String str) {
        String encoded = null;
        try {
            encoded = Base64.getEncoder().encodeToString(str.getBytes("utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return encoded;

    }

    public static String decodeUTF8StringBase64(String str) {
        String decoded = null;
        byte[] bytes = Base64.getDecoder().decode(str);
        try {
            decoded = new String(bytes, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return decoded;
    }

    public static String encodeURL(String url) {
        String encoded = null;
        try {
            encoded = URLEncoder.encode(url, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return encoded;
    }

    public static String decodeURL(String url) {
        String decoded = null;
        try {
            decoded = URLDecoder.decode(url, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return decoded;
    }

}
