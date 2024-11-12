# Unix/Linux Sistem İzleme Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Veri İşleme](Q09_data_processing.tr.md) | [Sonraki: Yedekleme →](Q11_backup_management.tr.md)

## İçindekiler
1. [Sistem Kaynakları İzleme](#sistem-kaynakları-izleme)
2. [Süreç İzleme](#süreç-izleme)
3. [Disk ve Depolama İzleme](#disk-ve-depolama-izleme)
4. [Ağ İzleme](#ağ-izleme)
5. [Log İzleme](#log-izleme)
6. [Performans İzleme](#performans-izleme)
7. [Ödevler](#ödevler)
8. [Kaynaklar](#kaynaklar)

## Sistem Kaynakları İzleme

### top Komutu
```bash
# Temel Kullanım
top                     # Canlı sistem izleme
top -u kullanici       # Kullanıcı süreçleri
top -b -n 1           # Tek seferlik çıktı

# İnteraktif Komutlar
# P - CPU kullanımına göre sırala
# M - Bellek kullanımına göre sırala
# T - Çalışma süresine göre sırala
# k - Süreç sonlandır
# r - Yeniden önceliklendir
```

### htop Gelişmiş Sistem İzleme
```bash
# Kurulum
sudo apt install htop

# Temel Kullanım
htop
htop -u kullanici
htop -p PID1,PID2

# Kısayollar
# F5 - Ağaç görünümü
# F6 - Sıralama
# F9 - Süreç sonlandır
# F10 - Çıkış
```

### vmstat ve free
```bash
# Bellek ve Swap İzleme
free -h                # İnsan okunabilir format
free -m               # MB cinsinden
vmstat                # Sanal bellek istatistikleri
vmstat 5              # 5 saniyede bir güncelle
```

## Süreç İzleme

### ps Komutu
```bash
# Temel Kullanım
ps aux               # Tüm süreçler
ps -ef              # Tüm süreçler (farklı format)
ps -u kullanici     # Kullanıcı süreçleri

# Özel Kullanımlar
ps aux --sort=-%cpu  # CPU kullanımına göre
ps aux --sort=-%mem  # Bellek kullanımına göre
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu
```

### pstree ve pidof
```bash
# Süreç Ağacı
pstree              # Süreç hiyerarşisi
pstree -p          # PID'lerle
pstree kullanici   # Kullanıcı süreçleri

# Süreç ID Bulma
pidof nginx        # nginx süreçlerinin PID'leri
```

## Disk ve Depolama İzleme

### df ve du
```bash
# Disk Kullanımı
df -h               # Disk kullanımı
df -i               # Inode kullanımı
du -sh *           # Dizin boyutları
du -h --max-depth=1 /var  # Bir seviye derinlik

# En Büyük Dizinler
du -h /var | sort -rh | head -n 10
```

### iotop ve iostat
```bash
# Disk I/O İzleme
sudo iotop         # Disk I/O izleme
iostat            # I/O istatistikleri
iostat -x 5       # Detaylı, 5 saniyede bir
```

## Ağ İzleme

### netstat ve ss
```bash
# Bağlantı İzleme
netstat -tuln     # Açık portlar
netstat -anp      # Tüm bağlantılar
ss -tuln         # Açık portlar (yeni komut)
ss -s            # İstatistikler
```

### iftop ve nethogs
```bash
# Ağ Trafiği İzleme
sudo iftop        # Arayüz trafiği
sudo nethogs      # Süreç bazlı ağ kullanımı
```

## Log İzleme

### journalctl
```bash
# Sistem Günlükleri
journalctl                   # Tüm günlükler
journalctl -f               # Canlı takip
journalctl -u nginx.service # Servis günlükleri
journalctl --since "1 hour ago"
```

### logwatch
```bash
# Log Analizi
sudo apt install logwatch
logwatch --detail high --range today
logwatch --service sshd --detail high
```

## Performans İzleme

### sar (System Activity Reporter)
```bash
# Kurulum
sudo apt install sysstat

# Kullanım
sar -u             # CPU kullanımı
sar -r             # Bellek kullanımı
sar -b             # I/O istatistikleri
sar -n DEV        # Ağ istatistikleri
```

### atop
```bash
# Kurulum
sudo apt install atop

# Kullanım
atop              # Canlı sistem izleme
atop -r /var/log/atop/atop_20240101 # Geçmiş veriler
```

## Ödevler

### Başlangıç Seviyesi
1. Sistem kaynak izleme:
```bash
#!/bin/bash
# CPU ve bellek kullanımını izle
while true; do
    echo "=== $(date) ==="
    top -bn1 | head -n 5
    free -h
    sleep 5
done
```

2. Disk kullanım raporu:
```bash
#!/bin/bash
# En çok yer kaplayan dizinleri bul
echo "En büyük 10 dizin:"
du -h / 2>/dev/null | sort -rh | head -n 10
```

### Orta Seviye
1. Süreç izleme scripti:
```bash
#!/bin/bash
# Belirli bir sürecin kaynak kullanımını izle
process=$1
while true; do
    ps -p $(pidof $process) -o %cpu,%mem,cmd
    sleep 2
done
```

2. Ağ trafiği analizi:
```bash
#!/bin/bash
# Ağ bağlantılarını analiz et
netstat -tan | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -rn
```

### İleri Seviye
1. Kapsamlı sistem izleme scripti
2. Log analiz ve raporlama sistemi

## Kaynaklar

### Man Sayfaları
```bash
man top
man htop
man ps
man sar
```

### Çevrimiçi Kaynaklar
1. [Linux Performance](http://www.brendangregg.com/linuxperf.html)
2. [Monitoring Linux Performance](https://www.digitalocean.com/community/tutorials/monitoring-linux-performance)
3. [System Performance Tools](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/performance_tuning_guide/chap-red_hat_enterprise_linux-performance_tuning_guide-performance_monitoring_tools)

### Hızlı Başvuru Tablosu

| Komut | Kullanım | Açıklama |
|-------|----------|-----------|
| top | top | Sistem kaynakları |
| htop | htop | Gelişmiş sistem izleme |
| ps | ps aux | Süreç listesi |
| free | free -h | Bellek kullanımı |
| df | df -h | Disk kullanımı |
| netstat | netstat -tuln | Ağ bağlantıları |

### İzleme Araçları Tablosu

| Kategori | Araç | Özellikler |
|----------|------|------------|
| CPU | top, htop | Süreç ve CPU izleme |
| Bellek | free, vmstat | Bellek ve swap kullanımı |
| Disk | df, du, iotop | Disk kullanımı ve I/O |
| Ağ | netstat, iftop | Ağ trafiği ve bağlantılar |
| Log | journalctl, logwatch | Sistem günlükleri |

[← Önceki: Veri İşleme](Q09_data_processing.tr.md) | [Sonraki: Yedekleme →](Q11_backup_management.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
