#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Kullanım: $0 <alan_adı>"
    exit 1
fi

domain=$1
ip=$(dig +short $domain)
location=$(curl -s ipinfo.io/$ip | jq -r '.country, .region, .city' | tr '\n' ', ' | sed 's/,$/\n/')
echo "Sunucu konumu: $location"