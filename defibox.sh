#!/usr/bin/sh
#see https://www.defibox.com/defirange/?type=all&chain=all
curr_date=`date +%Y%m%d`

curl 'https://www.defibox.com/dgg/ranks/v3/all?lang=cn&x-b3-traceid=3b11e053a09add6dbe946e26a48343db' \
  -H 'authority: www.defibox.com' \
  -H 'sec-ch-ua: "Chromium";v="92", " Not A;Brand";v="99", "Google Chrome";v="92"' \
  -H 'dnt: 1' \
  -H 'dgg-language: zh-cn' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36' \
  -H 'content-type: application/json;charset=UTF-8' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'dgg-uc-token: null' \
  -H 'origin: https://www.defibox.com' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://www.defibox.com/defirange/?type=all&chain=all' \
  -H 'accept-language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7,fr;q=0.6' \
  -H 'cookie: _ga=GA1.1.3963702.1628087425; _ha_session=1628130015680; _ha_session_id=aec432a8-d334-3137-9083-5867d722; _ga_WSRHXECDFG=GS1.1.1628130016.2.1.1628130567.0' \
  --data-raw '{"page":0,"size":400,"vtoken":"69aef6f731f267989bfbd1e10f3e289a","field":"locked","direction":"DESC"}' \
  --compressed -s > ./data/defibox_raw.json

jq '.data[] | {"name": .name, "chain": .chain, "locked_usd": .locked}'  data/defibox_raw.json | jq -c . > ./data/defibox_rope.json

csv_fpath="./data/defibox_${curr_date}.csv"
echo -e "name,chain,locked_usd" > $csv_fpath
awk -F '[",]' '{ print $4","$9","$13}' ./data/defibox_rope.json | sed 's/://g' | sed 's/}//g' >> $csv_fpath
