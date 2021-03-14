## 安装RocketMQ

```shell script
# rocketmq
docker pull rocketmqinc/rocketmq:4.4.0

docker run -d -p 9876:9876 \
-v /root/docker/rocketmq/namesrv/logs:/root/logs \
-v /root/docker/rocketmq/namesrv/store:/root/store \
--name rmqnamesrv \
-e "MAX_POSSIBLE_HEAP=100000000" rocketmqinc/rocketmq:4.4.0 sh mqnamesrv

docker run -d -p 10911:10911 -p 10909:10909 \
--privileged=true \
-v /root/docker/rocketmq/broker/logs:/root/logs \
-v /root/docker/rocketmq/broker/store:/root/store \
-v /root/docker/rocketmq/conf/broker.conf:/opt/rocketmq-4.4.0/conf/broker.conf \
--name rmqbroker \
--link rmqnamesrv:namesrv \
-e "NAMESRV_ADDR=namesrv:9876" \
-e "MAX_POSSIBLE_HEAP=200000000" \
rocketmqinc/rocketmq:4.4.0 sh mqbroker -c /opt/rocketmq-4.4.0/conf/broker.conf
```

## 监控

```shell script
# 监控
docker pull styletang/rocketmq-console-ng

docker run -d --name rmqconsole \
-p 8080:8080 \
-e "JAVA_OPTS=-Drocketmq.namesrv.addr=192.168.158.164:9876 -Dcom.rocketmq.sendMessageWithVIPChannel=false" \
styletang/rocketmq-console-ng

systemctl stop firewalld.service
```
