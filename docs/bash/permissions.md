# Ubuntu/Linux Yetki Yönetimi Rehberi

## 1. Temel Dosya İzinleri

### İzin Tipleri
- `r` (read/okuma): 4
- `w` (write/yazma): 2
- `x` (execute/çalıştırma): 1

### İzin Grupları
- Owner (Sahip)
- Group (Grup)
- Others (Diğerleri)

### İzinleri Görüntüleme
```bash
ls -l dosya_adi
# Örnek çıktı: -rwxr-xr-- 1 kullanici grup 4096 Oct 20 14:30 dosya_adi
```

İzin açıklaması:
```
-rwxr-xr--
| ||| └── Diğerleri için izinler (r--)
| || └─── Grup için izinler (r-x)
| | └──── Sahip için izinler (rwx)
| └────── Dosya tipi (- = dosya, d = dizin)
```

## 2. chmod Komutu

### Sembolik Mod
```bash
# Tek grup için izin değiştirme
chmod u+x dosya_adi    # Sahibine çalıştırma izni ekle
chmod g-w dosya_adi    # Gruptan yazma iznini kaldır
chmod o=r dosya_adi    # Diğerlerine sadece okuma izni ver

# Çoklu izin değiştirme
chmod u+rwx,g+rx,o+r dosya_adi    # Birden fazla izni aynı anda değiştir
chmod a+x dosya_adi               # Herkese çalıştırma izni ekle (a = all)
```

### Sayısal (Octal) Mod
```bash
chmod 755 dosya_adi    # rwxr-xr-x
chmod 644 dosya_adi    # rw-r--r--
chmod 777 dosya_adi    # rwxrwxrwx (dikkatli kullanın!)
chmod 700 dosya_adi    # rwx------ (en güvenli)
```

## 3. Sahiplik Değiştirme

### chown Komutu
```bash
# Sahip değiştirme
chown yeni_kullanici dosya_adi

# Sahip ve grup değiştirme
chown yeni_kullanici:yeni_grup dosya_adi

# Dizin ve alt dizinlerin sahipliğini değiştirme
chown -R kullanici:grup dizin_adi
```

### chgrp Komutu
```bash
# Sadece grup değiştirme
chgrp yeni_grup dosya_adi

# Dizin ve alt dizinlerin grubunu değiştirme
chgrp -R yeni_grup dizin_adi
```

## 4. Özel İzinler

### SUID (Set User ID)
```bash
chmod u+s dosya_adi    # SUID biti ekle
chmod 4755 dosya_adi   # SUID ile birlikte rwxr-xr-x
```

### SGID (Set Group ID)
```bash
chmod g+s dosya_adi    # SGID biti ekle
chmod 2755 dosya_adi   # SGID ile birlikte rwxr-xr-x
```

### Sticky Bit
```bash
chmod +t dizin_adi     # Sticky bit ekle
chmod 1755 dizin_adi   # Sticky bit ile birlikte rwxr-xr-x
```

## 5. Örnek Senaryolar

### Web Sunucu Dosyaları
```bash
# /var/www/html dizini için tipik izinler
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
sudo chmod -R 644 /var/www/html/*.html
```

### Script Dosyası Hazırlama
```bash
# Yeni script oluşturma ve çalıştırılabilir yapma
touch script.sh
chmod u+x script.sh
./script.sh
```

### Güvenli Dizin Oluşturma
```bash
# Sadece sahibinin erişebileceği dizin
mkdir gizli_dizin
chmod 700 gizli_dizin
```

## 6. Güvenlik İpuçları

1. Her zaman en az yetki prensibini uygulayın
2. 777 izinlerinden kaçının
3. Sistem dosyalarının izinlerini değiştirirken dikkatli olun
4. Düzenli olarak kritik dosyaların izinlerini kontrol edin

## 7. İzinleri Kontrol Etme Komutları
```bash
# Dosya izinlerini görüntüleme
stat dosya_adi

# Dizindeki tüm dosyaların izinlerini listeleme
ls -lR dizin_adi

# Belirli izinlere sahip dosyaları bulma
find /dizin -type f -perm 644
```


Linux'ta kullanıcı ve grup yönetimi için temel komutları açıklıyorum:

# Kullanıcı İşlemleri 🧑

## Kullanıcı Ekleme
```bash
sudo useradd kullaniciadi          # Temel kullanıcı oluşturma
sudo useradd -m kullaniciadi       # Ev dizini ile kullanıcı oluşturma
sudo useradd -m -s /bin/bash user  # Ev dizini ve bash kabuğu ile kullanıcı oluşturma
```

## Kullanıcı Silme
```bash
sudo userdel kullaniciadi          # Kullanıcıyı sil
sudo userdel -r kullaniciadi       # Kullanıcıyı ve ev dizinini sil
```

## Kullanıcı Şifre İşlemleri
```bash
sudo passwd kullaniciadi           # Kullanıcı şifresi belirleme/değiştirme
```

## Kullanıcı Bilgilerini Düzenleme
```bash
sudo usermod -s /bin/bash user     # Kabuk değiştirme
sudo usermod -l yeniisim eskiisim  # Kullanıcı adını değiştirme
```

# Grup İşlemleri 👥

## Grup Ekleme
```bash
sudo groupadd grupadi              # Yeni grup oluşturma
```

## Grup Silme
```bash
sudo groupdel grupadi              # Grup silme
```

## Gruba Kullanıcı Ekleme/Çıkarma
```bash
sudo usermod -aG grupadi kullanici # Kullanıcıyı gruba ekle
sudo gpasswd -d kullanici grupadi  # Kullanıcıyı gruptan çıkar
```

# Yararlı Kontrol Komutları 🔍

```bash
id kullaniciadi                    # Kullanıcı bilgilerini göster
groups kullaniciadi                # Kullanıcının gruplarını listele
cat /etc/passwd                    # Tüm kullanıcıları görüntüle
cat /etc/group                     # Tüm grupları görüntüle
```

Önemli Notlar:
- Tüm bu komutlar root yetkisi gerektirir (sudo)
- Sistem kullanıcılarını silmek tehlikeli olabilir
- Kullanıcı silmeden önce aktif işlemleri kontrol edin
- Grup silmeden önce bağımlılıkları kontrol edin

Daha detaylı bilgi ister misiniz?
