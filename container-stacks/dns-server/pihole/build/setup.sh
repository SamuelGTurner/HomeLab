#!/bin/bash

cd /etc/pihole

# adlists.list
echo "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" > adlists.list
echo "https://v.firebog.net/hosts/Easylist.txt" >> adlists.list
echo "https://big.oisd.nl" >> adlists.list
echo "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt" >> adlists.list

# then run the original entrypoint
exec start.sh "$@"
