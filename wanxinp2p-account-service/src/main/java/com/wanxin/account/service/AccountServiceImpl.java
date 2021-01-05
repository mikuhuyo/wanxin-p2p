package com.wanxin.account.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.account.common.AccountErrorCode;
import com.wanxin.account.entity.Account;
import com.wanxin.account.mapper.AccountMapper;
import com.wanxin.api.account.model.AccountDTO;
import com.wanxin.api.account.model.AccountLoginDTO;
import com.wanxin.api.account.model.AccountRegisterDTO;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.common.domain.StatusCode;
import com.wanxin.common.util.PasswordUtil;
import lombok.extern.slf4j.Slf4j;
import org.dromara.hmily.annotation.HmilyTCC;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Service
@Slf4j
public class AccountServiceImpl implements AccountService {
    @Autowired
    private SmsService smsService;
    @Autowired
    private AccountMapper accountMapper;

    @Value("${sms.enable}")
    private Boolean smsEnable;

    @Override
    public AccountDTO login(AccountLoginDTO accountLoginDTO) {
        Account account = null;
        if ("c".equalsIgnoreCase(accountLoginDTO.getDomain())) {
            //获取c端用户
            account = getAccountByMobile(accountLoginDTO.getMobile());
        } else {
            //获取b端用户
            account = getAccountByUsername(accountLoginDTO.getUsername());
        }
        if (account == null) {
            // 用户不存在
            throw new BusinessException(AccountErrorCode.E_130104);
        }
        AccountDTO accountDTO = convertAccountEntityToDTO(account);
        // 如果smsEnable=true, 说明是短信验证码登录, 不做密码校验
        if (smsEnable) {
            return accountDTO;
        }

        // 验证密码
        if (PasswordUtil.verify(accountLoginDTO.getPassword(), account.getPassword())) {
            return accountDTO;
        }

        throw new BusinessException(AccountErrorCode.E_130105);
    }

    /**
     * 根据手机获取账户信息
     *
     * @param mobile 手机号
     * @return 账户实体
     */
    private Account getAccountByMobile(String mobile) {
        return accountMapper.selectOne(new LambdaQueryWrapper<Account>().eq(Account::getMobile, mobile));
    }

    /**
     * 根据用户名获取账户信息
     *
     * @param username 用户名
     * @return 账户实体
     */
    private Account getAccountByUsername(String username) {
        return accountMapper.selectOne(new LambdaQueryWrapper<Account>().eq(Account::getUsername, username));
    }

    /**
     * 用户注册
     *
     * @param registerDTO
     * @return
     */
    @Override
    @Transactional(rollbackFor = {Exception.class})
    @HmilyTCC(confirmMethod = "confirmRegister", cancelMethod = "cancelRegister")
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

    @Transactional(rollbackFor = {Exception.class})
    public void confirmRegister(AccountRegisterDTO registerDTO) {
        log.info("confirm register");
    }

    @Transactional(rollbackFor = {Exception.class})
    public void cancelRegister(AccountRegisterDTO registerDTO) {
        // 删除账号
        accountMapper.delete(new LambdaQueryWrapper<Account>().eq(Account::getUsername, registerDTO.getUsername()));
        log.info("cancel register");
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
