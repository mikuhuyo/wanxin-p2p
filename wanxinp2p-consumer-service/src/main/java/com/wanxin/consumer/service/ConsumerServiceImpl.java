package com.wanxin.consumer.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.api.account.model.AccountDTO;
import com.wanxin.api.account.model.AccountRegisterDTO;
import com.wanxin.api.consumer.model.ConsumerDTO;
import com.wanxin.api.consumer.model.ConsumerRegisterDTO;
import com.wanxin.common.domain.BusinessException;
import com.wanxin.common.domain.CodePrefixCode;
import com.wanxin.common.domain.CommonErrorCode;
import com.wanxin.common.domain.RestResponse;
import com.wanxin.common.util.CodeNoUtil;
import com.wanxin.consumer.agent.AccountApiAgent;
import com.wanxin.consumer.common.ConsumerErrorCode;
import com.wanxin.consumer.entity.Consumer;
import com.wanxin.consumer.mapper.ConsumerMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Service
public class ConsumerServiceImpl implements ConsumerService {
    @Autowired
    private ConsumerMapper consumerMapper;
    @Autowired
    private AccountApiAgent accountApiAgent;

    @Override
    public Integer checkMobile(String mobile) {
        return getByMobile(mobile) != null ? 1 : 0;
    }

    @Override
    public void register(ConsumerRegisterDTO consumerRegisterDTO) {
        if (checkMobile(consumerRegisterDTO.getMobile()) == 1) {
            throw new BusinessException(ConsumerErrorCode.E_140107);
        }

        Consumer consumer = new Consumer();
        BeanUtils.copyProperties(consumerRegisterDTO, consumer);
        consumer.setUsername(CodeNoUtil.getNo(CodePrefixCode.CODE_NO_PREFIX));
        consumer.setUserNo(CodeNoUtil.getNo(CodePrefixCode.CODE_REQUEST_PREFIX));
        consumer.setIsBindCard(0);
        // 添加用户
        consumerMapper.insert(consumer);

        AccountRegisterDTO accountRegisterDTO = new AccountRegisterDTO();
        BeanUtils.copyProperties(consumerRegisterDTO, accountRegisterDTO);
        RestResponse<AccountDTO> restResponse = accountApiAgent.register(accountRegisterDTO);
        if (restResponse.getCode() != CommonErrorCode.SUCCESS.getCode()) {
            throw new BusinessException(ConsumerErrorCode.E_140106);
        }
    }

    private ConsumerDTO getByMobile(String mobile) {
        Consumer consumer = consumerMapper.selectOne(new LambdaQueryWrapper<Consumer>().eq(Consumer::getMobile, mobile));
        if (consumer != null) {
            return convertConsumerEntityToDTO(consumer);
        }

        return null;
    }

    private ConsumerDTO convertConsumerEntityToDTO(Consumer consumer) {
        if (consumer == null) {
            return null;
        }

        ConsumerDTO dto = new ConsumerDTO();
        BeanUtils.copyProperties(consumer, dto);
        return dto;
    }
}
