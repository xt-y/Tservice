# 域名解析接口

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
##参考
* https://blog.csdn.net/windy1001/article/details/90243477
* https://api.aliyun.com/?spm=a2c4g.11186623.2.20.741a644edXP7L7#/?product=Alidns&api=DescribeSubDomainRecords&params=%7B%7D&tab=DEMO&lang=PYTHON
* https://help.aliyun.com/document_detail/29776.html?spm=a2c4g.11186623.6.637.741a644edXP7L7
* https://blog.csdn.net/fenghuizhidao/article/details/104970229
* https://cloud.tencent.com/document/product/302/8511