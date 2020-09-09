#!/bin/bash

time=$(date "+%Y-%m-%d %H:%M:%S")
domain_id=your_domain_id
ipv6_record_id=your_ipv6_record_id
ipv4_record_id=your_ipv4_record_id
token={ID},{TOKEN}

echo '-------------------------------------------'
echo '------  dns更新 '$time'  ------'
echo '-------------------------------------------'

# 更新ipv4
ipv4='0'
ipv4_urls=( 'api.ipify.org' 'ifconfig.me' 'ipinfo.io/ip')
for (( i = 0 ; i < ${#ipv4_urls[@]} ; i++ ))
do
  echo "get ipv4 "$i' '${ipv4_urls[$1]}
  ipv4=$(curl --connect-timeout 10 -m 10 ${ipv4_urls[$i]})
  if [ $? -eq 0 ]
  then
    break
  fi
done

if [ '$ipv4' != 0 ]
then
  echo "ipv4 is:" $ipv4
  ipv4_params='login_token='$token'&format=json&domain_id='$domain_id'&record_id='$ipv4_record_id'&sub_domain=pi&value='$ipv4'&record_type=A&record_line=默认'
  r4=$(curl -X POST https://dnsapi.cn/Record.Modify -d $ipv4_params|jq '.status')
  echo $r4
else
  echo $ipv4
  echo "获取ipv4地址失败"
fi

# 更新ipv6
ipv6=$(ip -6 address show | grep inet6|grep /64| awk '{print $2}'|cut -d'/' -f1|sort -nr|head -n1)
echo "ipv6 is:" $ipv6
ipv6_params='login_token='$token'&format=json&domain_id='$domain_id'&record_id='$ipv6_record_id'&sub_domain=pi&value='$ipv6'&record_type=AAAA&rrecord_line=默认'
r6=$(curl -X POST https://dnsapi.cn/Record.Modify -d $ipv6_params|jq '.status')
echo "$r6"                                                                                                                                                                     1,1           All