## 安装Logstash

```shell script
docker pull logstash:6.4.0

docker run -id --name logstash \
--privileged=true \
-p 5044:5044 \
-p 5045:5045 \
logstash:6.4.0

# 进入容器
docker exec -it logstash /bin/bash

# 创建目录: mkdir logstash_metadata
# 移动文件: docker cp logstash:/usr/share/logstash/pipeline /root/wanxin-p2p/docker/logstash/conf

# 创建json目录, 将我们目录中的wanxinp2p_project_template.json移动进去
# mkdir json
# 使用命令: docker cp logstash:/usr/share/logstash/json /root/wanxin-p2p/docker/logstash/json

# 创建jar目录, 将我们准备好的mysql.jar移动进去
# mkdir jar
# 使用命令: docker cp logstash:/usr/share/logstash/jar /root/wanxin-p2p/docker/logstash/jar

# 创建sql目录, 将我们准备好的mysql移动进去
# mkdir sql
# 使用命令: docker cp logstash:/usr/share/logstash/sql /root/wanxin-p2p/docker/logstash/sql

# 修改jvm: vi config/jvm.options
-Xms256m
-Xmx256m

# 修改es配置信息: vi config/logstash.yml
# 将其中的内容全部注释掉
# http.host: "0.0.0.0"
# xpack.monitoring.elasticsearch.url: http://192.168.158.164:9200
```
