package com.wanxin.account.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.account.entity.Account;
import com.wanxin.account.mapper.AccountMapper;
import com.wanxin.common.domain.RestResponse;
import org.springframework.beans.factory.annotation.Autowired;
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
    @Autowired
    private AccountMapper accountMapper;

    @Override
    public Integer checkMobile(String mobile, String key, String code) {
        // 当校验失败的时候回抛出异常
        smsService.verifySmsCode(key, code);
        Integer count = accountMapper.selectCount(new LambdaQueryWrapper<Account>().eq(Account::getMobile, mobile));
        return count > 0 ? 1 : 0;
    }

    @Override
    public RestResponse getSMSCode(String mobile) {
        return smsService.getSMSCode(mobile);
    }
}
