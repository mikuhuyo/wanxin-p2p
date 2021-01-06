package com.wanxin.depository.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wanxin.depository.entity.DepositoryRecord;
import org.springframework.stereotype.Repository;

/**
 * 存管交易记录表 Mapper 接口
 *
 * @author yuelimin
 * @since 1.8
 */
@Repository
public interface DepositoryRecordMapper extends BaseMapper<DepositoryRecord> {
}
