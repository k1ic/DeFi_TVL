#!/usr/bin/sh
#see https://www.defistation.io/
curr_date=`date +%Y%m%d`

curl 'https://api.defistation.io/defiTvlList' \
  -H 'Connection: keep-alive' \
  -H 'sec-ch-ua: "Chromium";v="92", " Not A;Brand";v="99", "Google Chrome";v="92"' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36' \
  -H 'DNT: 1' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'Authorization: Basic OmMyNDVhNGEyLTYxZjgtMTFlYi1hZTkzLTAyNDJhYzEzMDAwMg==' \
  -H 'Accept: */*' \
  -H 'Origin: https://www.defistation.io' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: https://www.defistation.io/' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7,fr;q=0.6' \
  -H 'If-None-Match: W/"a500-O6y6himTq0eQpjy4TcxggaXR3ag"' \
  --compressed -s > ./data/defistation_raw.json

jq '.[] | {"name": .name, "chain": .chain, "locked_usd": .lockedUsd}' ./data/defistation_raw.json | jq -c . > ./data/defistation_rope.json

csv_fpath="./data/defistation_${curr_date}.csv"
echo -e "name,chain,locked_usd" > $csv_fpath
awk -F '[",]' '{ print $4","$9","$13}' ./data/defistation_rope.json | sed 's/://g' | sed 's/}//g' >> $csv_fpath
