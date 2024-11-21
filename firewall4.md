
1) Senaryo: E-ticaret Sitesi Güvenliği
- Bir e-ticaret sitesi işletiyorsunuz
- Web sunucusu, veritabanı sunucusu ve yönetim paneli var
- Müşteriler sadece 80 ve 443 portlarından erişebilmeli
- Yönetim paneline sadece belirli IP'lerden erişim olmalı
- Veritabanına sadece web sunucusundan erişim olmalı
Görevi: UFW kurallarını oluşturun.

2) Senaryo: Oyun Sunucusu Koruması
- Minecraft ve CS:GO sunucuları çalıştırıyorsunuz
- Her oyun için farklı portlar açık olmalı
- DDoS koruması gerekli
- Sunucu yönetimi için SSH erişimi sadece yönetici IP'lerine açık olmalı
Görevi: Gerekli UFW kurallarını yazın.

3) Senaryo: Mail Sunucusu Güvenliği
- Şirket mail sunucusu kuruyorsunuz
- SMTP, POP3, IMAP servisleri çalışacak
- Sadece şirket ağından (192.168.1.0/24) erişim olmalı
- Spam koruması için rate limiting gerekli
Görevi: Mail sunucusu için UFW kurallarını oluşturun.

4) Senaryo: Uzaktan Çalışma VPN
- Şirket çalışanları VPN ile bağlanacak
- OpenVPN kullanılıyor (UDP 1194)
- Sadece şirket çalışanlarının IP bloğundan bağlantı kabul edilmeli
- Her kullanıcı için rate limiting olmalı
Görevi: VPN güvenlik kurallarını yazın.

5) Senaryo: Web Hosting Güvenliği
- Çok kullanıcılı web hosting hizmeti veriyorsunuz
- Her müşteri için FTP erişimi olmalı
- Web trafiği için rate limiting gerekli
- SSH erişimi sadece yöneticiler için açık olmalı
Görevi: Hosting güvenlik kurallarını oluşturun.

6) Senaryo: Okul Laboratuvarı
- Öğrenci bilgisayarları için güvenlik politikası
- Sadece eğitim sitelerine erişim olmalı (80/443)
- FTP ve SSH erişimi engellenmeli
- DNS ve DHCP servisleri çalışmalı
Görevi: Laboratuvar güvenlik kurallarını yazın.

7) Senaryo: IoT Cihaz Ağı
- Akıllı ev sistemleri için IoT ağı
- MQTT protokolü kullanılıyor (1883 portu)
- Cihazlar sadece yerel ağdan erişebilmeli
- Dışarıdan yönetim için özel port açık olmalı
Görevi: IoT ağı için UFW kurallarını oluşturun.

8) Senaryo: Hastane Bilgi Sistemi
- Hasta kayıtları için veritabanı sunucusu
- Sadece hastane ağından erişim olmalı
- Web arayüzü için güvenli port (443)
- Uzak erişim için VPN gerekli
Görevi: Hastane sistemi güvenlik kurallarını yazın.

9) Senaryo: Redis Cache Sunucusu
- Web uygulaması için Redis cache sunucusu
- Sadece uygulama sunucularından erişim olmalı
- 6379 portu kullanılıyor
- Rate limiting ve connection limiting gerekli
Görevi: Cache sunucusu için UFW kurallarını oluşturun.

10) Senaryo: Git Sunucusu
- Şirket içi Git sunucusu kurulumu
- SSH üzerinden git erişimi (22)
- Web arayüzü için HTTPS (443)
- Sadece şirket IP'lerinden erişim olmalı
Görevi: Git sunucusu güvenlik kurallarını yazın.

Her senaryo için öğrendiğimiz:
- Port yapılandırmaları
- Rate limiting
- IP bazlı erişim kontrolü
- DDoS koruması
- Servis bazlı güvenlik
konularını kullanabilirsiniz.


Size her senaryoyu detaylı olarak açıklayacağım. İlk 5 senaryoyu açıklıyorum, diğer 5'i de sonra açıklayacağım.

1) E-ticaret Sitesi Güvenliği

```bash
#!/bin/bash

# Değişkenler
WEB_SERVER="192.168.1.10"
DB_SERVER="192.168.1.20"
ADMIN_IPS="203.0.113.10,203.0.113.11"  # Yönetici IP'leri

# Varsayılan politikalar
ufw default deny incoming
ufw default allow outgoing
ufw logging on

# Web trafiği (tüm kullanıcılar için)
ufw allow 80/tcp comment 'HTTP'
ufw allow 443/tcp comment 'HTTPS'

# Web trafiği için rate limiting
ufw route allow proto tcp from any to $WEB_SERVER port 80 \
limit in rate 30/minute comment 'HTTP rate limit'
ufw route allow proto tcp from any to $WEB_SERVER port 443 \
limit in rate 30/minute comment 'HTTPS rate limit'

# Yönetim paneli erişimi (sadece belirli IP'ler)
for ip in ${ADMIN_IPS//,/ }; do
    ufw allow from $ip to $WEB_SERVER port 8080 proto tcp \
    comment 'Admin panel access'
done

# Veritabanı erişimi (sadece web sunucusundan)
ufw allow from $WEB_SERVER to $DB_SERVER port 3306 proto tcp \
comment 'MySQL access'

# SSH erişimi (sadece yöneticiler)
for ip in ${ADMIN_IPS//,/ }; do
    ufw limit from $ip to any port 22 proto tcp \
    comment 'SSH access'
done
```

Dikkat Edilmesi Gerekenler:
- Yönetici IP'leri güvenli bir şekilde saklanmalı
- Rate limiting değerleri trafiğe göre ayarlanmalı
- MySQL bağlantıları şifrelenmiş olmalı
- Loglar düzenli kontrol edilmeli

2) Oyun Sunucusu Koruması

```bash
#!/bin/bash

# Değişkenler
ADMIN_IPS="203.0.113.10,203.0.113.11"
MINECRAFT_PORT="25565"
CSGO_PORT="27015"

# Temel ayarlar
ufw default deny incoming
ufw default allow outgoing
ufw logging high

# Minecraft sunucusu
ufw allow $MINECRAFT_PORT/tcp comment 'Minecraft'
ufw limit proto tcp from any to any port $MINECRAFT_PORT \
comment 'Minecraft DDoS protection'

# CS:GO sunucusu
ufw allow $CSGO_PORT/{tcp,udp} comment 'CS:GO'
ufw limit proto udp from any to any port $CSGO_PORT \
comment 'CSGO DDoS protection'

# SSH erişimi (sadece yöneticiler için)
for ip in ${ADMIN_IPS//,/ }; do
    ufw limit from $ip to any port 22 proto tcp comment 'Admin SSH'
done

# Ping flood koruması
ufw limit proto icmp from any to any comment 'ICMP flood protection'
```

Dikkat Edilmesi Gerekenler:
- DDoS koruması için ek önlemler alınmalı
- Oyun portları gereksiz yere açık kalmamalı
- SSH brute force koruması aktif olmalı
- Sunucu performansı izlenmeli

3) Mail Sunucusu Güvenliği

```bash
#!/bin/bash

# Değişkenler
COMPANY_NETWORK="192.168.1.0/24"
MAIL_SERVER="192.168.1.30"

# Temel ayarlar
ufw default deny incoming
ufw default allow outgoing
ufw logging on

# Mail servisleri (sadece şirket ağından)
# SMTP
ufw allow proto tcp from $COMPANY_NETWORK to $MAIL_SERVER port 25 \
comment 'SMTP' limit in rate 30/minute

# SMTP-TLS
ufw allow proto tcp from $COMPANY_NETWORK to $MAIL_SERVER port 587 \
comment 'SMTP-TLS' limit in rate 30/minute

# POP3
ufw allow proto tcp from $COMPANY_NETWORK to $MAIL_SERVER port 110 \
comment 'POP3' limit in rate 20/minute

# IMAP
ufw allow proto tcp from $COMPANY_NETWORK to $MAIL_SERVER port 143 \
comment 'IMAP' limit in rate 20/minute

# Güvenli versiyonlar
ufw allow proto tcp from $COMPANY_NETWORK to $MAIL_SERVER port 465 \
comment 'SMTPS'
ufw allow proto tcp from $COMPANY_NETWORK to $MAIL_SERVER port 993 \
comment 'IMAPS'
ufw allow proto tcp from $COMPANY_NETWORK to $MAIL_SERVER port 995 \
comment 'POP3S'
```

Dikkat Edilmesi Gerekenler:
- SSL/TLS kullanımı zorunlu olmalı
- Spam koruması için rate limiting doğru ayarlanmalı
- Mail sunucusu güvenlik güncellemeleri düzenli yapılmalı
- Mail filtreleme sistemleri kullanılmalı

4) Uzaktan Çalışma VPN

```bash
#!/bin/bash

# Değişkenler
EMPLOYEE_NETWORK="10.0.0.0/8"
VPN_SERVER="192.168.1.40"

# Temel ayarlar
ufw default deny incoming
ufw default allow outgoing
ufw logging high

# OpenVPN
ufw allow proto udp from $EMPLOYEE_NETWORK to $VPN_SERVER port 1194 \
comment 'OpenVPN' limit in rate 10/minute

# IPsec/IKEv2
ufw allow proto udp from $EMPLOYEE_NETWORK to $VPN_SERVER port 500 \
comment 'IKEv2'
ufw allow proto udp from $EMPLOYEE_NETWORK to $VPN_SERVER port 4500 \
comment 'IKEv2 NAT-T'

# VPN monitoring
ufw allow proto tcp from $EMPLOYEE_NETWORK to $VPN_SERVER port 943 \
comment 'OpenVPN Status'
```

Dikkat Edilmesi Gerekenler:
- VPN sertifikaları güvenli şekilde dağıtılmalı
- Kullanıcı erişim logları tutulmalı
- İki faktörlü doğrulama kullanılmalı
- VPN bağlantıları şifreli olmalı

5) Web Hosting Güvenliği

```bash
#!/bin/bash

# Değişkenler
ADMIN_IPS="203.0.113.10,203.0.113.11"
HOSTING_SERVER="192.168.1.50"

# Temel ayarlar
ufw default deny incoming
ufw default allow outgoing
ufw logging on

# Web trafiği
ufw allow proto tcp to $HOSTING_SERVER port 80 \
comment 'HTTP' limit in rate 60/minute
ufw allow proto tcp to $HOSTING_SERVER port 443 \
comment 'HTTPS' limit in rate 60/minute

# FTP erişimi
ufw allow proto tcp to $HOSTING_SERVER port 21 \
comment 'FTP control'
ufw allow proto tcp to $HOSTING_SERVER port 20 \
comment 'FTP data'

# Pasif FTP portları
ufw allow proto tcp to $HOSTING_SERVER port 50000:50100 \
comment 'Passive FTP'

# SSH (sadece yöneticiler için)
for ip in ${ADMIN_IPS//,/ }; do
    ufw limit from $ip to $HOSTING_SERVER port 22 proto tcp \
    comment 'Admin SSH'
done

# cPanel erişimi
ufw allow proto tcp to $HOSTING_SERVER port 2082 comment 'cPanel'
ufw allow proto tcp to $HOSTING_SERVER port 2083 comment 'cPanel SSL'
```

Dikkat Edilmesi Gerekenler:
- FTP yerine SFTP tercih edilmeli
- Her müşteri için ayrı port ve erişim politikası olmalı
- SSL sertifikaları güncel tutulmalı
- Kullanıcı izolasyonu sağlanmalı
