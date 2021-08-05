#!/usr/bin/sh
#see https://defillama.com/home
curr_date=`date +%Y%m%d`

curl -s 'https://api.llama.fi/protocols' > ./data/defillama_raw.json
jq '.[] | {"name": .name, "chain": .chain, "locked_usd": .tvl}' ./data/defillama_raw.json | jq -c . > ./data/defillama_rope.json

csv_fpath="./data/defillama_${curr_date}.csv"
echo -e "name,chain,locked_usd" > $csv_fpath
awk -F '[",]' '{ print $4","$9","$13}' ./data/defillama_rope.json | sed 's/://g' | sed 's/}//g' >> $csv_fpath
