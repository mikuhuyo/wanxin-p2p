package com.wanxin.consumer.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.api.account.model.AccountDTO;
import com.wanxin.api.account.model.AccountRegisterDTO;
import com.wanxin.api.consumer.model.*;
import com.wanxin.api.depository.model.DepositoryConsumerResponse;
import com.wanxin.api.depository.model.DepositoryRechargeResponse;
import com.wanxin.api.depository.model.DepositoryWithdrawResponse;
import com.wanxin.api.depository.model.GatewayRequest;
import com.wanxin.common.domain.*;
import com.wanxin.common.util.CodeNoUtil;
import com.wanxin.consumer.agent.AccountApiAgent;
import com.wanxin.consumer.agent.DepositoryAgentApiAgent;
import com.wanxin.consumer.common.ConsumerErrorCode;
import com.wanxin.consumer.entity.BankCard;
import com.wanxin.consumer.entity.Consumer;
import com.wanxin.consumer.entity.RechargeRecord;
import com.wanxin.consumer.entity.WithdrawRecord;
import com.wanxin.consumer.mapper.BankCardMapper;
import com.wanxin.consumer.mapper.ConsumerMapper;
import com.wanxin.consumer.mapper.RechargeRecordMapper;
import com.wanxin.consumer.mapper.WithdrawRecordMapper;
import com.wanxin.consumer.utils.ApolloConfigUtil;
import com.wanxin.consumer.utils.CheckBankCardUtil;
import com.wanxin.consumer.utils.IdCardUtil;
import com.wanxin.consumer.utils.OkHttpUtil;
import lombok.extern.slf4j.Slf4j;
import org.dromara.hmily.annotation.HmilyTCC;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Slf4j
@Service
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
    @Autowired
    private CheckBankCardUtil checkBankCardUtil;
    @Autowired
    private RechargeRecordMapper rechargeRecordMapper;
    @Autowired
    private WithdrawRecordMapper withdrawRecordMapper;

    @Override
    public RestResponse<GatewayRequest> createWithdrawRecord(String amount, String fallbackUrl, String mobile) {
        ConsumerDTO consumer = getByMobile(mobile);
        assert consumer != null;

        String userNo = consumer.getUserNo();
        Long id = consumer.getId();
        String requestNo = CodeNoUtil.getNo(CodePrefixCode.CODE_REQUEST_PREFIX);

        saveWithdrawRecord(id, userNo, amount, requestNo);

        WithdrawRequest withdrawRequest = new WithdrawRequest();
        withdrawRequest.setAmount(new BigDecimal(amount));
        withdrawRequest.setCardNumber(consumer.getIdNumber());
        withdrawRequest.setMobile(mobile);
        withdrawRequest.setUserNo(userNo);
        withdrawRequest.setRequestNo(requestNo);
        withdrawRequest.setCallbackURL(fallbackUrl);
        withdrawRequest.setCommission(new BigDecimal("0"));
        return depositoryAgentApiAgent.createWithdrawRecord(withdrawRequest);
    }

    private void saveWithdrawRecord(Long cid, String userNo, String amount, String requestNo)  {
        WithdrawRecord withdrawRecord = new WithdrawRecord();
        withdrawRecord.setConsumerId(cid);
        withdrawRecord.setUserNo(userNo);
        withdrawRecord.setAmount(new BigDecimal(amount));
        withdrawRecord.setCreateDate(LocalDateTime.now());
        withdrawRecord.setCallbackStatus(0);

        withdrawRecordMapper.insert(withdrawRecord);
    }

    @Override
    public Boolean modifyWithdrawRecordResult(DepositoryWithdrawResponse depositoryWithdrawResponse) {
        if (!"SUCCESS".equals(depositoryWithdrawResponse.getTransactionStatus().toLowerCase())) {
            throw new BusinessException(ConsumerErrorCode.E_140141);
        }

        String requestNo = depositoryWithdrawResponse.getRequestNo();
        WithdrawRecord withdrawRecord = new WithdrawRecord();
        withdrawRecord.setCallbackStatus(1);

        return withdrawRecordMapper.update(withdrawRecord, new LambdaQueryWrapper<WithdrawRecord>().eq(WithdrawRecord::getRequestNo, requestNo)) == 1;
    }

    @Override
    public RestResponse<GatewayRequest> createRechargeRecord(String amount, String fallback, String mobile) {
        ConsumerDTO consumer = getByMobile(mobile);
        assert consumer != null;

        String userNo = consumer.getUserNo();
        Long id = consumer.getId();
        String requestNo = CodeNoUtil.getNo(CodePrefixCode.CODE_REQUEST_PREFIX);

        saveRechargeRecord(amount, userNo, requestNo, id);

        RechargeRequest rechargeRequest = new RechargeRequest();
        rechargeRequest.setAmount(new BigDecimal(amount));
        rechargeRequest.setCallbackUrl(fallback);
        rechargeRequest.setUserNo(userNo);
        rechargeRequest.setRequestNo(requestNo);
        return depositoryAgentApiAgent.createRechargeRecord(rechargeRequest);
    }

    private void saveRechargeRecord(String amount, String userNo, String requestNo, Long id) {
        RechargeRecord rechargeRecord = new RechargeRecord();
        rechargeRecord.setAmount(new BigDecimal(amount));
        rechargeRecord.setUserNo(userNo);
        rechargeRecord.setRequestNo(requestNo);
        rechargeRecord.setCallbackStatus(0);
        rechargeRecord.setConsumerId(id);
        rechargeRecord.setCreateDate(LocalDateTime.now());

        rechargeRecordMapper.insert(rechargeRecord);
    }

    @Override
    public Boolean modifyRechargeRecordResult(DepositoryRechargeResponse depositoryRechargeResponse) {
        if (!"SUCCESS".equals(depositoryRechargeResponse.getTransactionStatus().toLowerCase())) {
            throw  new BusinessException(ConsumerErrorCode.E_140131);
        }

        String requestNo = depositoryRechargeResponse.getRequestNo();
        RechargeRecord rechargeRecord = new RechargeRecord();
        rechargeRecord.setCallbackStatus(1);
        return rechargeRecordMapper.update(rechargeRecord, new LambdaQueryWrapper<RechargeRecord>().eq(RechargeRecord::getRequestNo, requestNo)) == 1;
    }

    @Override
    public BalanceDetailsDTO getBalanceDetailsByUserNo(String userNo) throws IOException {
        String info = OkHttpUtil.doSyncGet(ApolloConfigUtil.getDepositoryUrl() + "/balance-details/" + userNo);
        Map map = JSONObject.parseObject(info, Map.class);
        BalanceDetailsDTO balanceDetailsDTO = new BalanceDetailsDTO();
        balanceDetailsDTO.setUserNo(map.get("userNo").toString());
        balanceDetailsDTO.setAppCode(map.get("appCode").toString());
        balanceDetailsDTO.setBalance((BigDecimal) map.get("balance"));
        balanceDetailsDTO.setFreezeAmount((BigDecimal) map.get("freezeAmount"));
        balanceDetailsDTO.setChangeType((Integer) map.get("changeType"));
        return balanceDetailsDTO;
    }

    @Override
    public ConsumerDTO getConsumerByMobile(String mobile) {
        return getByMobile(mobile);
    }

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
    public RestResponse<GatewayRequest> createConsumer(ConsumerRequest consumerRequest) throws IOException {
        ConsumerDTO consumerDTO = getByMobile(consumerRequest.getMobile());

        // 判断用户是否已开户
        assert consumerDTO != null;
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
        // 设置默认可贷额度
        consumer.setLoanAmount(new BigDecimal("2000"));
        if (!IdCardUtil.isValidatedAllIdcard(consumerRequest.getIdNumber())) {
            throw new BusinessException(ConsumerErrorCode.E_140110);
        }
        consumer.setIdNumber(consumerRequest.getIdNumber());
        consumer.setAuthList("ALL");
        consumerMapper.update(consumer, new LambdaQueryWrapper<Consumer>().eq(Consumer::getMobile, consumerDTO.getMobile()));

        // 保存用户绑卡信息
        BankCard bankCard = new BankCard();
        bankCard.setConsumerId(consumerDTO.getId());
        String[] split = checkBankCardUtil.checkBankCard(consumerRequest.getCardNumber()).split("-");
        bankCard.setBankCode(split[0]);
        bankCard.setBankName(split[1]);
        bankCard.setCardNumber(consumerRequest.getCardNumber());
        bankCard.setMobile(consumerRequest.getMobile());
        bankCard.setStatus(StatusCode.STATUS_OUT.getCode());

        BankCardDTO existBankCard = bankCardService.getByConsumerId(bankCard.getConsumerId());
        if (existBankCard != null) {
            bankCard.setId(existBankCard.getId());
            bankCardMapper.updateById(bankCard);
        } else {
            bankCardMapper.insert(bankCard);
        }
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
