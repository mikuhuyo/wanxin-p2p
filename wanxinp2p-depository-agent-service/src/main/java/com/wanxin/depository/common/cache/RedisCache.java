package com.wanxin.depository.common.cache;

import com.wanxin.common.cache.Cache;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * @author yuelimin
 * @since 1.8
 */
public class RedisCache implements Cache {

    private StringRedisTemplate redisTemplate;

    public RedisCache(StringRedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    public Set<String> getKeys(String pattern) {
        return redisTemplate.keys(pattern);
    }

    @Override
    public Set<String> getKeys() {
        return getKeys("*");
    }

    @Override
    public Boolean exists(String key) {
        return redisTemplate.hasKey(key);
    }

    @Override
    public void del(String key) {
        redisTemplate.delete(key);
    }

    @Override
    public void set(String key, String value) {
        redisTemplate.opsForValue().set(key, value);
    }

    @Override
    public void set(String key, String value, Integer expire) {
        redisTemplate.opsForValue().set(key, value, expire, TimeUnit.SECONDS);
    }

    @Override
    public String get(String key) {
        return redisTemplate.opsForValue().get(key);
    }

    @Override
    public void expire(String key, int expire) {
        redisTemplate.expire(key, expire, TimeUnit.SECONDS);
    }

    @Override
    public void append(String key, String value) {
        redisTemplate.opsForValue().append(key, value);
    }

    @Override
    public String getset(String key, String newValue) {
        return redisTemplate.opsForValue().getAndSet(key, newValue);
    }

    @Override
    public boolean setnx(String key, String value) {
        return redisTemplate.opsForValue().setIfAbsent(key, value);
    }

    @Override
    public Long incrBy(String key, Long delta) {
        return redisTemplate.opsForValue().increment(key, delta);
    }

}
