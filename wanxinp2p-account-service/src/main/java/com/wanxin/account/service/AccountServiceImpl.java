package com.wanxin.account.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.account.entity.Account;
import com.wanxin.account.mapper.AccountMapper;
import com.wanxin.api.account.model.AccountDTO;
import com.wanxin.api.account.model.AccountRegisterDTO;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.common.domain.StatusCode;
import com.wanxin.common.util.PasswordUtil;
import org.springframework.beans.BeanUtils;
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
    @Autowired
    private AccountMapper accountMapper;

    @Value("${sms.enable}")
    private Boolean smsEnable;

    /**
     * 用户注册
     *
     * @param registerDTO
     * @return
     */
    @Override
    public AccountDTO registry(AccountRegisterDTO registerDTO) {
        Account account = new Account();
        account.setUsername(registerDTO.getUsername());
        account.setMobile(registerDTO.getMobile());
        account.setPassword(PasswordUtil.generate(registerDTO.getPassword()));
        if (smsEnable) {
            account.setPassword(PasswordUtil.generate(account.getMobile()));
        }
        account.setDomain("c");
        account.setStatus(StatusCode.STATUS_OUT.getCode());
        accountMapper.insert(account);
        return convertAccountEntityToDTO(account);
    }

    /**
     * 对象转换, 我们这里其实可以使用MapStruct进行对象转换.
     *
     * @param entity Account实体类
     * @return
     */
    private AccountDTO convertAccountEntityToDTO(Account entity) {
        if (entity == null) {
            return null;
        }

        AccountDTO dto = new AccountDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }

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
