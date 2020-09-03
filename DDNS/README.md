# 动态dns解析

## 实现功能
使用脚本更新DNSPOD域名A记录及AAAA记录

## DNSPOD秘钥
![](http://qfbeps0qh.hb-bkt.clouddn.com/go/20200904015231.png)

## API格式
### 获取域名列表
主要作用是获取domain_id
```shell
curl -X POST https://dnsapi.cn/Domain.List -d 'login_token=LOGIN_TOKEN&format=json'
```
```json
{
    "status": {
        "code": "1",
        "message": "Action completed successful",
        "created_at": "2015-01-18 16:21:28"
    },
    "info": {
        ...
    },
    "domains": [
        {
            "id": 2238269,
            "status": "enable",
            "grade": "D_Free",
            "group_id": "1",
            "searchengine_push": "yes",
            "is_mark": "no",
            "ttl": "300",
            "created_on": "2015-01-19 08:20:03",
            "updated_on": "2015-01-19 18:54:35",
            "punycode": "xn--vnqp08b.cn",
            "ext_status": "dnserror",
            "name": "我们.cn",
            ...
        }
    ]
}
```

### 获取记录列表
主要作用是获取record_id
```shell
curl -X POST https://dnsapi.cn/Record.List -d 'login_token=LOGIN_TOKEN&format=json&domain_id=12600793&sub_domain=www&record_type=A&offset=0&length=3'
```
```json
{
    "status": {
        "code": "1",
        "message": "Action completed successful",
        "created_at": "2018-06-11 10:41:18"
    },
    "domain": {
        "id": "12600793",
        "name": "example.com",
        "punycode": "example.com",
        "grade": "DP_Free",
        "owner": "mailbox@example.com",
        "ext_status": "dnserror",
        "ttl": 600,
        "dnspod_ns": [
            "ns3.dnsv5.com",
            "ns4.dnsv5.com"
        ]
    },
    "info": {
        "sub_domains": "7",
        "record_total": "4",
        "records_num": "3"
    },
    "records": [
        {
            "id": "13608148",
            "name": "www",
            "line": "电信",
            "line_id": "10=0",
            "type": "A",
            "ttl": "600",
            "value": "1.10.0.3",
            "weight": null,
            "mx": "0",
            "enabled": "1",
            "status": "enabled",
            "monitor_status": "",
            "remark": "",
            "updated_on": "2018-06-11 10:12:51",
            "use_aqb": "no"
        },
        ...
    ]
}
```

### 更新记录
```shell
curl -X POST https://dnsapi.cn/Record.Modify -d 'login_token=LOGIN_TOKEN&format=json&domain_id=2317346&record_id=16894439&sub_domain=www&value=3.2.2.2&record_type=A&record_line_id=10%3D0'
```
```json
{
    "status": {
        "code":"1",
        "message":"Action completed successful",
        "created_at":"2015-01-18 16:53:23"
    },
    "record": {
        "id":16894439,
        "name":"@",
        "value":"3.2.2.2",
        "status":"enable"
    }
}
```
## 解析记录类型

| 类型名称     | 类型取值       | 类型定义                                                     | 类型描述                                                     |
| :--------  | :----------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| A记录       | A            | 直接解析到空间ipv4IP地址           | IPv4地址格式                                                 |
| MX记录      | MX           | 电子邮件系统发邮件时根据收信人的地址后缀来定位邮件服务器              | NameType形式，且不可为IP地址。1-10，优先级依次递减。         |
| TXT记录     | TXT          | 一般指为某个主机名或域名设置的说明 | 字符串；长度小于512,合法字符：大小写字母，数字,空格，及以下字符：-~=:;/.@+^!* |
| CNAME记录   | CNAME        | 解析到别名 | NameType形式，且不可为IP                                     |
| AAAA记录    | AAAA         | 直接解析到空间ipv6IP地址           | IPv6地址格式                                                 |
