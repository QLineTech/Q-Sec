# Unix/Linux Güvenlik Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Yedekleme](Q11_backup_management.tr.md) | [Sonraki: Performans →](Q13_performance.tr.md)

## İçindekiler
1. [Temel Güvenlik Kavramları](#temel-güvenlik-kavramları)
2. [Kullanıcı ve Grup Güvenliği](#kullanıcı-ve-grup-güvenliği)
3. [Dosya Sistemi Güvenliği](#dosya-sistemi-güvenliği)
4. [Ağ Güvenliği](#ağ-güvenliği)
5. [Güvenlik İzleme](#güvenlik-izleme)
6. [Şifreleme](#şifreleme)
7. [Ödevler](#ödevler)
8. [Kaynaklar](#kaynaklar)

## Temel Güvenlik Kavramları

### Güvenlik İlkeleri
- En az yetki ilkesi
- Savunma derinliği
- Varsayılan güvenli durum
- Şeffaflık

### Güncellemelerin Önemi
```bash
# Sistem Güncellemesi
sudo apt update
sudo apt upgrade

# Güvenlik Güncellemeleri
sudo apt install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
```

## Kullanıcı ve Grup Güvenliği

### Kullanıcı Yönetimi
```bash
# Şifre Politikası
sudo nano /etc/login.defs
sudo nano /etc/pam.d/common-password

# Kullanıcı Ekleme
sudo useradd -m -s /bin/bash kullanici
sudo passwd kullanici

# Kullanıcı Kilitleme
sudo passwd -l kullanici
sudo usermod -L kullanici

# Kullanıcı Silme
sudo userdel -r kullanici
```

### sudo Yapılandırması
```bash
# sudo Düzenleme
sudo visudo

# Örnek Kurallar
kullanici ALL=(ALL:ALL) ALL
kullanici ALL=(ALL) NOPASSWD: /usr/bin/apt
%sudo ALL=(ALL:ALL) ALL
```

### SSH Güvenliği
```bash
# SSH Yapılandırması
sudo nano /etc/ssh/sshd_config

# Önerilen Ayarlar
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
AllowUsers kullanici1 kullanici2
Protocol 2

# SSH Anahtarı Oluşturma
ssh-keygen -t ed25519 -C "açıklama"
ssh-copy-id kullanici@sunucu
```

## Dosya Sistemi Güvenliği

### İzin Yönetimi
```bash
# Güvenli İzinler
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 644 /etc/passwd
chmod 640 /etc/shadow

# SUID ve SGID Kontrolü
find / -type f -perm /6000 -ls

# Özel İzinler
chmod u+s dosya  # SUID
chmod g+s dizin  # SGID
chmod +t dizin   # Sticky bit
```

### Disk Şifreleme
```bash
# LUKS ile Disk Şifreleme
sudo cryptsetup luksFormat /dev/sdb1
sudo cryptsetup luksOpen /dev/sdb1 gizli
sudo mkfs.ext4 /dev/mapper/gizli
```

## Ağ Güvenliği

### Güvenlik Duvarı (UFW)
```bash
# UFW Kurulum ve Yapılandırma
sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Temel Kurallar
sudo ufw allow 22/tcp
sudo ufw allow 80,443/tcp
sudo ufw allow from 192.168.1.0/24
sudo ufw enable
```

### fail2ban
```bash
# Kurulum ve Yapılandırma
sudo apt install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Örnek Jail Yapılandırması
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
```

### Port İzleme
```bash
# Açık Portları Kontrol
netstat -tuln
ss -tuln

# Port Tarama
sudo nmap -sS localhost
sudo nmap -A -T4 192.168.1.0/24
```

## Güvenlik İzleme

### Log İzleme
```bash
# Önemli Loglar
tail -f /var/log/auth.log
tail -f /var/log/syslog
tail -f /var/log/apache2/access.log

# Log Analizi
sudo apt install logwatch
logwatch --detail High --range Today
```

### Rootkit Kontrolü
```bash
# rkhunter Kurulum ve Kullanım
sudo apt install rkhunter
sudo rkhunter --update
sudo rkhunter --check
```

### Sistem Denetimi
```bash
# auditd Kurulum ve Yapılandırma
sudo apt install auditd
sudo auditctl -w /etc/passwd -p wa -k passwd_changes
sudo ausearch -k passwd_changes
```

## Şifreleme

### GPG Kullanımı
```bash
# Anahtar Oluşturma
gpg --gen-key
gpg --list-keys

# Dosya Şifreleme
gpg -e -r "alici@email.com" dosya
gpg -d dosya.gpg

# İmzalama
gpg --sign dosya
gpg --verify dosya.sig
```

### SSL/TLS Sertifikaları
```bash
# Öz İmzalı Sertifika
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout private.key -out certificate.crt

# Let's Encrypt
sudo apt install certbot
sudo certbot --apache
sudo certbot --nginx
```

## Ödevler

### Başlangıç Seviyesi
1. Sistem güvenlik kontrolü:
```bash
#!/bin/bash
# Temel güvenlik kontrolü
echo "=== Sistem Güvenlik Kontrolü ==="
echo "1. Açık Portlar:"
netstat -tuln

echo "2. Sistem Güncellemeleri:"
apt list --upgradable

echo "3. Disk Kullanımı:"
df -h
```

2. Kullanıcı denetimi:
```bash
#!/bin/bash
# Kullanıcı aktivitelerini izle
echo "Son Girişler:"
last | head -n 10

echo "Başarısız Girişler:"
grep "Failed password" /var/log/auth.log
```

### Orta Seviye
1. Güvenlik duvarı yönetimi:
```bash
#!/bin/bash
# UFW kurallarını yapılandır
sudo ufw reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80,443/tcp
sudo ufw enable
```

2. SSH güvenlik yapılandırması:
```bash
#!/bin/bash
# SSH güvenliğini yapılandır
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd
```

### İleri Seviye
1. Tam sistem güvenlik denetim sistemi
2. Otomatik güvenlik raporu oluşturma sistemi

## Kaynaklar

### Man Sayfaları
```bash
man sudo
man ufw
man ssh
man gpg
```

### Çevrimiçi Kaynaklar
1. [Linux Security Guide](https://www.cyberciti.biz/tips/linux-security.html)
2. [UFW Documentation](https://help.ubuntu.com/community/UFW)
3. [OpenSSH Documentation](https://www.openssh.com/manual.html)

### Hızlı Başvuru Tablosu

| Komut | Kullanım | Açıklama |
|-------|----------|-----------|
| ufw | ufw allow/deny | Güvenlik duvarı yönetimi |
| ssh-keygen | ssh-keygen -t ed25519 | SSH anahtar oluşturma |
| gpg | gpg --gen-key | GPG anahtar yönetimi |
| fail2ban | fail2ban-client status | Giriş denemesi kontrolü |

### Güvenlik Kontrol Listesi

| Kategori | Kontrol | Öneri |
|----------|---------|--------|
| Kullanıcı | Root girişi | Devre dışı bırak |
| SSH | Anahtar kimlik doğrulama | Etkinleştir |
| Güvenlik Duvarı | Varsayılan politika | Gelen trafiği reddet |
| Güncellemeler | Otomatik güncelleme | Etkinleştir |
| Loglar | Log rotasyonu | Yapılandır |

[← Önceki: Yedekleme](Q11_backup_management.tr.md) | [Sonraki: Performans →](Q13_performance.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
