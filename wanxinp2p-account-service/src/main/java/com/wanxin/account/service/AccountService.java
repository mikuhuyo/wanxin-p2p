package com.wanxin.account.service;

import com.wanxin.common.domain.RestResponse;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface AccountService {
    /**
     * 获取手机验证码
     *
     * @param mobile 手机号
     * @return
     */
    RestResponse getSMSCode(String mobile);
}
