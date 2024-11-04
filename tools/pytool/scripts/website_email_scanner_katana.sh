#!/bin/bash

# Kullanım kontrolü
if [ $# -eq 0 ]; then
    echo "Kullanım: $0 <alan_adı>"
    exit 1
fi

domain=$1
output_file="katana_mail_info_${domain}.txt"

# Katana'nın yüklü olduğunu kontrol et
if ! command -v katana &> /dev/null; then
    echo "Katana bulunamadı. Lütfen yükleyin: https://github.com/projectdiscovery/katana"
    exit 1
fi

# Gerekli diğer araçların kontrolü
for tool in dig jq; do
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

# Katana ile web sitesini tara
echo "Katana ile web sitesi taranıyor..."
katana_output=$(katana -u "https://$domain" -jc -silent)

# E-posta adreslerini çıkar
echo "E-posta adresleri çıkarılıyor..."
emails=$(echo "$katana_output" | jq -r '.[] | select(.input_data) | .input_data' | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" | sort -u)

if [ -n "$emails" ]; then
    echo "E-posta adresleri bulundu:"
    echo "$emails"
    save_results "Bulunan E-posta Adresleri:"
    save_results "$emails"
else
    echo "E-posta adresi bulunamadı."
    save_results "E-posta adresi bulunamadı."
fi

# Olası mail sunucularını tespit et
echo "Olası mail sunucuları tespit ediliyor..."
potential_mail_servers=$(echo "$katana_output" | jq -r '.[] | select(.input_data) | .input_data' | grep -E -i "mail\.|smtp\.|pop\.|imap\." | sort -u)

if [ -n "$potential_mail_servers" ]; then
    echo "Olası mail sunucuları bulundu:"
    echo "$potential_mail_servers"
    save_results "Olası Mail Sunucuları:"
    save_results "$potential_mail_servers"
else
    echo "Olası mail sunucusu bulunamadı."
    save_results "Olası mail sunucusu bulunamadı."
fi

# Mail ile ilgili sayfaları tespit et
echo "Mail ile ilgili sayfalar tespit ediliyor..."
mail_pages=$(echo "$katana_output" | jq -r '.[] | select(.input_data) | .input_data' | grep -E -i "mail|email|contact|support" | sort -u)

if [ -n "$mail_pages" ]; then
    echo "Mail ile ilgili sayfalar bulundu:"
    echo "$mail_pages"
    save_results "Mail ile İlgili Sayfalar:"
    save_results "$mail_pages"
else
    echo "Mail ile ilgili sayfa bulunamadı."
    save_results "Mail ile ilgili sayfa bulunamadı."
fi

echo "Tarama tamamlandı. Sonuçlar $output_file dosyasında."