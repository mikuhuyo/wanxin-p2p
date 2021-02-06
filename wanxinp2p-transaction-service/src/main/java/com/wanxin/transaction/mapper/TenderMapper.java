package com.wanxin.transaction.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wanxin.transaction.entity.Tender;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

/**
 * <p>
 * 用于操作投标信息的mapper接口
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
@Repository
public interface TenderMapper extends BaseMapper<Tender> {
}
