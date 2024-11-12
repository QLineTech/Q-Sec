# Unix/Linux Sorun Giderme Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Performans](Q13_performance.tr.md) | [Sonraki: Docker →](Q15_docker.tr.md)

## İçindekiler
1. [Sistem Sorunları](#sistem-sorunları)
2. [Ağ Sorunları](#ağ-sorunları)
3. [Disk ve Depolama Sorunları](#disk-ve-depolama-sorunları)
4. [Servis Sorunları](#servis-sorunları)
5. [Günlük Analizi](#günlük-analizi)
6. [Ödevler](#ödevler)
7. [Kaynaklar](#kaynaklar)

## Sistem Sorunları

### Sistem Durumunu İnceleme
```bash
# Sistem Günlükleri
dmesg | tail
journalctl -xe
tail -f /var/log/syslog

# Sistem Kaynakları
top
htop
free -h
df -h

# Süreç Durumu
ps aux
pstree
```

### Boot Sorunları
```bash
# GRUB Sorunları
update-grub
grub-install /dev/sda

# İnitramfs Sorunları
update-initramfs -u
mkinitramfs -o /boot/initrd.img-$(uname -r)

# Emergency Mode
systemctl list-units --failed
journalctl -xb
```

### Bellek Sorunları
```bash
# Bellek Kullanımı
free -h
vmstat 1
ps aux --sort=-%mem | head -n 10

# OOM Killer Logları
dmesg | grep -i "out of memory"
journalctl | grep -i "out of memory"
```

## Ağ Sorunları

### Bağlantı Kontrolü
```bash
# Temel Bağlantı Testi
ping google.com
traceroute google.com
mtr google.com

# DNS Sorunları
nslookup google.com
dig google.com
cat /etc/resolv.conf

# Ağ Arayüzleri
ip addr
ifconfig
iwconfig
```

### Port ve Servis Kontrolü
```bash
# Açık Portlar
netstat -tuln
ss -tuln
lsof -i

# Bağlantı Durumu
netstat -an | grep ESTABLISHED
ss -o state established

# Paket İzleme
tcpdump -i any port 80
tcpdump -i eth0 'port 80 or port 443'
```

## Disk ve Depolama Sorunları

### Disk Sağlığı
```bash
# SMART Kontrolü
smartctl -a /dev/sda
smartctl -t short /dev/sda
smartctl -H /dev/sda

# Dosya Sistemi Kontrolü
fsck -f /dev/sda1
e2fsck -f /dev/sda1
xfs_repair /dev/sda1
```

### Disk Kullanımı
```bash
# Alan Kullanımı
df -h
du -sh /*
ncdu /

# İnode Kullanımı
df -i
find / -xdev -type f | cut -d "/" -f 2 | sort | uniq -c | sort -nr

# Büyük Dosyalar
find / -type f -size +100M -exec ls -lh {} \;
```

## Servis Sorunları

### Servis Yönetimi
```bash
# Servis Durumu
systemctl status servis.service
systemctl list-units --failed

# Servis Günlükleri
journalctl -u servis.service
tail -f /var/log/servis/error.log

# Servis Başlatma
systemctl start servis.service
systemctl restart servis.service
systemctl stop servis.service
```

### Web Sunucu Sorunları
```bash
# Apache
apachectl -t
tail -f /var/log/apache2/error.log
tail -f /var/log/apache2/access.log

# Nginx
nginx -t
tail -f /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
```

## Günlük Analizi

### Sistem Günlükleri
```bash
# Genel Günlük İnceleme
less /var/log/syslog
tail -f /var/log/messages

# Özel Günlük Analizi
grep -i error /var/log/syslog
awk '/error/ {print $1,$2,$3}' /var/log/syslog

# Güvenlik Günlükleri
tail -f /var/log/auth.log
grep "Failed password" /var/log/auth.log
```

### Log Filtreleme ve Analiz
```bash
# Tarih Bazlı Filtreleme
journalctl --since "2024-01-01" --until "2024-01-02"
journalctl --since "1 hour ago"

# Servis Bazlı Filtreleme
journalctl -u nginx.service -f
journalctl -u ssh.service -p err

# Özel Analiz
awk '/pattern/ {count[$4]++} END {for (ip in count) print ip, count[ip]}' access.log
```

## Ödevler

### Başlangıç Seviyesi
1. Sistem sağlık kontrolü:
```bash
#!/bin/bash
# Sistem sağlık kontrolü

echo "=== Sistem Durumu ==="
uptime
echo -e "\n=== Bellek Kullanımı ==="
free -h
echo -e "\n=== Disk Kullanımı ==="
df -h
echo -e "\n=== Süreç Durumu ==="
ps aux | head -n 5
```

2. Log analizi:
```bash
#!/bin/bash
# Temel log analizi

echo "=== Son Sistem Hataları ==="
grep -i error /var/log/syslog | tail -n 10

echo -e "\n=== Başarısız Giriş Denemeleri ==="
grep "Failed password" /var/log/auth.log | tail -n 5
```

### Orta Seviye
1. Servis izleme scripti:
```bash
#!/bin/bash
# Kritik servisleri izle

SERVICES=("nginx" "mysql" "ssh")

for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$service"; then
        echo "$service: ÇALIŞIYOR"
    else
        echo "$service: DURDU!"
        systemctl status "$service"
    fi
done
```

2. Disk performans analizi:
```bash
#!/bin/bash
# Disk performans analizi

echo "=== Disk I/O İstatistikleri ==="
iostat -x 1 5

echo -e "\n=== En Büyük 10 Dosya ==="
find / -type f -exec du -Sh {} + 2>/dev/null | sort -rh | head -n 10
```

### İleri Seviye
1. Kapsamlı sistem sağlık kontrol sistemi
2. Otomatik sorun tespit ve raporlama sistemi

## Kaynaklar

### Man Sayfaları
```bash
man systemctl
man journalctl
man dmesg
man tcpdump
```

### Çevrimiçi Kaynaklar
1. [Linux Troubleshooting Guide](https://www.linode.com/docs/guides/troubleshooting-guide/)
2. [Red Hat Troubleshooting Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-system_monitoring_tools)
3. [Linux Log Files](https://www.loggly.com/ultimate-guide/linux-logging-basics/)

### Hızlı Başvuru Tablosu

| Sorun | Kontrol Komutu | Log Dosyası |
|-------|----------------|-------------|
| Sistem | dmesg | /var/log/syslog |
| Bellek | free -h | /var/log/messages |
| Disk | df -h | /var/log/kern.log |
| Ağ | netstat -tuln | /var/log/daemon.log |

### Yaygın Sorunlar ve Çözümleri

| Sorun | Çözüm Adımları | Kontrol Komutu |
|-------|----------------|----------------|
| Yüksek CPU | Süreç kontrolü | top, htop |
| Disk Dolu | Alan temizleme | du, ncdu |
| Ağ Sorunu | DNS kontrolü | ping, traceroute |
| Servis Çökmesi | Log inceleme | journalctl |

[← Önceki: Performans](Q13_performance.tr.md) | [Sonraki: Docker →](Q15_docker.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
