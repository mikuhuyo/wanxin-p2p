package com.wanxin.api.account;

import com.wanxin.common.domain.RestResponse;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface AccountAPI {
    /**
     * 获取短信验证码
     *
     * @param mobile 手机号
     * @return
     */
    RestResponse getSMSCode(String mobile);
}
