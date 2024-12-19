# Linux Cron Jobs Detaylı Eğitim Rehberi

## 1. Temel Seviye

### Cron Nedir?
Cron, Linux sistemlerde görevleri otomatik olarak belirli zamanlarda çalıştırmak için kullanılan bir zamanlanmış görev planlayıcısıdır.

### Temel Cron Sözdizimi
```bash
* * * * * komut
│ │ │ │ │
│ │ │ │ └── Haftanın günü (0-7) (Pazar = 0 veya 7)
│ │ │ └──── Ay (1-12)
│ │ └────── Ayın günü (1-31)
│ └──────── Saat (0-23)
└────────── Dakika (0-59)
```

### Basit Örnekler:

1. Her gün saat 03:00'da sistem güncellemesi:
```bash
0 3 * * * apt update && apt upgrade -y
```

2. Her saatin başında log dosyasına tarih yazdırma:
```bash
0 * * * * date >> /var/log/tarih.log
```

3. Her 5 dakikada bir disk kullanımı kontrolü:
```bash
*/5 * * * * df -h > /var/log/disk_usage.log
```

## 2. Orta Seviye

### Güvenlik Odaklı Cron Görevleri

#### 1. Başarısız Giriş Denemelerini İzleme
```bash
0 * * * * grep "Failed password" /var/log/auth.log | mail -s "Failed Login Report" admin@domain.com
```

#### 2. Dosya İzinlerini Kontrol Etme
```bash
0 2 * * * find /home -type f -perm 777 > /var/log/777_files.log
```

#### 3. Yedekleme Görevi
```bash
0 1 * * * tar -czf /backup/etc-$(date +\%Y\%m\%d).tar.gz /etc
```

### Özel Zaman Formatları

1. Her 10 dakikada bir:
```bash
*/10 * * * * komut
```

2. Sadece hafta içi:
```bash
0 9 * * 1-5 komut
```

3. Ayın ilk günü:
```bash
0 0 1 * * komut
```

## 3. İleri Seviye

### Karmaşık Güvenlik Senaryoları

#### 1. Çoklu Komut Zincirleme
```bash
# Sistem güvenlik taraması ve raporlama
0 23 * * * {
    echo "=== Güvenlik Taraması ===" > /var/log/security_scan.log
    netstat -tuln >> /var/log/security_scan.log
    ps aux | grep root >> /var/log/security_scan.log
    find / -perm -4000 2>/dev/null >> /var/log/security_scan.log
} && mail -s "Günlük Güvenlik Raporu" admin@domain.com < /var/log/security_scan.log
```

#### 2. Koşullu Çalıştırma
```bash
# Disk kullanımı %90'ı geçerse uyarı
*/30 * * * * df -h | awk '{ if($5 > "90%") print $0 }' | mail -s "Disk Uyarısı" admin@domain.com
```

#### 3. Log Rotasyonu ve Analizi
```bash
# Günlük log analizi ve rotasyonu
0 0 * * * {
    find /var/log -name "*.log" -mtime +30 -exec gzip {} \;
    find /var/log -name "*.gz" -mtime +90 -delete
}
```

### En İyi Uygulamalar

1. Hata Yakalama:
```bash
* * * * * komut >> /var/log/cron.log 2>&1
```

2. Lock Dosyası Kullanımı:
```bash
#!/bin/bash
LOCKFILE="/tmp/myscript.lock"

if [ -f "$LOCKFILE" ]; then
    exit 1
fi

touch "$LOCKFILE"
trap 'rm -f "$LOCKFILE"' EXIT

# Ana script içeriği buraya
```

3. E-posta Bildirimleri:
```bash
MAILTO=admin@domain.com
0 * * * * /scripts/security_check.sh
```

## 4. Güvenlik İpuçları

1. Cron Dosyası İzinleri:
```bash
chmod 600 /etc/crontab
chown root:root /etc/crontab
```

2. Cron Loglarını İzleme:
```bash
grep CRON /var/log/syslog
```

3. Cron Aktivitelerini Denetleme:
```bash
for user in $(cut -f1 -d: /etc/passwd); do
    crontab -u $user -l 2>/dev/null
done
```

## 5. Örnek Güvenlik Senaryoları

### Senaryo 1: Sistem Dosyaları İzleme
```bash
#!/bin/bash
# /root/scripts/file_monitor.sh
KRITIK_DOSYALAR="/etc/passwd /etc/shadow /etc/sudoers"
LOG_DOSYASI="/var/log/file_changes.log"

for dosya in $KRITIK_DOSYALAR; do
    yeni_hash=$(md5sum $dosya | cut -d' ' -f1)
    eski_hash=$(grep "$dosya" /var/log/hash_list.txt 2>/dev/null | cut -d' ' -f1)
    
    if [ "$yeni_hash" != "$eski_hash" ]; then
        echo "$(date): $dosya değiştirildi!" >> $LOG_DOSYASI
        mail -s "Dosya Değişikliği Uyarısı" admin@domain.com < $LOG_DOSYASI
    fi
done
```

Cron görevi:
```bash
*/30 * * * * /root/scripts/file_monitor.sh
```

### Senaryo 2: Bağlantı Analizi
```bash
#!/bin/bash
# /root/scripts/connection_monitor.sh
ESIK_DEGERI=100
IP_SAYISI=$(netstat -an | grep ESTABLISHED | wc -l)

if [ $IP_SAYISI -gt $ESIK_DEGERI ]; then
    netstat -an | grep ESTABLISHED > /tmp/connections.txt
    mail -s "Yüksek Bağlantı Uyarısı" admin@domain.com < /tmp/connections.txt
fi
```

Cron görevi:
```bash
*/5 * * * * /root/scripts/connection_monitor.sh
```

### Senaryo 3: Otomatik Güvenlik Güncellemeleri
```bash
#!/bin/bash
# /root/scripts/security_updates.sh
LOG="/var/log/security_updates.log"

echo "Güvenlik güncellemesi kontrolü: $(date)" >> $LOG
apt update >> $LOG 2>&1
apt upgrade -s | grep "security" | mail -s "Güvenlik Güncellemeleri Mevcut" admin@domain.com
```

Cron görevi:
```bash
0 3 * * * /root/scripts/security_updates.sh
```

## 6. Sorun Giderme

### Yaygın Hatalar ve Çözümleri

1. Script Çalışmıyor:
- PATH değişkenini kontrol edin
- Script izinlerini kontrol edin
- Tam yol kullanın

2. E-posta Gelmiyor:
- mailutils kurulu olduğundan emin olun
- MAILTO değişkenini kontrol edin
- mail komutunu test edin

3. Zamanlama Sorunları:
- Sistem saatini kontrol edin
- Cron servisinin çalıştığını doğrulayın
- Cron sözdizimini doğrulayın
