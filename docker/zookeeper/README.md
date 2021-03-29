## 安装Zookeeper

```shell script
docker pull zookeeper:3.6.2

docker run -id --name zookeeper \
--privileged=true \
-p 2181:2181 \
zookeeper:3.6.2
```
