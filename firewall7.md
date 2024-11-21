# UFW Loglama Sistemi

## 1. Log Dosya Konumları

```bash
# Ana UFW log dosyası
/var/log/ufw.log

# Kernel log dosyası (UFW mesajları da burada görünür)
/var/log/kern.log

# Sistem log dosyası
/var/log/syslog
```

## 2. Loglama Seviyeleri

UFW'de 4 farklı loglama seviyesi vardır:

```bash
# Loglama kapalı
sudo ufw logging off

# Düşük seviye loglama
sudo ufw logging low

# Orta seviye loglama
sudo ufw logging medium

# Yüksek seviye loglama
sudo ufw logging high

# Tam loglama
sudo ufw logging full
```

### Seviyelerin İçerikleri:

1. **off**: Loglama tamamen kapalı
2. **low**: Sadece engellenen paketler
3. **medium**: low + kabul edilen paketler
4. **high**: medium + yeni bağlantılar
5. **full**: Tüm paket detayları

## 3. Log Örnekleri ve Açıklamaları

### Düşük Seviye (low) Log Örneği:
```plaintext
Oct 15 15:23:44 server kernel: [UFW BLOCK] IN=eth0 OUT= MAC=00:00:00:00:00:00 SRC=192.168.1.100 DST=192.168.1.10 PROTO=TCP SPT=52431 DPT=22
```
- `[UFW BLOCK]`: Engellenen paket
- `IN=eth0`: Gelen arayüz
- `SRC`: Kaynak IP
- `DST`: Hedef IP
- `DPT=22`: Hedef port (SSH)

### Orta Seviye (medium) Log Örneği:
```plaintext
Oct 15 15:24:12 server kernel: [UFW ALLOW] IN=eth0 OUT= MAC=00:00:00:00:00:00 SRC=192.168.1.50 DST=192.168.1.10 PROTO=TCP SPT=43215 DPT=80 STATE=NEW
```
- `[UFW ALLOW]`: İzin verilen paket
- `STATE=NEW`: Yeni bağlantı
- `DPT=80`: HTTP portu

### Yüksek Seviye (high) Log Örneği:
```plaintext
Oct 15 15:25:01 server kernel: [UFW AUDIT] IN=eth0 OUT= MAC=00:00:00:00:00:00 SRC=192.168.1.75 DST=192.168.1.10 PROTO=TCP SPT=52471 DPT=443 STATE=NEW FLAGS=SYN URGP=0 WINDOW=65535 RES=0x00 SYN URGP=0
```
- Detaylı TCP bayrakları
- Window boyutu
- Aciliyet pointer'ı

## 4. Log Analizi Komutları

```bash
# Son 10 log kaydını görüntüleme
tail -f /var/log/ufw.log

# Engellenen paketleri filtreleme
grep "UFW BLOCK" /var/log/ufw.log

# Belirli bir IP'den gelen trafiği izleme
grep "SRC=192.168.1.100" /var/log/ufw.log

# Belirli bir porta gelen trafiği izleme
grep "DPT=80" /var/log/ufw.log

# Yeni bağlantıları izleme
grep "STATE=NEW" /var/log/ufw.log
```

## 5. Gelişmiş Log Analizi

```bash
# JSON formatında log çıktısı
tail -f /var/log/ufw.log | jq '.'

# Saat bazlı log analizi
awk '{print $1,$2,$3}' /var/log/ufw.log

# IP bazlı istatistikler
grep "UFW BLOCK" /var/log/ufw.log | awk '{print $12}' | sort | uniq -c | sort -nr

# Port bazlı istatistikler
grep "DPT=" /var/log/ufw.log | awk -F "DPT=" '{print $2}' | cut -d" " -f1 | sort | uniq -c | sort -nr
```

## 6. Log Rotasyonu

```bash
# Log rotasyon ayarları
cat /etc/logrotate.d/ufw

# Örnek rotasyon konfigürasyonu
/var/log/ufw.log {
    rotate 7
    daily
    missingok
    notifempty
    compress
    delaycompress
    sharedscripts
    postrotate
        invoke-rc.d rsyslog rotate >/dev/null 2>&1 || true
    endscript
}
```

## 7. Real-time Monitoring İçin Örnek Script

```bash
#!/bin/bash

# UFW loglarını real-time izleyen script
tail -f /var/log/ufw.log | while read line; do
    # Engellenen paketler için kırmızı uyarı
    if [[ $line == *"BLOCK"* ]]; then
        echo -e "\e[91m$line\e[0m"
    
    # İzin verilen paketler için yeşil
    elif [[ $line == *"ALLOW"* ]]; then
        echo -e "\e[92m$line\e[0m"
    
    # Yeni bağlantılar için mavi
    elif [[ $line == *"NEW"* ]]; then
        echo -e "\e[94m$line\e[0m"
    
    # Diğer loglar için normal
    else
        echo "$line"
    fi
done
```

## 8. Örnek Alert Sistemi

```bash
#!/bin/bash

# Belirli bir IP'den çok fazla başarısız deneme olursa alert
THRESHOLD=10
IP="192.168.1.100"

COUNT=$(grep "UFW BLOCK" /var/log/ufw.log | grep "SRC=$IP" | wc -l)

if [ $COUNT -gt $THRESHOLD ]; then
    echo "Alert: $IP adresinden $COUNT başarısız deneme tespit edildi"
    # Mail gönderme veya başka alert mekanizması
    mail -s "UFW Alert" admin@domain.com << EOF
    Şüpheli aktivite tespit edildi:
    IP: $IP
    Deneme sayısı: $COUNT
    Tarih: $(date)
EOF
fi
```

Bu loglar ve analiz yöntemleri sayesinde:
- Güvenlik ihlallerini tespit edebilir
- Şüpheli aktiviteleri izleyebilir
- Ağ trafiği analizini yapabilir
- Performans sorunlarını tespit edebilirsiniz
