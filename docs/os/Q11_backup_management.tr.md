# Unix/Linux Yedekleme Yönetimi Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Sistem İzleme](Q10_system_monitoring.tr.md) | [Sonraki: Güvenlik →](Q12_security.tr.md)

## İçindekiler
1. [Yedekleme Stratejileri](#yedekleme-stratejileri)
2. [Yedekleme Araçları](#yedekleme-araçları)
3. [Dosya Senkronizasyonu](#dosya-senkronizasyonu)
4. [Otomatik Yedekleme](#otomatik-yedekleme)
5. [Yedek Geri Yükleme](#yedek-geri-yükleme)
6. [Ödevler](#ödevler)
7. [Kaynaklar](#kaynaklar)

## Yedekleme Stratejileri

### Yedekleme Tipleri
1. **Tam Yedekleme**
   - Tüm verilerin yedeklenmesi
   - Fazla alan kaplar
   - Geri yükleme kolay

2. **Artımlı Yedekleme**
   - Son yedekten sonraki değişiklikler
   - Daha az alan kaplar
   - Geri yükleme için tüm artımlı yedekler gerekir

3. **Fark Yedekleme**
   - Son tam yedekten sonraki değişiklikler
   - Orta seviyede alan kaplar
   - Geri yükleme için tam yedek ve son fark yedeği gerekir

### Yedekleme Planlaması
```bash
# Öneri Plan
- Günlük: Artımlı yedek
- Haftalık: Fark yedeği
- Aylık: Tam yedek
```

## Yedekleme Araçları

### tar ile Yedekleme
```bash
# Tam Yedek
tar -czf yedek_$(date +%Y%m%d).tar.gz /kaynak/dizin

# Artımlı Yedek
tar --listed-incremental=snapshot.file \
    -czf yedek_$(date +%Y%m%d).tar.gz /kaynak/dizin

# Özel Seçenekler
tar -czf yedek.tar.gz \
    --exclude='*.tmp' \
    --exclude='*/temp/*' \
    /kaynak/dizin
```

### rsync ile Yedekleme
```bash
# Temel Kullanım
rsync -av /kaynak/dizin/ /hedef/dizin/

# Uzak Sunucuya Yedekleme
rsync -avz -e ssh /kaynak/dizin/ kullanici@sunucu:/hedef/dizin/

# Silinen Dosyaları Koru
rsync -av --delete /kaynak/dizin/ /hedef/dizin/

# İlerleme Göster
rsync -av --progress /kaynak/dizin/ /hedef/dizin/
```

### dd ile Disk Yedekleme
```bash
# Disk İmajı Alma
sudo dd if=/dev/sda of=/yedek/disk.img bs=4M status=progress

# Sıkıştırılmış İmaj
sudo dd if=/dev/sda bs=4M | gzip > /yedek/disk.img.gz

# İmajı Geri Yükleme
sudo dd if=/yedek/disk.img of=/dev/sda bs=4M status=progress
```

## Dosya Senkronizasyonu

### rsync Gelişmiş Kullanım
```bash
# Ayna Kopyalama
rsync -av --delete \
    --exclude='*.tmp' \
    --exclude='temp/' \
    /kaynak/ /hedef/

# Kuru Çalıştırma
rsync -av --dry-run /kaynak/ /hedef/

# Bant Genişliği Sınırlama
rsync -av --bwlimit=1000 /kaynak/ /hedef/
```

### unison ile Senkronizasyon
```bash
# Kurulum
sudo apt install unison

# Temel Kullanım
unison /dizin1 /dizin2

# Profil Oluşturma
# ~/.unison/default.prf
root = /dizin1
root = ssh://kullanici@sunucu//dizin2
```

## Otomatik Yedekleme

### cron ile Zamanlama
```bash
# crontab Düzenleme
crontab -e

# Örnek Zamanlamalar
# Her gün gece 2'de
0 2 * * * /yedek/scripts/yedekle.sh

# Her Pazar 3'te
0 3 * * 0 /yedek/scripts/tam_yedek.sh

# Her saat başı
0 * * * * /yedek/scripts/sync.sh
```

### Yedekleme Scripti Örneği
```bash
#!/bin/bash

# Değişkenler
KAYNAK="/var/www/"
HEDEF="/yedek/www"
TARIH=$(date +%Y%m%d_%H%M%S)
LOG="/var/log/yedek.log"

# Yedekleme Fonksiyonu
yedekle() {
    echo "Yedekleme başladı: $(date)" >> "$LOG"
    
    rsync -av --delete \
        --exclude='*.tmp' \
        --exclude='cache/' \
        "$KAYNAK" "$HEDEF.$TARIH" \
        >> "$LOG" 2>&1
    
    # Eski yedekleri temizle
    find "$HEDEF"* -mtime +7 -delete
    
    echo "Yedekleme tamamlandı: $(date)" >> "$LOG"
}

# Ana Program
yedekle
```

## Yedek Geri Yükleme

### tar ile Geri Yükleme
```bash
# Tam Yedek
tar -xzf yedek.tar.gz -C /hedef/dizin

# Belirli Dosyaları Geri Yükleme
tar -xzf yedek.tar.gz -C /hedef/dizin dosya1 dosya2

# İçeriği Listele
tar -tzf yedek.tar.gz
```

### rsync ile Geri Yükleme
```bash
# Temel Geri Yükleme
rsync -av /yedek/dizin/ /hedef/dizin/

# Seçici Geri Yükleme
rsync -av --include='*.php' --exclude='*' \
    /yedek/dizin/ /hedef/dizin/
```

## Ödevler

### Başlangıç Seviyesi
1. Temel yedekleme scripti:
```bash
#!/bin/bash
# Ev dizinini yedekle
TARIH=$(date +%Y%m%d)
tar -czf "/yedek/home_$TARIH.tar.gz" /home/kullanici
```

2. Dosya senkronizasyon scripti:
```bash
#!/bin/bash
# İki dizini senkronize et
rsync -av --delete /dizin1/ /dizin2/
```

### Orta Seviye
1. Artımlı yedekleme sistemi:
```bash
#!/bin/bash
# Artımlı yedek sistemi
SNAPSHOT="/var/lib/yedek/snapshot"
TARIH=$(date +%Y%m%d)

tar --listed-incremental="$SNAPSHOT" \
    -czf "/yedek/inc_$TARIH.tar.gz" /veri
```

2. Log rotasyonu ile yedekleme:
```bash
#!/bin/bash
# Log dosyalarını yedekle ve rotasyon uygula
```

### İleri Seviye
1. Tam yedekleme sistemi
2. Otomatik geri yükleme sistemi

## Kaynaklar

### Man Sayfaları
```bash
man tar
man rsync
man dd
man cron
```

### Çevrimiçi Kaynaklar
1. [Backup HOWTO](https://tldp.org/HOWTO/Backup-HOWTO.html)
2. [rsync Examples](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories)
3. [Linux Backup Tools](https://www.linux.com/topic/backup-tools/)

### Hızlı Başvuru Tablosu

| Komut | Kullanım | Açıklama |
|-------|----------|-----------|
| tar | tar -czf | Arşiv oluştur |
| rsync | rsync -av | Dizin senkronize et |
| dd | dd if=kaynak of=hedef | Disk imajı al |
| crontab | crontab -e | Zamanlanmış görevler |

### Yedekleme Araçları Karşılaştırması

| Araç | Avantajlar | Dezavantajlar |
|------|------------|---------------|
| tar | Basit, standart | Artımlı yedek zor |
| rsync | Hızlı, verimli | Anlık durum yok |
| dd | Tam disk imajı | Büyük dosya boyutu |
| dump | Dosya sistemi seviyesi | Eski sistemlerde |

[← Önceki: Sistem İzleme](Q10_system_monitoring.tr.md) | [Sonraki: Güvenlik →](Q12_security.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
