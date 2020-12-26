package com.wanxin.uaa.domain;

import com.wanxin.api.account.model.AccountDTO;
import com.wanxin.api.account.model.AccountLoginDTO;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.common.util.StringUtil;
import com.wanxin.uaa.agent.AccountApiAgent;
import com.wanxin.uaa.common.utils.ApplicationContextHelper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.AuthorityUtils;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
public class IntegrationUserDetailsAuthenticationHandler {

    /**
     * 认证处理
     *
     * @param domain             用户域, 如b端用户, c端用户等
     * @param authenticationType 认证类型, 如密码认证, 短信认证等
     * @param token
     * @return
     */
    public UnifiedUserDetails authentication(String domain, String authenticationType, UsernamePasswordAuthenticationToken token) {

        // 从客户端取数据
        String username = token.getName();
        if (StringUtil.isBlank(username)) {
            throw new BadCredentialsException("账户为空");
        }
        if (token.getCredentials() == null) {
            throw new BadCredentialsException("密码为空");
        }
        String presentedPassword = token.getCredentials().toString();

        // 远程调用统一账户服务, 进行账户密码校验
        AccountLoginDTO accountLoginDTO = new AccountLoginDTO();
        accountLoginDTO.setDomain(domain);
        accountLoginDTO.setUsername(username);
        accountLoginDTO.setMobile(username);
        accountLoginDTO.setPassword(presentedPassword);
        AccountApiAgent accountApiAgent = (AccountApiAgent) ApplicationContextHelper.getBean(AccountApiAgent.class);
        assert accountApiAgent != null;
        RestResponse<AccountDTO> restResponse = accountApiAgent.login(accountLoginDTO);

        // 异常处理
        if (restResponse.getCode() != 0) {
            throw new BadCredentialsException("登录失败");
        }

        // 登录成功, 把用户数据封装到UnifiedUserDetails对象中
        UnifiedUserDetails unifiedUserDetails = new UnifiedUserDetails(restResponse.getResult().getUsername(), presentedPassword, AuthorityUtils.createAuthorityList());
        unifiedUserDetails.setMobile(restResponse.getResult().getMobile());
        return unifiedUserDetails;
    }
}
