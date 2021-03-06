## 安装ElasticSearch

```shell script
docker pull elasticsearch:6.4.0

docker run -id --name es \
--privileged=true \
-p 9200:9200 \
-p 9300:9300 elasticsearch:6.4.0

# 登录容器修改远程连接: docker exec -it es /bin/bash
# 编辑文件: vi ./config/elasticsearch.yml
cluster.name: wanxin
node.name: wanxin_node
network.host: 0.0.0.0
discovery.zen.minimum_master_nodes: 1
bootstrap.memory_lock: true
discovery.type: single-node
http.cors.enabled: true
http.cors.allow-origin: "*"
xpack.security.enabled: false
xpack.watcher.enabled: false
xpack.monitoring.enabled: false

# 登录`elasticsearch`容器, 进入目录修改文件: cd /config
# 编辑文件: vi config/jvm.options
# 处理内存, 如果自己的机器内存不够就使用512m或者256m
-Xms512m
-Xmx512m

# 安装插件ik分词器
elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v6.4.0/elasticsearch-analysis-ik-6.4.0.zip

# 重启容器
docker restart es
```

## 安装Kibana

```shell script
docker pull kibana:6.4.0

docker run -it -d \
--name kibana \
-e ELASTICSEARCH_URL=http://192.168.158.164:9200 \
--link es \
-p 5601:5601 kibana:6.4.0
```
