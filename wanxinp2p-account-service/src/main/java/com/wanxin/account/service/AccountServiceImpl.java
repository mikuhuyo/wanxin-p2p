package com.wanxin.account.service;

import com.wanxin.common.domain.RestResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Service
public class AccountServiceImpl implements AccountService {
    @Autowired
    private SmsService smsService;
    @Value("${sms.enable}")
    private Boolean smsEnable;

    @Override
    public RestResponse getSMSCode(String mobile) {
        return smsService.getSMSCode(mobile);
    }
}
