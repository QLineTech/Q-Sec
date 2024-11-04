#!/bin/bash

# Kullanım kontrolü
if [ $# -eq 0 ]; then
    echo "Kullanım: $0 <alan_adı>"
    exit 1
fi

domain=$1
output_file="mail_info_${domain}.txt"

# Gerekli araçların kontrolü
for tool in dig host whois nmap curl; do
    if ! command -v $tool &> /dev/null; then
        echo "$tool bulunamadı. Lütfen yükleyin."
        exit 1
    fi
done

# Fonksiyon: Sonuçları kaydet
save_results() {
    echo "$1" >> "$output_file"
}

echo "Mail sunucuları ve e-posta adresleri taranıyor: $domain"
echo "Sonuçlar $output_file dosyasına kaydedilecek."

# MX kayıtlarını kontrol et
echo "MX kayıtları kontrol ediliyor..."
mx_records=$(dig +short MX $domain)
if [ -n "$mx_records" ]; then
    echo "MX kayıtları bulundu:"
    echo "$mx_records"
    save_results "MX Kayıtları:"
    save_results "$mx_records"
else
    echo "MX kaydı bulunamadı."
    save_results "MX kaydı bulunamadı."
fi

# A kaydını kontrol et (fallback mail server)
echo "A kaydı kontrol ediliyor (fallback mail server)..."
a_record=$(dig +short A $domain)
if [ -n "$a_record" ]; then
    echo "A kaydı bulundu: $a_record"
    save_results "Fallback Mail Server (A kaydı): $a_record"
else
    echo "A kaydı bulunamadı."
fi

# SPF kaydını kontrol et
echo "SPF kaydı kontrol ediliyor..."
spf_record=$(dig +short TXT $domain | grep "v=spf1")
if [ -n "$spf_record" ]; then
    echo "SPF kaydı bulundu:"
    echo "$spf_record"
    save_results "SPF Kaydı:"
    save_results "$spf_record"
else
    echo "SPF kaydı bulunamadı."
    save_results "SPF kaydı bulunamadı."
fi

# DMARC kaydını kontrol et
echo "DMARC kaydı kontrol ediliyor..."
dmarc_record=$(dig +short TXT _dmarc.$domain)
if [ -n "$dmarc_record" ]; then
    echo "DMARC kaydı bulundu:"
    echo "$dmarc_record"
    save_results "DMARC Kaydı:"
    save_results "$dmarc_record"
else
    echo "DMARC kaydı bulunamadı."
    save_results "DMARC kaydı bulunamadı."
fi

# Whois veritabanından e-posta adresleri çıkar
echo "Whois veritabanından e-posta adresleri çıkarılıyor..."
whois_emails=$(whois $domain | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" | sort -u)
if [ -n "$whois_emails" ]; then
    echo "Whois'ten e-posta adresleri bulundu:"
    echo "$whois_emails"
    save_results "Whois E-posta Adresleri:"
    save_results "$whois_emails"
else
    echo "Whois'ten e-posta adresi bulunamadı."
    save_results "Whois'ten e-posta adresi bulunamadı."
fi

# Nmap ile yaygın mail portlarını tara
echo "Nmap ile yaygın mail portları taranıyor..."
for mx in $(echo "$mx_records" | awk '{print $NF}'); do
    echo "Taranan sunucu: $mx"
    nmap_output=$(nmap -p25,465,587,110,995,143,993 -sV $mx)
    save_results "Mail Sunucu Portları ($mx):"
    save_results "$nmap_output"
done

# Web sitesinden e-posta adresleri çıkar
echo "Web sitesinden e-posta adresleri çıkarılıyor..."
web_emails=$(curl -s "https://$domain" | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" | sort -u)
if [ -n "$web_emails" ]; then
    echo "Web sitesinden e-posta adresleri bulundu:"
    echo "$web_emails"
    save_results "Web Sitesi E-posta Adresleri:"
    save_results "$web_emails"
else
    echo "Web sitesinden e-posta adresi bulunamadı."
    save_results "Web sitesinden e-posta adresi bulunamadı."
fi

echo "Tarama tamamlandı. Sonuçlar $output_file dosyasında."