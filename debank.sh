#!/usr/bin/sh
#see https://debank.com/ranking/locked_value
curr_date=`date +%Y%m%d`

curl -s 'https://static1.debank.com/tvl/projects-v2.json' > ./data/debank_raw.json
jq '.[] | {"name": .name.en, "chain": .chain, "locked_usd": .data[-1].locked_usd_value}' ./data/debank_raw.json | jq -c . > ./data/debank_rope.json

csv_fpath="./data/debank_${curr_date}.csv"
echo -e "name,chain,locked_usd" > $csv_fpath
awk -F '[",]' '{ print $4","$9","$13}' ./data/debank_rope.json | sed 's/://g' | sed 's/}//g' >> $csv_fpath
