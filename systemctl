Linux'ta systemctl komutları, systemd sistem ve servis yöneticisini kontrol etmek için kullanılır. İşte en temel systemctl komutları ve açıklamaları:

# Temel systemctl Komutları

## Servis Durumu ve Kontrolü

```bash
# Servis durumunu görüntüleme
sudo systemctl status servis_adi

# Servisi başlatma
sudo systemctl start servis_adi

# Servisi durdurma
sudo systemctl stop servis_adi

# Servisi yeniden başlatma
sudo systemctl restart servis_adi

# Servisi yenileme (yapılandırma dosyasını)
sudo systemctl reload servis_adi
```

## Servis Otomatik Başlatma Ayarları

```bash
# Servisi sistem açılışında otomatik başlatmayı etkinleştirme
sudo systemctl enable servis_adi

# Servisi sistem açılışında otomatik başlatmayı devre dışı bırakma
sudo systemctl disable servis_adi

# Servisin otomatik başlatma durumunu kontrol etme
sudo systemctl is-enabled servis_adi
```

## Sistem Durumu Komutları

```bash
# Sistemin genel durumunu görüntüleme
systemctl status

# Başarısız olan servisleri listeleme
systemctl --failed

# Çalışan tüm servisleri listeleme
systemctl list-units --type=service
```

## Güç Yönetimi

```bash
# Sistemi yeniden başlatma
sudo systemctl reboot

# Sistemi kapatma
sudo systemctl poweroff

# Sistemi uyku moduna alma
sudo systemctl suspend
```

# Önemli Notlar:

1. Çoğu komut için `sudo` yetkisi gereklidir
2. Servis adları genelde `.service` uzantısı ile biter (örn: `nginx.service`)
3. Servis adını yazarken `.service` uzantısını yazmak opsiyoneldir
4. `status` komutu servis hakkında detaylı bilgi verir:
   - Çalışma durumu
   - Son log kayıtları
   - Bellek kullanımı
   - PID bilgisi
