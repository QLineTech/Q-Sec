# Unix/Linux Süreç Yönetimi Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: İzinler](Q03_permissions.tr.md) | [Sonraki: Paket Yukleme →](Q05_package-managment.tr.md)

## İçindekiler
1. [Süreç Kavramları](#süreç-kavramları)
2. [Süreç İzleme](#süreç-izleme)
3. [Süreç Yönetimi Komutları](#süreç-yönetimi-komutları)
4. [Sinyal Yönetimi](#sinyal-yönetimi)
5. [Arka Plan İşlemleri](#arka-plan-işlemleri)
6. [Öncelik Yönetimi](#öncelik-yönetimi)
7. [Ödevler](#ödevler)
8. [Kaynaklar](#kaynaklar)

## Süreç Kavramları

### Temel Kavramlar
- **PID (Process ID)**: Her sürece verilen benzersiz kimlik
- **PPID (Parent Process ID)**: Üst sürecin kimliği
- **Daemon**: Arka planda çalışan sistem hizmetleri
- **Zombie**: Sonlanmış ama temizlenmemiş süreçler
- **Thread**: Süreç içindeki iş parçacığı

### Süreç Durumları
- **R (Running)**: Çalışıyor
- **S (Sleeping)**: Uyuyor
- **D (Uninterruptible Sleep)**: Kesintisiz uyku
- **Z (Zombie)**: Zombi süreç
- **T (Stopped)**: Durdurulmuş

## Süreç İzleme

### ps Komutu
```bash
# Temel Kullanım
ps                  # Mevcut terminal süreçleri
ps aux              # Tüm süreçler (detaylı)
ps -ef              # Tüm süreçler (standart format)
ps -u kullanici     # Kullanıcıya ait süreçler

# Özel Kullanımlar
ps axjf             # Süreç ağacı görünümü
ps aux --sort=-%cpu # CPU kullanımına göre sırala
ps aux --sort=-%mem # Bellek kullanımına göre sırala
```

### top Komutu
```bash
top                 # Canlı süreç izleme
top -u kullanici    # Kullanıcı süreçlerini izle

# Top içinde kullanılabilen tuşlar
- k: Süreç sonlandır
- r: Yeniden önceliklendir
- c: Komut yolu göster/gizle
- M: Belleğe göre sırala
- P: CPU'ya göre sırala
- q: Çıkış
```

### htop Komutu (Gelişmiş top)
```bash
htop                # Etkileşimli süreç izleme
```

## Süreç Yönetimi Komutları

### kill Komutu
```bash
# Temel Kullanım
kill PID            # Süreç sonlandır (SIGTERM)
kill -9 PID         # Zorla sonlandır (SIGKILL)
kill -l             # Sinyal listesi

# Özel Kullanımlar
killall firefox     # İsme göre sonlandır
pkill firefox       # Desene göre sonlandır
```

### nice ve renice
```bash
# Öncelik değeri ayarlama (-20 en yüksek, 19 en düşük)
nice -n 10 komut    # Düşük öncelikle başlat
renice -n 5 PID     # Çalışan sürecin önceliğini değiştir
```

## Sinyal Yönetimi

### Temel Sinyaller
```bash
SIGHUP  (1)  # Yeniden yapılandır
SIGINT  (2)  # Kesme (Ctrl+C)
SIGKILL (9)  # Zorla sonlandır
SIGTERM (15) # Nazikçe sonlandır
SIGSTOP (19) # Durdur
SIGCONT (18) # Devam et
```

### Sinyal Gönderme
```bash
kill -SIGTERM PID   # SIGTERM sinyali gönder
kill -SIGHUP PID    # Yeniden yapılandırma sinyali
```

## Arka Plan İşlemleri

### Arka Plana Alma
```bash
komut &             # Arka planda başlat
Ctrl + Z            # Mevcut süreci durdur
bg                  # Durdurulan süreci arka planda devam ettir
fg                  # Arka plan sürecini ön plana al
```

### jobs Komutu
```bash
jobs                # Arka plan işlerini listele
jobs -l             # PID'lerle birlikte listele
```

## Öncelik Yönetimi

### nice Değerleri
```bash
# Öncelik değerleri: -20 (en yüksek) ile 19 (en düşük)
nice -n 10 ./script.sh   # Düşük öncelikle başlat
renice -n 5 1234         # PID 1234'ün önceliğini değiştir
```

## Ödevler

### Başlangıç Seviyesi
1. Sistem süreçlerini izleme:
   ```bash
   # Aşağıdaki komutları çalıştırıp çıktıları karşılaştırın
   ps aux
   top
   htop
   ```

2. Basit bir arka plan işlemi:
   ```bash
   # sleep komutu ile deney
   sleep 100 &
   jobs
   fg
   bg
   ```

### Orta Seviye
1. Süreç önceliği deneyi:
   ```bash
   # İki farklı öncelikle işlem çalıştırma
   nice -n 19 find / -name "*.txt" > dusuk_oncelik.txt &
   nice -n -10 find / -name "*.log" > yuksek_oncelik.txt &
   top  # Farkı gözlemleyin
   ```

2. Sinyal yönetimi:
   ```bash
   # Test scripti yazın ve sinyalleri deneyin
   ./test.sh &
   kill -SIGSTOP $!
   kill -SIGCONT $!
   kill -SIGTERM $!
   ```

### İleri Seviye
1. Sistem yük izleme scripti yazın:
   ```bash
   # En çok CPU/RAM kullanan süreçleri izleyen script
   ```

2. Zombi süreç oluşturup temizleme:
   ```bash
   # Zombi süreç oluşturan ve temizleyen script yazın
   ```

## Kaynaklar

### Man Sayfaları
```bash
man ps
man top
man kill
man nice
```

### Çevrimiçi Kaynaklar
1. [Linux Process Management](https://www.kernel.org/doc/html/latest/admin-guide/pm/)
2. [Linux Signals Handling](https://www.gnu.org/software/libc/manual/html_node/Signal-Handling.html)
3. [Process States in Linux](https://www.geeksforgeeks.org/process-states-linux-operating-system/)

### Hızlı Başvuru Tablosu

| Komut | Açıklama | Örnek |
|-------|----------|--------|
| ps | Süreç listesi | ps aux |
| top | Canlı süreç izleme | top |
| kill | Süreç sonlandırma | kill -9 PID |
| nice | Öncelik ile başlatma | nice -n 10 ./script.sh |
| renice | Öncelik değiştirme | renice -n 5 PID |
| jobs | Arka plan işleri | jobs -l |
| bg | Arka plana alma | bg %1 |
| fg | Ön plana alma | fg %1 |

### Önemli Sinyaller Tablosu

| Sinyal | Numara | Açıklama | Örnek |
|--------|---------|----------|--------|
| SIGHUP | 1 | Yeniden yapılandır | kill -1 PID |
| SIGINT | 2 | Kesme (Ctrl+C) | kill -2 PID |
| SIGKILL | 9 | Zorla sonlandır | kill -9 PID |
| SIGTERM | 15 | Normal sonlandır | kill -15 PID |
| SIGSTOP | 19 | Durdur | kill -19 PID |
| SIGCONT | 18 | Devam et | kill -18 PID |

[← Önceki: İzinler](Q03_permissions.tr.md) | [Sonraki: Paket Yukleme →](Q05_package-managment.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
