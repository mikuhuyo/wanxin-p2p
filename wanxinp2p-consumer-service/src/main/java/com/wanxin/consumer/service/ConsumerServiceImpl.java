package com.wanxin.consumer.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.api.account.model.AccountDTO;
import com.wanxin.api.account.model.AccountRegisterDTO;
import com.wanxin.api.consumer.model.BankCardDTO;
import com.wanxin.api.consumer.model.ConsumerDTO;
import com.wanxin.api.consumer.model.ConsumerRegisterDTO;
import com.wanxin.api.consumer.model.ConsumerRequest;
import com.wanxin.api.depository.model.DepositoryConsumerResponse;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.*;
import com.wanxin.common.util.CodeNoUtil;
import com.wanxin.consumer.agent.AccountApiAgent;
import com.wanxin.consumer.agent.DepositoryAgentApiAgent;
import com.wanxin.consumer.common.ConsumerErrorCode;
import com.wanxin.consumer.entity.BankCard;
import com.wanxin.consumer.entity.Consumer;
import com.wanxin.consumer.mapper.BankCardMapper;
import com.wanxin.consumer.mapper.ConsumerMapper;
import lombok.extern.slf4j.Slf4j;
import org.dromara.hmily.annotation.HmilyTCC;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Service
@Slf4j
public class ConsumerServiceImpl implements ConsumerService {
    @Autowired
    private ConsumerMapper consumerMapper;
    @Autowired
    private AccountApiAgent accountApiAgent;
    @Autowired
    private BankCardService bankCardService;
    @Autowired
    private BankCardMapper bankCardMapper;
    @Autowired
    private DepositoryAgentApiAgent depositoryAgentApiAgent;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean modifyResult(DepositoryConsumerResponse response) {
        // 获取状态
        int status = DepositoryReturnCode.RETURN_CODE_00000.getCode().equals(response.getRespCode()) ? StatusCode.STATUS_IN.getCode() : StatusCode.STATUS_FAIL.getCode();
        // 更新开户结果
        Consumer consumer = getByRequestNo(response.getRequestNo());

        Consumer update = new Consumer();
        update.setId(consumer.getId());
        update.setIsBindCard(status);
        update.setStatus(status);
        consumerMapper.updateById(update);

        BankCard bankCard = new BankCard();
        bankCard.setStatus(status);
        bankCard.setBankCode(response.getBankCode());
        bankCard.setBankName(response.getBankName());
        // 更新银行卡信息
        return bankCardMapper.update(bankCard, new LambdaQueryWrapper<BankCard>().eq(BankCard::getConsumerId, consumer.getId())) == 1;
    }

    private Consumer getByRequestNo(String requestNo) {
        return consumerMapper.selectOne(new LambdaQueryWrapper<Consumer>().eq(Consumer::getRequestNo, requestNo));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public RestResponse<GatewayRequest> createConsumer(ConsumerRequest consumerRequest) {
        ConsumerDTO consumerDTO = getByMobile(consumerRequest.getMobile());

        // 判断用户是否已开户
        if (consumerDTO.getIsBindCard() == 1) {
            throw new BusinessException(ConsumerErrorCode.E_140105);
        }

        // 判断银行卡是否已被绑定
        BankCardDTO bankCardDTO = bankCardService.getByCardNumber(consumerRequest.getCardNumber());
        if (bankCardDTO != null && bankCardDTO.getStatus() == StatusCode.STATUS_IN.getCode()) {
            throw new BusinessException(ConsumerErrorCode.E_140151);
        }

        // 更新用户开户信息
        consumerRequest.setId(consumerDTO.getId());
        // 产生请求流水号和用户编号
        consumerRequest.setUserNo(CodeNoUtil.getNo(CodePrefixCode.CODE_CONSUMER_PREFIX));
        consumerRequest.setRequestNo(CodeNoUtil.getNo(CodePrefixCode.CODE_REQUEST_PREFIX));

        // 设置查询条件和需要更新的数据
        Consumer consumer = new Consumer();
        consumer.setMobile(consumerDTO.getMobile());
        consumer.setUserNo(consumerRequest.getUserNo());
        consumer.setRequestNo(consumerRequest.getRequestNo());
        consumer.setFullname(consumerRequest.getFullname());
        consumer.setIdNumber(consumerRequest.getIdNumber());
        consumer.setAuthList("ALL");
        consumerMapper.update(consumer, new LambdaQueryWrapper<Consumer>().eq(Consumer::getMobile, consumerDTO.getMobile()));

        // 保存用户绑卡信息
        BankCard bankCard = new BankCard();
        bankCard.setConsumerId(consumerDTO.getId());
        bankCard.setBankCode(consumerRequest.getBankCode());
        bankCard.setCardNumber(consumerRequest.getCardNumber());
        bankCard.setMobile(consumerRequest.getMobile());
        bankCard.setStatus(StatusCode.STATUS_OUT.getCode());

        BankCardDTO existBankCard = bankCardService.getByConsumerId(bankCard.getConsumerId());
        if (existBankCard != null) {
            bankCard.setId(existBankCard.getId());
            bankCardMapper.updateById(bankCard);
        }
        bankCardMapper.insert(bankCard);
        return depositoryAgentApiAgent.createConsumer(consumerRequest);
    }

    @Override
    public Integer checkMobile(String mobile) {
        return getByMobile(mobile) != null ? 1 : 0;
    }

    @Override
    @HmilyTCC(confirmMethod = "confirmRegister", cancelMethod = "cancelRegister")
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

    @Transactional(rollbackFor = {Exception.class})
    public void confirmRegister(ConsumerRegisterDTO consumerRegisterDTO) {
        log.info("confirm register");
    }

    @Transactional(rollbackFor = {Exception.class})
    public void cancelRegister(ConsumerRegisterDTO consumerRegisterDTO) {
        // 删除用户信息
        consumerMapper.delete(new LambdaQueryWrapper<Consumer>().eq(Consumer::getMobile, consumerRegisterDTO.getMobile()));
        log.info("cancel register");
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
