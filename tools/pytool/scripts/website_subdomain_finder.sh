#!/bin/bash

# Kullanım kontrolü
if [ $# -eq 0 ]; then
    echo "Kullanım: $0 <alan_adı>"
    exit 1
fi

domain=$1
output_file="subdomains_${domain}.txt"

# Gerekli araçların kontrolü
for tool in dig host nmap curl jq; do
    if ! command -v $tool &> /dev/null; then
        echo "$tool bulunamadı. Lütfen yükleyin."
        exit 1
    fi
done

# Fonksiyon: Alt alan adlarını kaydet
save_subdomains() {
    echo "$1" | sed 's/^//' >> "$output_file"
}

echo "Alt alan adları taranıyor: $domain"
echo "Sonuçlar $output_file dosyasına kaydedilecek."

# DNS Zone Transfer dene
echo "DNS Zone Transfer deneniyor..."
for ns in $(dig +short NS $domain); do
    zone_transfer=$(dig @$ns $domain AXFR +noall +answer | grep -v "^$domain")
    if [ ! -z "$zone_transfer" ]; then
        echo "Zone transfer başarılı: $ns"
        save_subdomains "$zone_transfer"
    fi
done

# Yaygın alt alan adlarını dene
echo "Yaygın alt alan adları deneniyor..."
for sub in www mail ftp admin blog dev stage test; do
    if host "$sub.$domain" &>/dev/null; then
        echo "$sub.$domain bulundu"
        save_subdomains "$sub.$domain"
    fi
done

# Certificated Transparency logu tara
echo "Certificate Transparency loglarını tarıyorum..."
ct_subdomains=$(curl -s "https://crt.sh/?q=%.$domain&output=json" | jq -r '.[].name_value' | sort -u)
save_subdomains "$ct_subdomains"

# Nmap ile DNS brute force
echo "Nmap ile DNS brute force yapılıyor..."
nmap_output=$(nmap --script dns-brute --script-args dns-brute.domain=$domain -oN -)
nmap_subdomains=$(echo "$nmap_output" | grep "DNS Brute-force hostnames" -A 100 | grep "$domain" | awk '{print $2}')
save_subdomains "$nmap_subdomains"

# Sonuçları temizle ve sırala
sort -u "$output_file" -o "$output_file"

echo "Tarama tamamlandı. Sonuçlar $output_file dosyasında."
echo "Bulunan toplam alt alan adı sayısı: $(wc -l < "$output_file")"