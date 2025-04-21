#!/bin/bash

echo "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" > /etc/pihole/adlists.list
echo "https://v.firebog.net/hosts/Easylist.txt" >> /etc/pihole/adlists.list
echo "https://big.oisd.nl" >> /etc/pihole/adlists.list
echo "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt" >> /etc/pihole/adlists.list

# then run the original entrypoint
exec start.sh "$@"
