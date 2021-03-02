package com.wanxin.transaction.common.utils;

import com.alibaba.fastjson.JSONObject;
import com.wanxin.api.account.model.LoginUser;
import com.wanxin.common.util.EncryptUtil;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class SecurityUtil {

    /**
     * 获取当前登录用户
     */
    public static LoginUser getUser() {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        LoginUser loginUser = new LoginUser();
        if (servletRequestAttributes != null) {
            HttpServletRequest request = servletRequestAttributes.getRequest();

            Map jwt = JSONObject.parseObject(EncryptUtil.decodeBase64(request.getHeader("jsonToken")), Map.class);
            if (jwt.get("mobile").toString() != null && !"".equals(jwt.get("mobile").toString())) {
                loginUser.setMobile(jwt.get("mobile").toString());
            }

            if (jwt.get("client_id").toString() != null && !"".equals(jwt.get("client_id").toString())) {
                loginUser.setClientId(jwt.get("client_id").toString());
            }
        }

        return loginUser;
    }

}
