#!/bin/bash
######################################################################
# 
# $ cat list.txt 
# 34.225.197.235
# 18.205.241.111
# 52.205.121.87
# 34.237.88.176
# 34.192.14.30
#
######################################################################
while read line
do
  echo -n $line
  echo -n _ 
  openssl s_client -connect $line:443 < /dev/null 2>/dev/null | grep -e "^ 0 .*" | grep -o CN.* | sed -e "s/CN=/cname=/g" | tr -d \\n
  echo -n _
  whois $line | grep OrgName | head -n 1 | tr -d \\n
  echo '' 
done < $1 
