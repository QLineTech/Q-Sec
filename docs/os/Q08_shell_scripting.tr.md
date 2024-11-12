# Unix/Linux Shell Scripting Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Ağ Yönetimi](Q07_network_management.tr.md) | [Sonraki: Veri İşleme →](Q09_data_processing.tr.md)

## İçindekiler
1. [Temel Shell Script Yapısı](#temel-shell-script-yapısı)
2. [Değişkenler ve Veri Tipleri](#değişkenler-ve-veri-tipleri)
3. [Kontrol Yapıları](#kontrol-yapıları)
4. [Döngüler](#döngüler)
5. [Fonksiyonlar](#fonksiyonlar)
6. [Argüman İşleme](#argüman-işleme)
7. [Dosya İşlemleri](#dosya-işlemleri)
8. [Ödevler](#ödevler)
9. [Kaynaklar](#kaynaklar)

## Temel Shell Script Yapısı

### Script Başlangıcı
```bash
#!/bin/bash

# Script açıklaması
# Yazar: Ad Soyad
# Tarih: 2024-01-01

# Değişkenler
SCRIPT_VERSION="1.0"
DEBUG=true
```

### Script Çalıştırma
```bash
# İzin verme
chmod +x script.sh

# Çalıştırma
./script.sh
bash script.sh
```

## Değişkenler ve Veri Tipleri

### Değişken Tanımlama
```bash
# Temel değişkenler
isim="Ahmet"
yas=25
pi=3.14

# Sabitler
readonly MAKSIMUM=100
declare -r MINIMUM=0

# Dizi tanımlama
renkler=("kırmızı" "mavi" "yeşil")
declare -A hayvanlar=([kedi]="miyav" [köpek]="hav")
```

### Değişken Kullanımı
```bash
echo "Merhaba $isim"
echo "Dizinin ilk elemanı: ${renkler[0]}"
echo "Kedinin sesi: ${hayvanlar[kedi]}"

# Özel değişkenler
echo "Script adı: $0"
echo "İlk argüman: $1"
echo "Argüman sayısı: $#"
echo "Tüm argümanlar: $@"
echo "Son komutun çıkış kodu: $?"
```

## Kontrol Yapıları

### if-else Yapısı
```bash
if [ "$yas" -ge 18 ]; then
    echo "Yetişkin"
elif [ "$yas" -ge 13 ]; then
    echo "Genç"
else
    echo "Çocuk"
fi

# Dosya kontrolleri
if [ -f "dosya.txt" ]; then
    echo "Dosya mevcut"
fi

# String kontrolleri
if [[ "$isim" == "Ahmet" ]]; then
    echo "Merhaba Ahmet"
fi
```

### case Yapısı
```bash
case "$1" in
    "başlat")
        echo "Başlatılıyor..."
        ;;
    "durdur")
        echo "Durduruluyor..."
        ;;
    *)
        echo "Bilinmeyen komut"
        ;;
esac
```

## Döngüler

### for Döngüsü
```bash
# Dizi üzerinde döngü
for renk in "${renkler[@]}"; do
    echo "$renk"
done

# Sayısal döngü
for i in {1..5}; do
    echo "$i"
done

# C-style döngü
for ((i=0; i<5; i++)); do
    echo "$i"
done
```

### while Döngüsü
```bash
# Sayaç ile döngü
sayac=0
while [ $sayac -lt 5 ]; do
    echo "$sayac"
    ((sayac++))
done

# Dosya okuma
while read -r satir; do
    echo "$satir"
done < "dosya.txt"
```

### until Döngüsü
```bash
sayac=0
until [ $sayac -ge 5 ]; do
    echo "$sayac"
    ((sayac++))
done
```

## Fonksiyonlar

### Fonksiyon Tanımlama
```bash
# Temel fonksiyon
selamla() {
    echo "Merhaba $1"
}

# Değer döndüren fonksiyon
topla() {
    local a=$1
    local b=$2
    echo $((a + b))
}

# Fonksiyon çağırma
selamla "Ahmet"
sonuc=$(topla 5 3)
```

### Fonksiyon Örnekleri
```bash
# Log fonksiyonu
log() {
    local seviye=$1
    shift
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$seviye] $*"
}

# Hata kontrolü
kontrol_et() {
    if [ $? -ne 0 ]; then
        log "HATA" "$1"
        exit 1
    fi
}
```

## Argüman İşleme

### getopts Kullanımı
```bash
while getopts "f:v" secim; do
    case $secim in
        f)
            dosya="$OPTARG"
            ;;
        v)
            verbose=true
            ;;
        *)
            echo "Kullanım: $0 [-f dosya] [-v]"
            exit 1
            ;;
    esac
done
```

### Argüman Kontrolü
```bash
if [ $# -lt 1 ]; then
    echo "Kullanım: $0 dosya"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Dosya bulunamadı: $1"
    exit 1
fi
```

## Dosya İşlemleri

### Dosya Okuma
```bash
# Satır satır okuma
while IFS= read -r satir; do
    echo "$satir"
done < "dosya.txt"

# Tüm dosyayı okuma
icerik=$(<dosya.txt)
```

### Dosya Yazma
```bash
# Dosyaya yazma
echo "Yeni satır" > dosya.txt
echo "Eklenen satır" >> dosya.txt

# Here document
cat << EOF > dosya.txt
Birinci satır
İkinci satır
EOF
```

## Ödevler

### Başlangıç Seviyesi
1. Basit hesap makinesi:
```bash
#!/bin/bash

echo "İki sayı girin:"
read -p "Sayı 1: " sayi1
read -p "Sayı 2: " sayi2

echo "Toplam: $((sayi1 + sayi2))"
echo "Fark: $((sayi1 - sayi2))"
echo "Çarpım: $((sayi1 * sayi2))"
echo "Bölüm: $((sayi1 / sayi2))"
```

2. Dosya yedekleme:
```bash
#!/bin/bash

kaynak="$1"
hedef="${kaynak}.bak"

if [ -f "$kaynak" ]; then
    cp "$kaynak" "$hedef"
    echo "Yedek oluşturuldu: $hedef"
else
    echo "Dosya bulunamadı: $kaynak"
fi
```

### Orta Seviye
1. Log analizi:
```bash
#!/bin/bash

log_dosyasi="/var/log/syslog"
aranan="error"

echo "Son 24 saatteki hatalar:"
grep -i "$aranan" "$log_dosyasi" | \
    awk '{print $1,$2,$3,$5}' | \
    sort | uniq -c
```

2. Sistem monitörü:
```bash
#!/bin/bash

while true; do
    echo "=== Sistem Durumu ==="
    date
    echo "--- CPU Kullanımı ---"
    top -bn1 | head -n 3
    echo "--- Bellek Kullanımı ---"
    free -h
    sleep 5
    clear
done
```

### İleri Seviye
1. Otomatik yedekleme sistemi
2. Log toplama ve analiz sistemi

## Kaynaklar

### Man Sayfaları
```bash
man bash
man test
man awk
man sed
```

### Çevrimiçi Kaynaklar
1. [Bash Manual](https://www.gnu.org/software/bash/manual/)
2. [Shell Scripting Tutorial](https://www.shellscript.sh/)
3. [Advanced Bash Scripting Guide](https://tldp.org/LDP/abs/html/)

### Hızlı Başvuru Tablosu

| Operator | Açıklama | Örnek |
|----------|----------|--------|
| -eq | Eşitlik | [ "$a" -eq "$b" ] |
| -ne | Eşit değil | [ "$a" -ne "$b" ] |
| -gt | Büyüktür | [ "$a" -gt "$b" ] |
| -lt | Küçüktür | [ "$a" -lt "$b" ] |
| -f | Dosya var mı | [ -f "dosya" ] |
| -d | Dizin var mı | [ -d "dizin" ] |
| -z | String boş mu | [ -z "$str" ] |
| -n | String dolu mu | [ -n "$str" ] |

### Dosya Test Operatörleri

| Test | Açıklama |
|------|-----------|
| -e | Var mı |
| -f | Normal dosya mı |
| -d | Dizin mi |
| -r | Okunabilir mi |
| -w | Yazılabilir mi |
| -x | Çalıştırılabilir mi |
| -s | Boyut sıfırdan büyük mü |

[← Önceki: Ağ Yönetimi](Q07_network_management.tr.md) | [Sonraki: Veri İşleme →](Q09_data_processing.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
