package com.wanxin.common.domain;

/**
 * <P>
 * 标的状态码枚举类
 * </p>
 *
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public enum ProjectCode {

    /**
     * 借款人新建发标状态为: 募集中
     */
    COLLECTING("COLLECTING", "募集中"),

    /**
     * 投资人完成投标状态为: 已满标
     */
    FULLY("FULLY", "已满标"),

    /**
     * 借款人已开始还款状态为: 还款中
     */
    REPAYING("REPAYING", "还款中"),

    /**
     * 借款人标的已被投资完成状态为: 已截标
     */
    FINISH("FINISH", "已截标"),

    /**
     * 借款人标的未投资完成状态为: 流标
     */
    MISCARRY("MISCARRY", "流标");

    private String code;
    private String desc;

    ProjectCode(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
