FROM pihole/pihole:2025.04.0@sha256:c2215c570976ebc23ab6688f556a80133d4236dae0bffee678129da4396fbd61

RUN echo "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" >>/etc/pihole/adlists.list
RUN echo "https://v.firebog.net/hosts/Easylist.txt" >>/etc/pihole/adlists.list
RUN echo "https://big.oisd.nl" >>/etc/pihole/adlists.list
RUN echo "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt" >>/etc/pihole/adlists.list

ENTRYPOINT ["start.sh"]
