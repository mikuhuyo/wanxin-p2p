package com.wanxin.depository.service;

import com.ctrip.framework.apollo.Config;
import com.ctrip.framework.apollo.spring.annotation.ApolloConfig;
import com.ctrip.framework.apollo.spring.annotation.EnableApolloConfig;
import org.springframework.stereotype.Service;

/**
 * 本类用于获取配置文件中的配置, 封装成service方便调用
 *
 * @author yuelimin
 * @since 1.8
 */
@Service
@EnableApolloConfig
public class ConfigService {
    @ApolloConfig
    private Config config;


    /**
     * 银行存管系统服务地址
     *
     * @return
     */
    public String getDepositoryUrl() {
        return config.getProperty("depository.url", null);
    }

    /**
     * 银行存管系统公钥
     *
     * @return
     */
    public String getDepositoryPublicKey() {
        return config.getProperty("depository.publicKey", null);
    }

    /**
     * 万信P2P系统公钥
     *
     * @return
     */
    public String getP2pPublicKey() {
        return config.getProperty("p2p.publicKey", null);
    }

    /**
     * 万信P2P系统 标识
     *
     * @return
     */
    public String getP2pCode() {
        return config.getProperty("p2p.code", null);
    }

    /**
     * 万信P2P系统私钥
     *
     * @return
     */
    public String getP2pPrivateKey() {
        return config.getProperty("p2p.privateKey", null);
    }
}
