## 安装Zookeeper

```shell script
docker pull zookeeper:3.4.13

docker run -id --name zookeeper \
--privileged=true \
-p 2181:2181 \
-p 2888:2888 \
-p 3888:3888 \
-p 20880:20880 \
zookeeper:3.4.13
```
