package com.wanxin.transaction.interceptor;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.wanxin.api.account.model.LoginUser;
import com.wanxin.common.util.EncryptUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <P>
 * Token 拦截处理
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class TokenInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) {
		String jsonToken = httpServletRequest.getParameter("jsonToken");
		if (StringUtils.isNotBlank(jsonToken)) {
			LoginUser loginUser = JSON.parseObject(EncryptUtil.decodeUTF8StringBase64(jsonToken), new TypeReference<LoginUser>() {});
			httpServletRequest.setAttribute("jsonToken", loginUser);
		}
		return true;
	}

}
