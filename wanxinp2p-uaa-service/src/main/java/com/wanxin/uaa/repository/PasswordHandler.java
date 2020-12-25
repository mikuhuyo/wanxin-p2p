package com.wanxin.uaa.repository;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public abstract class PasswordHandler {
    private PasswordHandler() {
    }

    public static String encode(String password) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        return encoder.encode(password);
    }
}
