#!/usr/bin/sh
curr_date=`date +%Y-%m-%d`

cd /workspace/defi
sh debank.sh
sh defibox.sh
sh defillama.sh
sh defistation.sh

md_fpath="./defi_tvl.md"

echo -e "## DeFi TVL(Total Value Locked) [$curr_date]\n" > $md_fpath
echo -e "##### Include [DeBank](https://debank.com/ranking/locked_value) [DeFiBox](https://www.defibox.com/defirange/?type=all&chain=all) [DEFISTATION](https://www.defistation.io/) [DeFiLlama](https://defillama.com/home)\n---\n" >> $md_fpath

echo -e "### DeFi TVL History Data\n" >> $md_fpath

ls -al ./data | grep .csv$ | awk '{ print "* https://www.k1ic.com/defi/"$9 }' >> $md_fpath

ps -ef | grep gitbook | grep -v grep | awk '{ print "kill -9 "$2}' | sh
