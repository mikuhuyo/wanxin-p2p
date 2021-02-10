package com.wanxin.consumer.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.wanxin.api.consumer.model.BankCardDTO;
import com.wanxin.consumer.entity.BankCard;
import com.wanxin.consumer.mapper.BankCardMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Service
public class BankCardServiceImpl implements BankCardService {
    @Autowired
    private BankCardMapper bankCardMapper;
    @Autowired
    private ConsumerService consumerService;

    @Override
    public BankCardDTO getByUserMobile(String mobile) {
        BankCard bankCard = bankCardMapper.selectOne(new LambdaQueryWrapper<BankCard>().eq(BankCard::getMobile, mobile));
        String name = consumerService.getConsumerByMobile(mobile).getFullname();
        BankCardDTO bankCardDTO = convertBankCardEntityToDTO(bankCard);
        bankCardDTO.setFullName(name);
        return bankCardDTO;
    }

    @Override
    public BankCardDTO getByConsumerId(Long consumerId) {
        LambdaQueryWrapper<BankCard> eq = new LambdaQueryWrapper<BankCard>().eq(BankCard::getConsumerId, consumerId);
        return convertBankCardEntityToDTO(bankCardMapper.selectOne(eq));
    }

    @Override
    public BankCardDTO getByCardNumber(String cardNumber) {
        LambdaQueryWrapper<BankCard> eq = new LambdaQueryWrapper<BankCard>().eq(BankCard::getCardNumber, cardNumber);
        return convertBankCardEntityToDTO(bankCardMapper.selectOne(eq));
    }

    /**
     * entity 2 dto
     *
     * @param entity
     * @return
     */
    private BankCardDTO convertBankCardEntityToDTO(BankCard entity) {
        if (entity == null) {
            return null;
        }

        BankCardDTO dto = new BankCardDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }
}
