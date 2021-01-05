package com.wanxin.depository.interceptor;

import com.wanxin.common.util.EncryptUtil;
import com.wanxin.common.util.RSAUtil;
import com.wanxin.depository.common.constant.DepositoryErrorCode;
import com.wanxin.depository.service.ConfigService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 统一拦截银行存管系统请求数据验签
 *
 * @author yuelimin
 * @since 1.8
 */
@Slf4j
@Component
public class DepositoryNotifyVerificationInterceptor implements HandlerInterceptor {

    @Autowired
    private ConfigService configService;

    @Override
    public boolean preHandle(HttpServletRequest httpRequest, HttpServletResponse httpResponse, Object handler) {
        String serviceName = httpRequest.getParameter("serviceName");
        String platformNo = httpRequest.getParameter("platformNo");
        String signature = httpRequest.getParameter("signature");
        String reqData = httpRequest.getParameter("reqData");

        //校验参数是否为空
        if (StringUtils.isBlank(serviceName) || StringUtils.isBlank(platformNo) || StringUtils.isBlank(reqData)
                || StringUtils.isBlank(signature)) {
            responseOut(httpResponse, DepositoryErrorCode.E_160101.getDesc());
            return false;
        }

        //校验银行存管系统签名
        reqData = EncryptUtil.decodeUTF8StringBase64(reqData);
        if (!verifySignature(signature, reqData)) {
            responseOut(httpResponse, DepositoryErrorCode.E_160101.getDesc());
            return false;
        }

        return true;
    }

    /**
     * 验签
     *
     * @param signature
     * @param reqData
     * @return
     */
    private boolean verifySignature(String signature, String reqData) {
        //获取P2P平台公钥
        String p2pPublicKey = configService.getDepositoryPublicKey();
        if (StringUtils.isBlank(p2pPublicKey)) {
            return false;
        }
        //验证签名
        return RSAUtil.verify(reqData, signature, p2pPublicKey, "utf-8");
    }

    /**
     * 设置HttpResponse返回指定数据
     *
     * @param response
     * @param s
     */
    private void responseOut(HttpServletResponse response, String s) {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter pw = response.getWriter()) {
            pw.write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
