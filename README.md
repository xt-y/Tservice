# Tservice
personal service build

## 实现目标：
通过简单配置，实现安装、配置、管理个人服务。

* 第一阶段：部署服务并记录过程
* 第二阶段：使用supervisor监控服务、并提供web查看页面
* 第三阶段*：web提供服务管理功能，可修改常用配置、启停服务
* 第四阶段*：实现自动化安装

## 包括以下服务（持续更新中）：
|服务|完成情况|
|---|------|
|DDNS|部署完成、更新脚本完成|
|FTP|未进行|
|SAMBA|未进行|
|WebDAV|未进行|

## shell工具
* jq json解析工具

## python类库：
* PyYAML
* supervisor

## 支持系统：
* Raspbian
* ubuntu（未测试）
* centos（未测试）