# Unix/Linux Dosya ve Dizin İzinleri Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Temel Komutlar](Q09_base_commands.tr.md) | [Sonraki: Süreç Yönetimi →](Q11_process_management.tr.md)

## İçindekiler
1. [Temel İzin Kavramları](#temel-izin-kavramları)
2. [İzin Türleri](#izin-türleri)
3. [İzinleri Görüntüleme](#izinleri-görüntüleme)
4. [İzinleri Değiştirme](#izinleri-değiştirme)
5. [Özel İzinler](#özel-izinler)
6. [Örnekler ve Senaryolar](#örnekler-ve-senaryolar)
7. [Ödevler](#ödevler)
8. [Kaynaklar](#kaynaklar)

## Temel İzin Kavramları

### İzin Yapısı
```
rwx rwx rwx
│   │   └── Diğerleri (Others)
│   └──── Grup (Group)
└──────── Sahip (Owner)
```

### Kullanıcı Sınıfları
- **Sahip (u)**: Dosyanın sahibi
- **Grup (g)**: Dosyanın ait olduğu grup
- **Diğerleri (o)**: Diğer tüm kullanıcılar
- **Tümü (a)**: Tüm kullanıcılar (u+g+o)

## İzin Türleri

### Temel İzinler
- **r (read - 4)**: Okuma izni
  - Dosya: İçeriği okuyabilme
  - Dizin: Listeleme yapabilme

- **w (write - 2)**: Yazma izni
  - Dosya: İçeriği değiştirebilme
  - Dizin: Dosya oluşturma/silme

- **x (execute - 1)**: Çalıştırma izni
  - Dosya: Çalıştırabilme
  - Dizin: İçine girebilme

### Sayısal Gösterim
```bash
chmod 755 dosya
# 7 (rwx) = 4 + 2 + 1
# 5 (r-x) = 4 + 0 + 1
# 5 (r-x) = 4 + 0 + 1
```

## İzinleri Görüntüleme

### ls Komutu ile
```bash
ls -l dosya.txt
# Çıktı: -rw-r--r-- 1 kullanici grup 1234 Oca 1 12:00 dosya.txt

ls -ld dizin
# Çıktı: drwxr-xr-x 2 kullanici grup 4096 Oca 1 12:00 dizin
```

### stat Komutu ile
```bash
stat dosya.txt
# Detaylı dosya bilgisi ve izinleri gösterir
```

## İzinleri Değiştirme

### chmod Komutu
```bash
# Sembolik Mod
chmod u+x dosya        # Sahibine çalıştırma izni ekle
chmod g-w dosya        # Gruptan yazma iznini kaldır
chmod o=r dosya        # Diğerlerine sadece okuma izni ver
chmod a+x dosya        # Herkese çalıştırma izni ekle

# Sayısal Mod
chmod 644 dosya        # rw-r--r--
chmod 755 dosya        # rwxr-xr-x
chmod 600 dosya        # rw-------
```

### Özyinelemeli İzin Değiştirme
```bash
chmod -R 755 dizin     # Tüm alt dizin ve dosyalara uygula
```

## Örnekler ve Senaryolar

### Web Sunucu Senaryosu
```bash
# Web dizini oluştur
mkdir -p /var/www/site

# Apache kullanıcısına sahiplik ver
chown -R www-data:www-data /var/www/site

# Uygun izinleri ayarla
chmod -R 755 /var/www/site
chmod -R 644 /var/www/site/*.html
```

### Paylaşımlı Dizin Senaryosu
```bash
# Grup oluştur
groupadd proje

# Dizin oluştur
mkdir /proje

# Grup sahipliği ve izinleri ayarla
chgrp proje /proje
chmod 2775 /proje  # SGID ile birlikte
```

## Ödevler

### Başlangıç Seviyesi
1. Aşağıdaki dizin yapısını oluşturun ve izinleri ayarlayın:
```
~/web-proje/
├── public/         (755)
│   ├── index.html  (644)
│   └── style.css   (644)
├── private/        (700)
│   └── config.txt  (600)
└── scripts/        (755)
    └── backup.sh   (755)
```

2. Her bir dosya ve dizinin izinlerini `ls -l` ile kontrol edin
3. İzinleri hem sayısal hem de sembolik modda değiştirmeyi deneyin

### Orta Seviye
1. Paylaşımlı bir proje dizini oluşturun:
   - Grup oluşturun
   - SGID biti ayarlayın
   - Test dosyaları oluşturup izinleri kontrol edin

2. Özel izinleri test edin:
   - SUID örneği oluşturun
   - Sticky bit kullanımını deneyin
   - İzinlerin etkilerini gözlemleyin

## Kaynaklar

### Man Sayfaları
```bash
man chmod
man chown
man umask
```

### Online Kaynaklar
1. [Linux Documentation Project - Permissions](https://tldp.org/LDP/intro-linux/html/sect_03_04.html)
2. [Linux File Permissions Explained](https://www.linux.com/tutorials/understanding-linux-file-permissions/)
3. [Advanced File Permissions](https://www.redhat.com/sysadmin/linux-file-permissions-explained)

### Hızlı Başvuru Tablosu

| Sayısal Değer | Sembolik | Anlamı |
|---------------|----------|---------|
| 7 | rwx | Tam yetki |
| 6 | rw- | Okuma ve yazma |
| 5 | r-x | Okuma ve çalıştırma |
| 4 | r-- | Sadece okuma |
| 3 | -wx | Yazma ve çalıştırma |
| 2 | -w- | Sadece yazma |
| 1 | --x | Sadece çalıştırma |
| 0 | --- | İzin yok |

### Özel İzinler Tablosu

| İzin | Sayısal | Sembolik | Etki |
|------|----------|----------|------|
| SUID | 4000 | u+s | Sahibinin yetkileriyle çalıştır |
| SGID | 2000 | g+s | Grubun yetkileriyle çalıştır |
| Sticky | 1000 | +t | Sadece sahibi silebilir |

[← Önceki: Temel Komutlar](Q09_base_commands.tr.md) | [Sonraki: Süreç Yönetimi →](Q11_process_management.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
