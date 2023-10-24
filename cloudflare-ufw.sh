#!/bin/sh

cd /tmp
wget https://www.cloudflare.com/ips-v4 -O ips-v4-$$.tmp
wget https://www.cloudflare.com/ips-v6 -O ips-v6-$$.tmp

# Allow all traffic from Cloudflare IPs (no ports restriction)
for cfip in `cat ips-v{4,6}-$$.tmp`; do ufw allow from $cfip to any port 80,443 comment 'Cloudflare IP'; done

ufw reload > /dev/null

# OTHER EXAMPLE RULES
# Restrict to port 80
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 80 comment 'Cloudflare IP'; done

# Restrict to port 443
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 443 comment 'Cloudflare IP'; done

# Restrict to ports 80 & 443
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 80,443 comment 'Cloudflare IP'; done
