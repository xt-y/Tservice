# 动态dns解析

## 实现功能
通过简单的配置，实现动态dns解析。支持多种

## 设计思路
1. 获取外网ip
2. 判断外网ip是否与之前一致
3. 外网ip不一致时，新增或者更新域名解析记录
4. 兼容阿里云、腾讯云域名

## API格式
* 阿里云：
```
http(s)://alidns.aliyuncs.com/?
&Action=UpdateDomainRecord
&RecordId=9999985
&RR=www
&Type=A
&Value=202.106.0.20
&<公共请求参数>
```
```json
{
	"RecordId":"9999985",
	"RequestId":"536E9CAD-DB30-4647-AC87-AA5CC38C5382"
}
```

* 腾讯云：
```
https://cns.api.qcloud.com/v2/index.php?
&<公共请求参数>
&Action=RecordModify
&domain=xxx.com
&recordId=281628246
&subDomain=www
&recordType=A
&recordLine=默认
&value=202.106.0.20
```
```json
{
    "code": 0,
    "message": "",
    "codeDesc": "Success",
    "data": {
        "record": {
            "id": 282529938,
            "name": "yizeronew1487857638",
            "value": "112.112.21.21",
            "status": "enable",
            "weight": null
        }
    }
}
```

## 解析记录类型格式


| 类型名称     | 类型取值       | 类型定义                                                     | 类型描述                                                     |
| :--------  | :----------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| A记录       | A            | 参考标准；RR值可为空，即@解析；不允许含有下划线；            | IPv4地址格式                                                 |
| NS记录      | NS           | 参考标准；RR值不能为空；允许含有下划线；不支持泛解析         | NameType形式                                                 |
| MX记录      | MX           | 参考标准；RR值可为空，即@解析；不允许含有下划线              | NameType形式，且不可为IP地址。1-10，优先级依次递减。         |
| TXT记录     | TXT          | 参考标准；另外，有效字符除字母、数字、“-”（中横杠）、还包括“_”(下划线)；RR值可为空，即@解析；允许含有下划线；不支持泛解析 | 字符串；长度小于512,合法字符：大小写字母，数字,空格，及以下字符：-~=:;/.@+^!* |
| CNAME记录   | CNAME        | 参考标准；另外，有效字符除字母、数字、“-”（中横杠）、还包括“_”(下划线)；RR值不允许为空（即@）；允许含有下划线 | NameType形式，且不可为IP                                     |
| SRV记录     | SRV          | 是一个name，且可含有下划线“_“和点“.”；允许含有下划线；可为空（即@）；不支持泛解析 | priority:优先级，为0－65535之间的数字；weight：权重，为0－65535之间的数字；port：提供服务的端口号，为0－65535之间的数字 target：为提供服务的目标地址，为nameType，且存在。参考：http://en.wikipedia.org/wiki/SRV_record http://www.rfc-editor.org/rfc/rfc2782.txt |
| AAAA记录    | AAAA         | 参考标准；RR值可为空，即@解析；不允许含有下划线；            | IPv6地址格式                                                 |
| CAA记录     | CAA          | 参考标准；RR值可为空，即@解析；不允许含有下划线；            | 格式为：[flag] [tag] [value]，是由一个标志字节的[flag],和一个被称为属性的标签[tag]-值[value]对组成。例如：@ 0 issue "symantec.com"或@ 0 iodef "mailto:admin@aliyun.com" |
| 显性URL转发 | REDIRECT_URL | 参考标准；RR值可为空，即@解析                                | NameType或URL地址（区分大小写），长度最长为500字符，其中域名，如a.com，必须，大小写不敏感；协议：可选，如http、https，默认为http端口：可选，如81，默认为80；路径：可选，大小写敏感，如/path/to/，默认为/；文件名：可选，大小写敏感，如file.php，默认无；参数：可选，大小写敏感，如?user=my***，默认无。 |
| 隐性URL转发 | FORWARD_URL  | 参考标准；RR值可为空，即@解析                                | NameType或URL地址（区分大小写），长度最长为500字符，其中域名，如a.com，必须，大小写不敏感；协议：可选，如http、https，默认为http端口：可选，如81，默认为80；路径：可选，大小写敏感，如/path/to/，默认为/；文件名：可选，大小写敏感，如file.php，默认无；参数：可选，大小写敏感，如?user=my***，默认无。 |

##参考：
* https://blog.csdn.net/windy1001/article/details/90243477
* https://api.aliyun.com/?spm=a2c4g.11186623.2.20.741a644edXP7L7#/?product=Alidns&api=DescribeSubDomainRecords&params=%7B%7D&tab=DEMO&lang=PYTHON
* https://help.aliyun.com/document_detail/29776.html?spm=a2c4g.11186623.6.637.741a644edXP7L7
* https://blog.csdn.net/fenghuizhidao/article/details/104970229
* https://cloud.tencent.com/document/product/302/8511