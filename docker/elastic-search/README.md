## ELK环境搭建(version 7.5.2)

### ElasticSearch环境

```shell script
# 拉取容器
docker pull elasticsearch:7.5.2
docker pull kibana:7.5.2
docker pull logstash:7.5.2

docker run -id --name es \
-e "discovery.type=single-node" \
-e "cluster.name=elasticsearch" \
--privileged=true \
-p 9200:9200 \
-p 9300:9300 elasticsearch:7.5.2

docker exec -it es /bin/bash

# 安装插件
elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.5.2/elasticsearch-analysis-ik-7.5.2.zip
```

修改配置文件: `elasticsearch.yml`

```yaml
cluster.name: wanxinp2p
node.name: wanxinp2p_node
network.host: 0.0.0.0
http.port: 9200
transport.tcp.port: 9300
discovery.zen.minimum_master_nodes: 1
bootstrap.memory_lock: true
discovery.type: single-node
http.cors.enabled: true
http.cors.allow-origin: "*"
```

重启: `docker restart es`

### Kibana环境

```shell script
docker run -id \
--name kibana \
--link es:elasticsearch \
-p 5601:5601 kibana:7.5.2
```

执行(自动添加索引, 你看着办):

```shell script
PUT _cluster/settings
{
  "persistent": {
    "action.auto_create_index": "true" 
  }
}

```

执行:

```shell script
PUT wanxinp2p_project

POST wanxinp2p_project/_mapping
{
  "properties":{
    "isassignment":{
      "type":"keyword"
    },
    "amount":{
      "type":"double"
    },
    "period":{
      "type":"integer"
    },
    "repaymentway":{
      "type":"keyword"
    },
    "consumerid":{
      "type":"long"
    },
    "userno":{
      "type":"keyword"
    },
    "description":{
      "analyzer":"ik_max_word",
      "type":"text"
    },
    "annualrate":{
      "type":"double"
    },
    "type":{
      "type":"keyword"
    },
    "borrowerannualrate":{
      "type":"double"
    },
    "projectstatus":{
      "type":"keyword"
    },
    "projectno":{
      "type":"keyword"
    },
    "commissionannualrate":{
      "type":"keyword"
    }, 
    "name":{
      "analyzer":"ik_max_word",
      "type":"text"
    },
    "id":{
      "type":"long"
    },
    "createdate":{
      "type":"date"
    },
    "modifydate":{
      "type":"date"
    },
    "status":{
      "type":"keyword"
    }
  }
}
```

### Logstash环境

这里我推荐使用安装包形式进行配置, 我docker配置了一个多月出现了各种诡异的bug, 最终放弃使用安装包一下好了.

配置文件: `logstash.yml`

```yaml
# 0.0.0.0：允许任何IP访问
http.host: "0.0.0.0"
# 配置elasticsearch集群地址
xpack.monitoring.elasticsearch.hosts: ["http://192.168.158.164:9200"]
# 允许监控
xpack.monitoring.enabled: true
# 启动时读取配置文件指定
# 指定的该文件可以配置Logstash读取一些文件导入ES, 将插件安装完成之后将这一行注释取消.
# path.config: /usr/share/logstash/conf.d/*.conf
path.logs: /var/log/logstash
```

```shell script
docker run -id --name logstash \
--privileged=true \
-p 5044:5044 \
-p 9600:9600 \
-v /root/docker/logstash/config/logstash.yml:/usr/share/logstash/config/logstash.yml \
-v /root/docker/logstash/conf.d:/usr/share/logstash/conf.d \
logstash:7.5.2

docker exec -it logstash /bin/bash

```

配置文件:

```shell script
input {
  jdbc {
    jdbc_connection_string => "jdbc:mysql://192.168.158.164:3306/p2p_transaction_0?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC"
    jdbc_user => "root"
    jdbc_password => "yueliminvc@outlook.com"
    jdbc_driver_library => "./mysql.jar"
    jdbc_driver_class => "com.mysql.cj.jdbc.Driver"
    jdbc_paging_enabled => true
    jdbc_page_size => "50000"
    # 时区设置
    jdbc_default_timezone =>"Asia/Shanghai"
    # 要执行的sql
    statement_filepath => "/usr/share/logstash/conf.d/wanxinp2p_project.sql"
    # 每隔10秒执行一次
    schedule => "*/10 * * * * *"
    # 是否记录最后一次的运行时间
    record_last_run => true
    # 记录最后一次运行时间的位置
    last_run_metadata_path => "./logstash_metadata"
  }

  jdbc {
    jdbc_connection_string => "jdbc:mysql://192.168.158.164:3306/p2p_transaction_1?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC"
    jdbc_user => "root"
    jdbc_password => "yueliminvc@outlook.com"
    jdbc_driver_library => "./mysql.jar"
    jdbc_driver_class => "com.mysql.cj.jdbc.Driver"
    jdbc_paging_enabled => true
    jdbc_page_size => "50000"
    jdbc_default_timezone =>"Asia/Shanghai"

    statement_filepath => "/usr/share/logstash/conf.d/wanxinp2p_project.sql"
    schedule => "*/10 * * * * *"
    record_last_run => true
    last_run_metadata_path => "./logstash_metadata"
  }
}

output {
  elasticsearch {
    # ES服务器地址
    hosts => "192.168.158.164:9200"
    # ES索引库名字
    index => "wanxinp2p_project"
    # 取表中主键值作为文档ID
    document_id => "%{id}"
    # 模板文件地址
    template => "./wanxinp2p_project_template.json"
    # 模板文件名字
    template_name => "wanxinp2p_project"
    # 覆盖默认模板
    template_overwrite => true
  }

  # 日志输出
  stdout {
      codec => json_lines
  }
}

```
