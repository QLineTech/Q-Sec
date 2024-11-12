# Unix/Linux Performans Optimizasyonu Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Güvenlik](Q12_security.tr.md) | [Sonraki: Sorun Giderme →](Q14_troubleshooting.tr.md)

## İçindekiler
1. [Sistem Performansı İzleme](#sistem-performansı-izleme)
2. [CPU Optimizasyonu](#cpu-optimizasyonu)
3. [Bellek Yönetimi](#bellek-yönetimi)
4. [Disk Performansı](#disk-performansı)
5. [Ağ Performansı](#ağ-performansı)
6. [Ödevler](#ödevler)
7. [Kaynaklar](#kaynaklar)

## Sistem Performansı İzleme

### top ve htop
```bash
# top ile İzleme
top
    'P' - CPU kullanımına göre sırala
    'M' - Bellek kullanımına göre sırala
    'k' - Süreç sonlandır
    'r' - Nice değeri değiştir
    'q' - Çıkış

# htop ile Gelişmiş İzleme
htop
    F5 - Ağaç görünümü
    F6 - Sıralama
    F9 - Süreç yönetimi
```

### vmstat ve sar
```bash
# Bellek ve CPU İstatistikleri
vmstat 1
vmstat -SM 1      # MB cinsinden

# System Activity Reporter
sar -u 1 10       # CPU kullanımı (1 sn aralık, 10 örnek)
sar -r 1 10       # Bellek kullanımı
sar -b 1 10       # I/O istatistikleri
sar -n DEV 1 10   # Ağ istatistikleri
```

## CPU Optimizasyonu

### CPU Bilgisi ve İzleme
```bash
# CPU Bilgisi
lscpu
cat /proc/cpuinfo

# Yük Ortalaması
uptime
cat /proc/loadavg

# Süreç Öncelikleri
nice -n 10 komut           # Düşük öncelikle başlat
renice -n 5 -p PID        # Çalışan sürecin önceliğini değiştir
```

### CPU Governor Yönetimi
```bash
# CPU Frekans Ölçeklendirme
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Governor Değiştirme
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

## Bellek Yönetimi

### Bellek İzleme
```bash
# Bellek Kullanımı
free -h
cat /proc/meminfo

# En Çok Bellek Kullanan Süreçler
ps aux --sort=-%mem | head -n 10

# Cache Temizleme
sync; echo 3 > /proc/sys/vm/drop_caches
```

### Swap Yönetimi
```bash
# Swap Kullanımı
swapon --show
free -h

# Swap Önceliği Ayarlama
cat /proc/sys/vm/swappiness
echo 60 > /proc/sys/vm/swappiness  # Varsayılan değer

# Swap Dosyası Oluşturma
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

## Disk Performansı

### Disk İzleme
```bash
# I/O İstatistikleri
iostat -x 1
iotop -o                   # Sadece aktif süreçler

# Disk Kullanımı
df -h
du -sh /* | sort -hr

# Dosya Sistemi Performansı
hdparm -Tt /dev/sda       # Okuma hızı testi
```

### I/O Zamanlayıcı
```bash
# Mevcut Zamanlayıcı
cat /sys/block/sda/queue/scheduler

# Zamanlayıcı Değiştirme
echo "deadline" > /sys/block/sda/queue/scheduler
```

### fstrim/TRIM
```bash
# SSD TRIM
sudo fstrim -av           # Tüm bağlı SSD'lerde TRIM
sudo systemctl enable fstrim.timer  # Otomatik TRIM
```

## Ağ Performansı

### Ağ İzleme
```bash
# Ağ İstatistikleri
netstat -i
ip -s link show

# Bant Genişliği İzleme
iftop
nethogs

# TCP Ayarları
sysctl -a | grep net.ipv4.tcp
```

### Ağ Optimizasyonu
```bash
# TCP Ayarları Optimizasyonu
cat >> /etc/sysctl.conf << EOF
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_max_syn_backlog = 4096
net.core.somaxconn = 4096
EOF

sysctl -p
```

## Ödevler

### Başlangıç Seviyesi
1. Sistem performans izleme:
```bash
#!/bin/bash
# Temel performans metriklerini izle

echo "=== Sistem Performans Raporu ==="
date

echo -e "\n=== CPU Kullanımı ==="
top -bn1 | head -n 5

echo -e "\n=== Bellek Kullanımı ==="
free -h

echo -e "\n=== Disk Kullanımı ==="
df -h

echo -e "\n=== En Çok Kaynak Kullanan Süreçler ==="
ps aux --sort=-%cpu,%mem | head -n 5
```

2. I/O performans testi:
```bash
#!/bin/bash
# Disk I/O performans testi

echo "=== Disk Performans Testi ==="
sync; dd if=/dev/zero of=tempfile bs=1M count=1024 conv=fdatasync
rm tempfile

echo -e "\n=== Disk Okuma Testi ==="
hdparm -Tt /dev/sda
```

### Orta Seviye
1. Performans izleme ve raporlama:
```bash
#!/bin/bash
# Detaylı performans raporu oluştur

RAPOR="/root/performans_$(date +%Y%m%d).txt"

{
    echo "=== Sistem Bilgileri ==="
    uname -a
    lscpu
    
    echo -e "\n=== CPU Kullanımı ==="
    mpstat 1 5
    
    echo -e "\n=== Bellek Kullanımı ==="
    vmstat 1 5
    
    echo -e "\n=== Disk I/O ==="
    iostat -x 1 5
    
    echo -e "\n=== Ağ İstatistikleri ==="
    netstat -s
} > "$RAPOR"
```

2. Otomatik optimizasyon:
```bash
#!/bin/bash
# Sistem optimizasyonu gerçekleştir

# Önbellek temizleme
sync; echo 3 > /proc/sys/vm/drop_caches

# SSD TRIM
fstrim -av

# Sistem parametreleri optimizasyonu
sysctl -w vm.swappiness=60
sysctl -w vm.vfs_cache_pressure=50
```

### İleri Seviye
1. Kapsamlı performans izleme sistemi
2. Otomatik performans optimizasyon sistemi

## Kaynaklar

### Man Sayfaları
```bash
man top
man vmstat
man sar
man sysctl
```

### Çevrimiçi Kaynaklar
1. [Linux Performance](http://www.brendangregg.com/linuxperf.html)
2. [Red Hat Performance Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/performance_tuning_guide)
3. [Kernel Documentation](https://www.kernel.org/doc/Documentation/sysctl/)

### Hızlı Başvuru Tablosu

| Komut | Kullanım | Açıklama |
|-------|----------|-----------|
| top | top | Sistem aktivitesi |
| vmstat | vmstat 1 | Sanal bellek istatistikleri |
| iostat | iostat -x | Disk I/O istatistikleri |
| netstat | netstat -i | Ağ istatistikleri |
| sar | sar -u 1 10 | Sistem aktivite raporu |

### Performans Parametre Tablosu

| Parametre | Dosya | Varsayılan | Önerilen |
|-----------|-------|------------|-----------|
| swappiness | /proc/sys/vm/swappiness | 60 | 10-30 |
| vfs_cache_pressure | /proc/sys/vm/vfs_cache_pressure | 100 | 50 |
| dirty_ratio | /proc/sys/vm/dirty_ratio | 20 | 10-20 |
| somaxconn | /proc/sys/net/core/somaxconn | 128 | 4096 |

[← Önceki: Güvenlik](Q12_security.tr.md) | [Sonraki: Sorun Giderme →](Q14_troubleshooting.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
