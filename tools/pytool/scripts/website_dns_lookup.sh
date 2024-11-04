#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain=$1
dns_servers=("8.8.8.8" "1.1.1.1" "9.9.9.9")

echo "{"
echo "  \"domain\": \"$domain\","
echo "  \"dns_lookups\": ["

for i in "${!dns_servers[@]}"; do
    server=${dns_servers[$i]}
    echo "    {"
    echo "      \"dns_server\": \"$server\","
    echo "      \"a_record\": \"$(dig +short @$server A $domain | jq -R -s -c 'split("\n")[:-1]')\","
    echo "      \"aaaa_record\": \"$(dig +short @$server AAAA $domain | jq -R -s -c 'split("\n")[:-1]')\","
    echo "      \"mx_record\": \"$(dig +short @$server MX $domain | jq -R -s -c 'split("\n")[:-1]')\","
    echo "      \"txt_record\": \"$(dig +short @$server TXT $domain | jq -R -s -c 'split("\n")[:-1]')\","
    echo "      \"ns_record\": \"$(dig +short @$server NS $domain | jq -R -s -c 'split("\n")[:-1]')\""
    if [ $i -eq $((${#dns_servers[@]}-1)) ]; then
        echo "    }"
    else
        echo "    },"
    fi
done

echo "  ]"
echo "}"