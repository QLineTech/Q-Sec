# Unix/Linux Veri İşleme Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Shell Scripting](Q08_shell_scripting.tr.md) | [Sonraki: Sistem İzleme →](Q10_system_monitoring.tr.md)

## İçindekiler
1. [Temel Metin İşleme](#temel-metin-işleme)
2. [grep ve Regular Expressions](#grep-ve-regular-expressions)
3. [sed (Stream Editor)](#sed-stream-editor)
4. [awk Programlama](#awk-programlama)
5. [sort ve uniq](#sort-ve-uniq)
6. [Veri Filtreleme ve Dönüştürme](#veri-filtreleme-ve-dönüştürme)
7. [Ödevler](#ödevler)
8. [Kaynaklar](#kaynaklar)

## Temel Metin İşleme

### cat ve tac
```bash
# Dosya içeriğini görüntüleme
cat dosya.txt
cat -n dosya.txt    # Satır numaraları ile
tac dosya.txt       # Tersten görüntüle

# Birden fazla dosya
cat dosya1.txt dosya2.txt
cat *.txt
```

### head ve tail
```bash
# İlk/son satırlar
head -n 5 dosya.txt      # İlk 5 satır
tail -n 10 dosya.txt     # Son 10 satır
tail -f /var/log/syslog  # Canlı izleme

# Ortadaki satırları alma
head -n 20 dosya.txt | tail -n 10
```

### cut ve paste
```bash
# Sütun seçme
cut -d',' -f1,3 dosya.csv    # 1. ve 3. sütunlar
cut -c1-10 dosya.txt         # İlk 10 karakter

# Dosyaları birleştirme
paste dosya1.txt dosya2.txt
paste -d',' dosya1.txt dosya2.txt
```

## grep ve Regular Expressions

### Temel grep Kullanımı
```bash
# Basit arama
grep "kelime" dosya.txt
grep -i "kelime" dosya.txt      # Büyük/küçük harf duyarsız
grep -v "kelime" dosya.txt      # Eşleşmeyen satırlar
grep -n "kelime" dosya.txt      # Satır numaraları ile

# Çoklu dosya
grep "kelime" *.txt
grep -r "kelime" dizin/         # Alt dizinlerde ara
```

### Regular Expressions
```bash
# Temel regex
grep "^başlangıç" dosya.txt     # Satır başı
grep "son$" dosya.txt           # Satır sonu
grep "k[ae]lime" dosya.txt      # a veya e
grep "[0-9]+" dosya.txt         # Bir veya daha fazla rakam

# Genişletilmiş regex
grep -E "\b\w+@\w+\.\w+\b" dosya.txt    # E-posta adresleri
grep -E "^[0-9]{3}-[0-9]{3}-[0-9]{4}$"  # Telefon numaraları
```

## sed (Stream Editor)

### Temel sed Komutları
```bash
# Metin değiştirme
sed 's/eski/yeni/' dosya.txt           # İlk eşleşme
sed 's/eski/yeni/g' dosya.txt         # Tüm eşleşmeler
sed -i 's/eski/yeni/g' dosya.txt      # Dosyayı değiştir

# Satır işlemleri
sed '5d' dosya.txt                    # 5. satırı sil
sed '1,5d' dosya.txt                  # 1-5 arası satırları sil
sed '/desen/d' dosya.txt              # Eşleşen satırları sil
```

### İleri sed Kullanımı
```bash
# Çoklu komut
sed -e 's/a/A/g' -e 's/e/E/g' dosya.txt

# Şartlı değiştirme
sed '/desen/s/eski/yeni/' dosya.txt

# Satır ekleme
sed '2i\Yeni Satır' dosya.txt        # 2. satırdan önce
sed '2a\Yeni Satır' dosya.txt        # 2. satırdan sonra
```

## awk Programlama

### Temel awk Kullanımı
```bash
# Alan işleme
awk '{print $1}' dosya.txt           # İlk alan
awk -F',' '{print $1,$3}' dosya.csv  # CSV alanları
awk '{print NR, $0}' dosya.txt       # Satır numarası

# Hesaplama
awk '{sum += $1} END {print sum}' dosya.txt
awk '{if($1 > 100) print $0}' dosya.txt
```

### awk Programları
```bash
# Koşullu işlemler
awk '
BEGIN {
    print "Başlık"
}
$1 > 100 {
    toplam += $1
    sayac++
}
END {
    print "Ortalama:", toplam/sayac
}' dosya.txt

# Fonksiyonlar
awk '
function karesi(x) {
    return x * x
}
{
    print $1, karesi($1)
}' dosya.txt
```

## sort ve uniq

### sort Kullanımı
```bash
# Temel sıralama
sort dosya.txt
sort -r dosya.txt                  # Ters sıralama
sort -n dosya.txt                  # Sayısal sıralama
sort -k2 dosya.txt                # 2. alana göre
sort -t',' -k2 dosya.csv          # CSV 2. alan

# Birden fazla alan
sort -k1,1 -k2,2n dosya.txt      # 1. alan metin, 2. alan sayısal
```

### uniq Kullanımı
```bash
# Tekrar edenleri ele
sort dosya.txt | uniq
sort dosya.txt | uniq -c          # Tekrar sayısı ile
sort dosya.txt | uniq -d          # Sadece tekrar edenler
sort dosya.txt | uniq -u          # Tekrar etmeyenler
```

## Veri Filtreleme ve Dönüştürme

### tr Komutu
```bash
# Karakter değiştirme
echo "Merhaba" | tr 'a-z' 'A-Z'   # Büyük harfe çevir
cat dosya.txt | tr -d ' '         # Boşlukları sil
cat dosya.txt | tr -s '\n'        # Boş satırları sıkıştır
```

### xargs Komutu
```bash
# Komut argümanı yapma
find . -name "*.txt" | xargs cat
echo "1 2 3" | xargs -n1          # Her satıra bir argüman
find . -name "*.bak" | xargs rm   # Dosyaları sil
```

## Ödevler

### Başlangıç Seviyesi
1. Log analizi:
```bash
#!/bin/bash
# Verilen log dosyasındaki hata mesajlarını bul ve say
grep -i "error" /var/log/syslog | \
    awk '{print $5}' | \
    sort | uniq -c | \
    sort -nr
```

2. CSV işleme:
```bash
#!/bin/bash
# CSV dosyasından belirli alanları çıkar
awk -F',' '{print $1 "," $3}' veri.csv > sonuc.csv
```

### Orta Seviye
1. Apache log analizi:
```bash
#!/bin/bash
# IP bazlı erişim sayıları ve HTTP kodları
awk '{print $1,$9}' access.log | \
    sort | \
    uniq -c | \
    sort -rn | \
    head -n 10
```

2. Sistem kullanıcı analizi:
```bash
#!/bin/bash
# /etc/passwd dosyasından kullanıcı istatistikleri
awk -F: '{
    shells[$7]++
}
END {
    for(s in shells)
        print shells[s], s
}' /etc/passwd | sort -rn
```

### İleri Seviye
1. Log toplama ve analiz sistemi
2. Otomatik rapor oluşturma sistemi

## Kaynaklar

### Man Sayfaları
```bash
man grep
man sed
man awk
man sort
```

### Çevrimiçi Kaynaklar
1. [GNU Text Processing](https://www.gnu.org/software/grep/manual/)
2. [AWK Guide](https://www.grymoire.com/Unix/Awk.html)
3. [SED Tutorial](https://www.grymoire.com/Unix/Sed.html)

### Hızlı Başvuru Tablosu

| Komut | Kullanım | Örnek |
|-------|----------|--------|
| grep | Metin arama | grep "kelime" dosya |
| sed | Metin değiştirme | sed 's/eski/yeni/' dosya |
| awk | Alan işleme | awk '{print $1}' dosya |
| sort | Sıralama | sort -k2 dosya |
| uniq | Tekrar edenleri ele | sort \| uniq -c |

### Regular Expression Tablosu

| Regex | Açıklama | Örnek |
|-------|-----------|--------|
| ^ | Satır başı | ^test |
| $ | Satır sonu | test$ |
| . | Herhangi karakter | t.st |
| * | 0 veya daha fazla | te*st |
| + | 1 veya daha fazla | te+st |
| ? | 0 veya 1 | te?st |
| [] | Karakter sınıfı | t[ae]st |
| [^] | Negatif sınıf | t[^0-9]st |

[← Önceki: Shell Scripting](Q08_shell_scripting.tr.md) | [Sonraki: Sistem İzleme →](Q10_system_monitoring.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
