## 安装Logstash

```shell script
docker pull logstash:6.4.0

docker run -it --name logstash \
--privileged=true \
-p 5044:5044 \
-p 5045:5045 \
-p 9600:9600 \
-v ./conf.d/:/usr/share/logstash/conf.d \
logstash:6.4.0
```
