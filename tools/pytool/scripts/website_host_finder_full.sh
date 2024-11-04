[#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Kullanım: $0 <alan_adı>"
    exit 1
fi

domain=$1
ip=$(dig +short $domain)
json_output=$(curl -s ipinfo.io/$ip)
echo "IP Bilgileri:"
echo "$json_output" | jq '.']