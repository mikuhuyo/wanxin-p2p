# wanxin(万信金融)-p2p

## 项目介绍

万信金融是一个P2P(person-to-person)金融平台, 采用银行存管模式, 为用户提供方便, 快捷, 安心的P2P金融服务.
项目包括交易平台和业务支撑两个部分, 交易平台主要实现理财服务, 包括: 借钱, 出借等模块;

业务支撑包括: 标的管理, 对账管理, 风控管理等模块, 项目采用先进的互联网分布式系统架构进行研发, 保证了P2P双方交易的安全性, 快捷性及稳定性.

## 项目地址

| Github地址                                             | 说明            |
| ------------------------------------------------------ | --------------- |
| https://github.com/YueLiMin-say                        | 个人页面        |
| https://github.com/YueLiMin-say/wanxin-p2p-web.git     | 前端工程        |
| https://github.com/YueLiMin-say/wanxin-p2p.git         | 后端工程        |
| https://github.com/YueLiMin-say/wanxin-p2p-manager.git | 后台前端工程    |
| https://github.com/YueLiMin-say/TencentSms.git         | Tencent短信服务 |
| https://github.com/YueLiMin-say/minio.git              | 存储服务        |

## 资源文件说明

在项目目录下有一个`resource`的目录, 目录中有我们的`SQL`文件, 静态页面以及我们`Apollo`配置中心的`docker-compose`文件.

## 模块端口

| 工程                                             | 端口号 |
| ------------------------------------------------ | ------ |
| 注册与发现(wanxinp2p-discover-server)            | 53000  |
| 网关wanxinp2p-gateway-server)                    | 53010  |
| uaa(wanxinp2p-uaa-service)                       | 53020  |
| 统一账号服务(wanxinp2p-account-service)          | 53030  |
| 用户中心服务(wanxinp2p-consumer-service)         | 53050  |
| 交易中心服务(wanxinp2p-transaction-service)      | 53060  |
| 存管代理服务(wanxinp2p-depository-agent-service) | 53070  |
| 还款服务(wanxinp2p-repayment-service)            | 53080  |
| 文件服务(wanxinp2p-file-service)                 | 56082  |
| 短信验证码服务                                   | 56085  |
| P2P平台前端(wanxin-p2p-web)                      | 8081   |
| P2P平台管理端后台                                | 8079   |

## 技术架构

### 功能架构图

![](./resource/image/init-01.png)

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

### 技术架构图

![](./resource/image/init-02.png)

### 技术栈

> 基础设施

业务数据持久化采用MySQL, 数据缓存采用Redis, 采用RocketMQ的事务消息机制完成部分场景下的分布式事务控制, 采用Elasticsearch完成标的信息搜索, 与自研的分布式文件系统进行接口完成文件上 传与分布式存储.

> 组件

系统微服务基于SpringBoot+SpringCloud开发, 数据库连接池采用Druid, POJO构建采用Lombok, 日志系统采用Log4j2, Guava工具类库, Mybatis Plus持久层接口实现, Sharding-jdbc分库分表组件, Swagger接口规范组件, Elastic-job分布式任务调度组件, sentinel限流组件.

> 接入

Zuul网关完成客户端认证, 路由转发等功能, Ribbon完成客户端负载均衡, Feign完成微服务远程调用, Hystrix完成熔断降级处理, JWT提供前后端令牌管理方案. 

> 视图

平台支持H5, App等各种前端.

就是SpringBoot进行构构建, 采取SpringCloud微服务框架进行开发.

### 开发环境说明

| 环境           | 说明                     |
| -------------- | ------------------------ |
| CentOS7        | 虚拟机                   |
| MacBookPro2015 | 开发机器 16GB-15寸-256GB |
| JDK            | 1.8                      |
| Maven          | 3.6                      |
| IDEA           | 2020.1                   |
