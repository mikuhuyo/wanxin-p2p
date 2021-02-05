# 万信金融(wanxin-p2p)

[![GitHub license](https://img.shields.io/github/license/mikuhuyo/wanxin-p2p)](https://github.com/mikuhuyo/wanxin-p2p/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/mikuhuyo/wanxin-p2p)](https://github.com/mikuhuyo/wanxin-p2p/issues)
[![GitHub stars](https://img.shields.io/github/stars/mikuhuyo/wanxin-p2p)](https://github.com/mikuhuyo/wanxin-p2p/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/mikuhuyo/wanxin-p2p)](https://github.com/mikuhuyo/wanxin-p2p/network)
![Java version](https://img.shields.io/badge/Jdk-1.8-yellow)
![SpringBoot version](https://img.shields.io/badge/SpringBoot-2.1.13-brightgreen)
![SpringCloud version](https://img.shields.io/badge/SpringCloud-Greenwich.SR6-ff69b4)

---

## 功能预览(部分)

### 用户登录/注册

![](./resource/image/open-an-account-01.png)

### 开通存管

![](./resource/image/open-an-account-02.png)

![](./resource/image/open-an-account-03.png)

![](./resource/image/open-an-account-04.png)

![](./resource/image/open-an-account-05.png)

![](./resource/image/open-an-account-06.png)

![](./resource/image/open-an-account-07.png)

## 对于本仓库

### 关注者

[![Stargazers repo roster for @mikuhuyo/wanxin-p2p](https://reporoster.com/stars/mikuhuyo/wanxin-p2p)](https://github.com/mikuhuyo/wanxin-p2p/stargazers)

### 收藏者

[![Forkers repo roster for @mikuhuyo/wanxin-p2p](https://reporoster.com/forks/mikuhuyo/wanxin-p2p)](https://github.com/mikuhuyo/wanxin-p2p/network/members)

## 项目介绍

### 背景

目前, 国家对P2P行业的监控与规范性控制越来越严格, 出台了很多政策来对其专项整治, P2P平台之 前所采用的"资金池模式"与"第三方支付托管"(见下文定义)已经不合规了, 国家主张采用"银行存管模式"来规避P2P平台挪用借投人资金的风险, 通过银行开发的"银行存管系统"管理投资者的资金, 每位P2P平台用户在银行的存管系统内都会有一个独立账号, P2P平台来管理交易, 做到资金和交易分开, 让P2P平台不能接触到资金, 就可以一定程度避免资金被挪用的风险.

> 什么是资金池模式?

此模式下, 投资人利用第三方支付/银行的通道先把资金打到平台的银行账户, P2P的平台就池子一样, 汇聚了投资人和借款人的资金, 这个汇集资金的池子叫做资金池, 是P2P平台方最容易跑路的模式.

> 什么是第三方支付托管模式?

此模式下, 投资人/借款人除了要在P2P平台注册外, 还要在第三方支付平台注册, 也就是平台和第三方各有一套账户体系. 经过第三方支付的资金托管后, 由于资金沉淀发生在第三方支付在银行的备付金账户上, P2P平台运营方只能看到投资人/借款人账户余额的变化及债权匹配关系, 不能像资金池那样擅自挪用投资人的钱, 但是这里存在安全风险的是第三方支付机构.

> 什么是银行存管模式?

此种模式下, 涉及到2套账户体系, P2P平台和银行各一套账户体系. 投资人在P2P平台注册后, 会同时跳转到银行再开一个电子账户, 2个账户间有一一对应的关系. 当投资人投资时, 资金进入的是平台在银行为投资人开设的二级账户中, 每一笔交易, 是由银行在投资人与借款人间的交易划转, P2P平台仅 能看到信息的流动.

### 基本介绍

万信金融是一个P2P(person-to-person)金融平台, 采用银行存管模式, 为用户提供方便, 快捷, 安心的P2P金融服务.
项目包括交易平台和业务支撑两个部分, 交易平台主要实现理财服务, 包括: 借钱, 出借等模块;

业务支撑包括: 标的管理, 对账管理, 风控管理等模块, 项目采用先进的互联网分布式系统架构进行研发, 保证了P2P双方交易的安全性, 快捷性及稳定性.

### 使用技术

- SpringBoot
- SpringCloud
- Apollo
- RocketMQ
- Druid
- MybatisPlus
- OAuth2
- Jwt
- ShardingSphere
- Redis
- ElasticSearch
- ...

### 开发工具

- macOS High Sierra(MacBookPro 2015 pro) 使用机器以及操作系统
- JDK 1.8
- Maven 3.6+ 项目构建
- IDEA 2020.1 集成开发环境
- Navicat Premium 数据库工具
- Postman 接口测试
- VMware Fusion 虚拟机软件
- Nginx 反向代理/负载均衡
- HBuilderX 前端开发
- ...

### 前后端工程地址

| Github地址                                         | 说明             |
| -------------------------------------------------- | ---------------- |
| https://github.com/mikuhuyo/wanxin-p2p-web.git     | 前端工程         |
| https://github.com/mikuhuyo/wanxin-p2p.git         | 后端工程         |
| https://github.com/mikuhuyo/wanxin-p2p-manager.git | 后台前端工程     |
| https://github.com/mikuhuyo/wanxin-depository.git  | 后台银行存管系统 |
| https://github.com/mikuhuyo/tencent-sms.git        | Tencent短信服务  |
| https://github.com/mikuhuyo/minio.git              | 存储服务         |

## 架构图与解决方案

### 功能架构图

![](./resource/image/init-01.png)

### 技术架构图

![](./resource/image/init-02.png)

### 技术解决方案

- 接口规范
  - SpringBoot+Swagger
- 持久层编码
  - MyBatis Plus
- 分布式系统配置中心
  - Apollo
- UAA认证方案
  - Spring Security Oauth2+JWT+ZUUL
- 分布式事务解决方案
  - RocketMQ
  - Hmily
  - requestNo同步机制
- 分库分表解决方案
  - Sharding-jdbc
- 分布式任务调度方案
  - Elastic-job
- 安全交易方案
  - HTTPS+SHA1withRSA
- 身份认证方案
  - 百度AI
- 短信验证系统方案
  - 短信验证服务+第三方短信平台(腾讯)

## 工程说明

### 端口说明

| 工程                                             | 端口号 |
| ------------------------------------------------ | ------ |
| 注册与发现(wanxinp2p-discover-server)            | 53000  |
| 网关(wanxinp2p-gateway-server)                   | 53010  |
| uaa认证(wanxinp2p-uaa-service)                   | 53020  |
| 统一账号服务(wanxinp2p-account-service)          | 53030  |
| 用户中心服务(wanxinp2p-consumer-service)         | 53050  |
| 交易中心服务(wanxinp2p-transaction-service)      | 53060  |
| 存管代理服务(wanxinp2p-depository-agent-service) | 53070  |
| 还款服务(wanxinp2p-repayment-service)            | 53080  |
| 文件服务(wanxinp2p-file-service)                 | 56082  |
| P2P平台前端(wanxin-p2p-web)                      | 8081   |
| P2P平台管理端后台(wanxin-p2p-manager)            | 8079   |
| 短信验证码服务                                   | 56085  |
| 银行存管系统                                     | 55010  |

### 数据库说明

> Apollo配置中心数据库此处不做说明.

| 数据库名称             | 数据内容                  |
| ---------------------- | ------------------------- |
| `p2p_uaa`              | 统一认证数据              |
| `p2p_account`          | 统一账户数据              |
| `p2p_consumer`         | 用户中心数据              |
| `p2p_transaction_0`    | 交易中心数据库1           |
| `p2p_transaction_1`    | 交易中心数据库2           |
| `p2p_repayment`        | 还款中心数据              |
| `p2p_file`             | 文件存储服务              |
| `p2p_bank_depository`  | 银行存管系统              |
| `p2p_depository_agent` | 银行存管代理服务数据      |
| `p2p_reconciliation`   | 对账数据                  |
| `hmily`                | 分布式事务框架Hmily数据库 |

## 觉得项目不错就给打赏一杯咖啡吧.

![](./resource/image/alipays.png)![](./resource/image/wechats.png)

## 环境搭建

请看Wiki: https://github.com/mikuhuyo/wanxin-p2p/wiki
