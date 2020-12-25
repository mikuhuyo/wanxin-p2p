package com.wanxin.api.account;

import com.wanxin.api.account.model.AccountDTO;
import com.wanxin.api.account.model.AccountLoginDTO;
import com.wanxin.api.account.model.AccountRegisterDTO;
import com.wanxin.common.domain.RestResponse;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public interface AccountAPI {
    /**
     * 用户登录
     *
     * @param accountLoginDTO 封装登录请求数据
     * @return
     */
    RestResponse<AccountDTO> login(AccountLoginDTO accountLoginDTO);

    /**
     * 用户注册
     *
     * @param accountRegisterDTO 注册信息实体类
     * @return
     */
    RestResponse<AccountDTO> registry(AccountRegisterDTO accountRegisterDTO);

    /**
     * 校验手机号和验证码
     *
     * @param mobile 手机号
     * @param key    校验标识
     * @param code   验证码
     * @return
     */
    RestResponse<Integer> checkMobile(String mobile, String key, String code);

    /**
     * 获取短信验证码
     *
     * @param mobile 手机号
     * @return
     */
    RestResponse getSMSCode(String mobile);
}
