# Unix/Linux Servis Yönetimi Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Paket Yönetimi](Q05_package_management.tr.md) | [Sonraki: Ağ Yönetimi →](Q07_network_management.tr.md)

## İçindekiler
1. [Systemd Temelleri](#systemd-temelleri)
2. [Servis Yönetimi](#servis-yönetimi)
3. [Servis Durumu İzleme](#servis-durumu-izleme)
4. [Servis Yapılandırması](#servis-yapılandırması)
5. [Systemd Unit Dosyaları](#systemd-unit-dosyaları)
6. [Günlük (Log) Yönetimi](#günlük-log-yönetimi)
7. [Ödevler](#ödevler)
8. [Kaynaklar](#kaynaklar)

## Systemd Temelleri

### Systemd Nedir?
- Linux sistemlerinde init sistemi ve servis yöneticisi
- Paralel başlatma desteği
- Servis bağımlılıkları yönetimi
- Gelişmiş günlük kaydı

### Temel Kavramlar
- **Unit**: Systemd'nin yönettiği her kaynak
- **Target**: Sistem durumları (eski runlevel)
- **Service**: Sistem servisleri
- **Socket**: Ağ soketleri
- **Timer**: Zamanlayıcılar

## Servis Yönetimi

### systemctl Temel Komutları
```bash
# Servis Başlatma
sudo systemctl start servis.service

# Servis Durdurma
sudo systemctl stop servis.service

# Servis Yeniden Başlatma
sudo systemctl restart servis.service

# Servis Yapılandırmasını Yeniden Yükleme
sudo systemctl reload servis.service

# Servis Etkinleştirme (Sistem Başlangıcında Otomatik Başlatma)
sudo systemctl enable servis.service

# Servis Devre Dışı Bırakma
sudo systemctl disable servis.service
```

### Özel Komutlar
```bash
# Hem Etkinleştirme Hem Başlatma
sudo systemctl enable --now servis.service

# Servis Maskesi (Tamamen Devre Dışı)
sudo systemctl mask servis.service
sudo systemctl unmask servis.service

# Servis Yeniden Yükleme veya Yeniden Başlatma
sudo systemctl reload-or-restart servis.service
```

## Servis Durumu İzleme

### Durum Sorgulama
```bash
# Detaylı Durum
systemctl status servis.service

# Kısa Durum
systemctl is-active servis.service
systemctl is-enabled servis.service
systemctl is-failed servis.service

# Tüm Servisleri Listele
systemctl list-units --type=service
systemctl list-units --type=service --state=running
systemctl list-unit-files --type=service
```

### Bağımlılık İzleme
```bash
# Servis Bağımlılıkları
systemctl list-dependencies servis.service

# Ters Bağımlılıklar
systemctl list-dependencies --reverse servis.service
```

## Servis Yapılandırması

### Yapılandırma Dosyaları
```bash
# Sistem Servisleri
/lib/systemd/system/

# Kullanıcı Tanımlı Servisler
/etc/systemd/system/

# Yerel Yapılandırmalar
/etc/systemd/system/servis.service.d/
```

### Servis Düzenleme
```bash
# Servis Düzenleyici
systemctl edit servis.service

# Tam Servis Dosyası Düzenleme
systemctl edit --full servis.service

# Yapılandırma Yeniden Yükleme
systemctl daemon-reload
```

## Systemd Unit Dosyaları

### Temel Unit Dosyası Yapısı
```ini
[Unit]
Description=Örnek Servis
After=network.target
Requires=redis.service

[Service]
Type=simple
ExecStart=/usr/bin/örnek-program
ExecStop=/usr/bin/örnek-program --stop
Restart=always
User=örnek-kullanıcı

[Install]
WantedBy=multi-user.target
```

### Özel Servis Oluşturma
```bash
# Yeni Servis Dosyası
sudo nano /etc/systemd/system/özel-servis.service

# Yetki Ayarları
sudo chmod 644 /etc/systemd/system/özel-servis.service

# Systemd'yi Yeniden Yükle
sudo systemctl daemon-reload
```

## Günlük (Log) Yönetimi

### journalctl Komutları
```bash
# Tüm Günlükler
journalctl

# Servis Günlükleri
journalctl -u servis.service

# Canlı Takip
journalctl -f

# Son Günlükler
journalctl -n 100

# Zaman Aralığı
journalctl --since "2024-01-01" --until "2024-01-02"

# Önem Seviyesi
journalctl -p err
```

### Günlük Rotasyonu
```bash
# Günlük Boyutu
journalctl --disk-usage

# Eski Günlükleri Temizle
sudo journalctl --vacuum-time=2d
sudo journalctl --vacuum-size=500M
```

## Ödevler

### Başlangıç Seviyesi
1. Temel servis yönetimi:
```bash
# Apache2 servisini yönet
sudo systemctl start apache2
sudo systemctl status apache2
sudo systemctl enable apache2
```

2. Servis durumlarını izle:
```bash
# Çalışan servisleri listele
systemctl list-units --type=service --state=running
```

### Orta Seviye
1. Özel servis oluştur:
```bash
# Python web uygulaması için servis
[Unit]
Description=Python Web Uygulaması
After=network.target

[Service]
User=www-data
WorkingDirectory=/var/www/uygulama
ExecStart=/usr/bin/python3 app.py
Restart=always

[Install]
WantedBy=multi-user.target
```

2. Servis günlüklerini analiz et:
```bash
# Son 24 saatin hata günlükleri
journalctl -u özel-servis.service --since "24 hours ago" -p err
```

### İleri Seviye
1. Servis monitör scripti yaz:
```bash
# Kritik servisleri izleyen script
```

2. Otomatik kurtarma sistemi:
```bash
# Servis çöktüğünde otomatik yeniden başlatan sistem
```

## Kaynaklar

### Man Sayfaları
```bash
man systemctl
man systemd
man journalctl
```

### Çevrimiçi Kaynaklar
1. [Systemd Resmi Dokümantasyon](https://www.freedesktop.org/wiki/Software/systemd/)
2. [Systemd Unit Dosyası Rehberi](https://www.freedesktop.org/software/systemd/man/systemd.unit.html)
3. [Journald Günlük Sistemi](https://www.freedesktop.org/software/systemd/man/journalctl.html)

### Hızlı Başvuru Tablosu

| İşlem | Komut | Açıklama |
|-------|-------|-----------|
| Başlat | systemctl start | Servisi başlatır |
| Durdur | systemctl stop | Servisi durdurur |
| Yeniden Başlat | systemctl restart | Servisi yeniden başlatır |
| Durum | systemctl status | Servis durumunu gösterir |
| Etkinleştir | systemctl enable | Otomatik başlatmayı etkinleştirir |
| Devre Dışı | systemctl disable | Otomatik başlatmayı devre dışı bırakır |

### Günlük Seviyeleri

| Seviye | Açıklama | Örnek |
|--------|-----------|--------|
| emerg (0) | Sistem kullanılamaz | Çekirdek paniği |
| alert (1) | Hemen müdahale gerekli | Veritabanı çökmesi |
| crit (2) | Kritik durumlar | Donanım hatası |
| err (3) | Hata durumları | Yapılandırma hatası |
| warning (4) | Uyarı mesajları | Disk dolmak üzere |
| notice (5) | Normal ama önemli | Servis başlatıldı |
| info (6) | Bilgilendirme | Kullanıcı girişi |
| debug (7) | Hata ayıklama | Detaylı işlem bilgisi |

[← Önceki: Paket Yönetimi](Q05_package_management.tr.md) | [Sonraki: Ağ Yönetimi →](Q07_network_management.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
