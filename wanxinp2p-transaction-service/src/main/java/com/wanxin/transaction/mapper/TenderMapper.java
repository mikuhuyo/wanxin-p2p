package com.wanxin.transaction.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wanxin.transaction.entity.Tender;
import org.springframework.stereotype.Repository;

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
