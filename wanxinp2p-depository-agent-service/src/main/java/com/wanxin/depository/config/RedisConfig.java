package com.wanxin.depository.config;

import com.wanxin.common.cache.Cache;
import com.wanxin.depository.common.cache.RedisCache;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;

/**
 * @author yuelimin
 * @since 1.8
 */
@Configuration
public class RedisConfig {
    @Bean
    public Cache cache(StringRedisTemplate redisTemplate) {
        return new RedisCache(redisTemplate);
    }
}
