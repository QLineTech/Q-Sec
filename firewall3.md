# UFW (Uncomplicated Firewall) Güvenlik Yapılandırma Kılavuzu

## Temel Koruma Mekanizmaları

### DOS Saldırı Önleme
* Rate limiting - Belirli IP'lerden gelen istek sayısını sınırlama
* Connection limiting - Aynı IP'den eşzamanlı bağlantı sayısını kısıtlama
* Trafik analizi - Anormal trafik paternlerini tespit etme
* Blacklisting - Saldırgan IP'leri engelleme

### Brute Force Önleme 
* Failed login attempt limiting - Başarısız giriş denemelerini sınırlama
* IP bloklama - Çok sayıda başarısız deneme yapan IP'leri geçici süreyle engelleme
* Captcha kullanımı
* İki faktörlü doğrulama zorunluluğu

## UFW Yapılandırma Komutları

### 1. Temel Güvenlik Politikası
```bash
# Varsayılan politikalar
ufw default deny incoming  # Tüm gelen trafiği reddet
ufw default allow outgoing # Tüm giden trafiğe izin ver
ufw enable                 # UFW'yi aktifleştir
```

### 2. SSH Koruması
```bash
# SSH denemelerini dakikada 6 ile sınırla
ufw limit 22/tcp comment 'SSH brute force koruması'
```

### 3. Web Sunucu Koruması
```bash
# HTTP için rate limiting (dakikada 30 istek)
ufw route allow proto tcp from any to any port 80 limit in rate 30/minute \
comment 'HTTP rate limiting'

# HTTPS için rate limiting (dakikada 30 istek)
ufw route allow proto tcp from any to any port 443 limit in rate 30/minute \
comment 'HTTPS rate limiting'
```

### 4. İç Ağ Rate Limiting
```bash
# İç ağdan gelen istekleri sınırla (192.168.1.0/24)
ufw route allow proto tcp from 192.168.1.0/24 to any port 80 \
limit in rate 60/minute comment 'İç ağ HTTP rate limiting'
```

### 5. Servis Portları Güvenliği
```bash
# DNS
ufw allow 53/tcp comment 'DNS TCP'
ufw allow 53/udp comment 'DNS UDP'

# Mail Sunucu
ufw allow 25/tcp comment 'SMTP'
ufw limit 110/tcp comment 'POP3 limit'
ufw limit 143/tcp comment 'IMAP limit'
```

### 6. DoS Koruması
```bash
# Her IP için maksimum 20 eşzamanlı bağlantı
ufw append deny proto tcp from any to any state new recent set
ufw append deny proto tcp from any to any recent 20
```

### 7. IP Engelleme (Blacklisting)
```bash
# Belirli IP ve aralıkları engelle
ufw deny from 10.10.10.10 comment 'Zararlı IP'
ufw deny from 10.10.10.0/24 comment 'Zararlı IP bloğu'
```

### 8. Ping Flood Koruması
```bash
ufw limit proto icmp from any to any comment 'Ping flood koruması'
```

### 9. Loglama Ayarları
```bash
ufw logging on
ufw logging high
```

## Notlar
POP3 limit kuralı (110/tcp), 6 bağlantı denemesinden sonra 30 saniyeliğine yeni bağlantıları otomatik olarak engelleyerek mail servislerine yönelik DDoS saldırılarına karşı koruma sağlar.





# Ağ Güvenliği - UFW Yapılandırması 

### Senaryo:
Istinye Üniversitesi'nin ağ güvenlik duvarı politikalarını yeniden yapılandırmanız isteniyor. Üniversite'nin üç farklı ağ segmenti bulunmaktadır:

1. ISU_GUEST (10.10.0.0/16): Misafir ağı
2. ISU_STAFF (172.16.0.0/16): Akademik ve idari personel ağı
3. ISU_LAB (192.168.0.0/16): Laboratuvar ve bilgisayar sınıfları ağı

### Ek Sistemler:
- Printer Sunucuları: 172.16.10.0/24 subnet'inde çalışmakta
- Akademik Portal: 172.16.20.0/24 subnet'inde hizmet vermekte
- Mail Sunucuları
- DNS Sunucuları

### Gereksinimler:

#### 1. Temel Güvenlik Politikaları (20 puan)
- Varsayılan gelen/giden trafik politikalarını belirleyin
- Loglama ayarlarını yapılandırın
- Ağ segmentlerini tanımlayın

#### 2. Servis Erişim Yönetimi (20 puan)
- Printer erişimini düzenleyin:
  * Staff ve Lab ağlarına izin verin
  * Guest ağına engel koyun
- Akademik portal erişimini yapılandırın:
  * Sadece Staff ağına izin verin
  * Rate limiting uygulayın

#### 3. Web Erişim Kontrolü (20 puan)
- Her ağ segmenti için HTTP/HTTPS erişimlerini düzenleyin
- Rate limiting uygulayın:
  * Guest: 20 istek/dakika
  * Lab: 60 istek/dakika
  * Staff: Sınırsız

#### 4. DoS ve Brute Force Koruması (20 puan)
- SSH brute force koruması yapılandırın
- Her ağ segmenti için connection limiting uygulayın
- ICMP flood koruması ekleyin

#### 5. Servis Politikaları (20 puan)
- DNS servislerini yapılandırın
- Mail servislerini (SMTP, POP3, IMAP) sadece Staff ve Lab ağlarına açın
- Her servise uygun rate limiting kuralları ekleyin

### İstenenler:
1. Tüm yapılandırmayı içeren bir Bash script yazın
2. Her adımı yorum satırları ile açıklayın
3. Her kuralın amacını ve etkisini belirtin
4. Script'in test edilebilir olmasını sağlayın

### Değerlendirme Kriterleri:
- Kod organizasyonu ve okunabilirlik
- Güvenlik politikalarının doğru uygulanması
- Yorum ve açıklamaların yeterliliği
- Rate limiting ve connection limiting ayarlarının uygunluğu
- Farklı ağ segmentleri için erişim politikalarının doğru yapılandırılması

### Teslim Şekli:
- Script dosyası: isu_ufw_config.sh
- Readme dosyası: Kurulum ve test adımlarının açıklaması
- Test senaryoları dosyası: Yapılandırmanın test edilmesi için örnek komutlar



```bash
#!/bin/bash

# ISU Ag Tanimlari
ISU_GUEST="10.10.0.0/16"   # Guest Agi
ISU_STAFF="172.16.0.0/16" # Staff Agi
ISU_LAB="192.168.0.0/16"  # Lab Agi

# Temel Kurallar
ufw default deny incoming
ufw default allow outgoing
ufw loggin on
ufw logging high

# printer sunucularim
PRINTER_SUBNET="172.16.10.0/24"

# Staff'den printer erisimi
ufw allow proto tcp from $ISU_STAFF to $PRINTER_SUBNET port 631 \
comment "Staff printer access"
# Lab'den printer erisimi 
ufw allow proto tcp from $ISU_LAB to $PRINTER_SUBNET port 631 \
comment "Staff printer access"
# Guest'e printer erisimi YOK

# Hoca Yonetim Portali
ADMIN_PORTAL="172.16.20.0/24"

# Sadece Staff aginda erisebelinsin
ufw route allow proto tcp from $ISU_STAFF to $ADMIN_PORTAL port 443 \
limit in rate 30/minute comment "Staff admin portal access"

# Guest Agi icin web erisimi (rate-limited)
ufw route allow proto tcp from $ISU_GUEST to any port 80 \
limit in rate 20/minute comment "Guest http erisimi"
ufw route allow proto tcp from $ISU_GUEST to any port 443 \
limit in rate 20/minute comment "Guest http erisimi"


# Lab Agi icin web erisimi (rate-limited)
ufw route allow proto tcp from $ISU_LAB to any port 80 \
limit in rate 60/minute comment "Guest http erisimi"
ufw route allow proto tcp from $ISU_LAB to any port 443 \
limit in rate 60/minute comment "Guest http erisimi"

# SSH Brute Force korumasi
ufw limit 22/tcp comment 'SSH Brute-force attack protection'

for SUBNET in $ISU_GUEST $ISU_LAB $ISU_STAFF; do
    ufw append deny proto tcp from $SUBNET to any state new recent set
    ufw append deny proto tcp from $SUBNET to any recent 30
done

# ufw append deny proto tcp from $ISU_GUEST to any state new recent se
# ufw append deny proto tcp from $ISU_GUEST to any recent 30

# ufw append deny proto tcp from $ISU_LAB to any state new recent se
# ufw append deny proto tcp from $ISU_LAB to any recent 30

# ufw append deny proto tcp from $ISU_STAFF to any state new recent se
# ufw append deny proto tcp from $ISU_STAFF to any recent 30

# Ping Flood Korumasi
ufw limit proto icmp from any to any comment 'Ping flood koruması'


# DNS Ayarlari
ufw allow 53/tcp comment "DNS TCP"
ufw allow 53/udp comment "DNS UDP"

# Mail Servisleri (Sadece lab ve staff)
for SUBNET in $ISU_LAB $ISU_STAFF; do
    ufw allow proto tcp from $SUBNET to any port 25 comment "SMTP"
    ufw allow proto tcp from $SUBNET to any port 110 comment "POP3"
    ufw allow proto tcp from $SUBNET to any port 143 comment "IMAP"
done

ufw enable
```




# Ağ Güvenliği Final Ödevi - UFW Güvenlik Duvarı Yapılandırması

## Senaryo
TechnoMart adlı büyük bir teknoloji mağazalar zincirinin ağ güvenlik duvarı yapılandırmasını gerçekleştirmeniz isteniyor. Şirketin üç farklı ağ segmenti bulunmaktadır:

1. TECHNO_CUSTOMER (10.10.0.0/16): Mağaza içi müşteri WiFi ağı
2. TECHNO_STAFF (172.16.0.0/16): Çalışan ve yönetici ağı  
3. TECHNO_POS (192.168.0.0/16): Kasa ve stok yönetim sistemleri ağı

## Ek Sistemler
- POS Sunucuları: 192.168.10.0/24 subnet'inde çalışmakta
- ERP Sistemi: 172.16.20.0/24 subnet'inde hizmet vermekte
- Mail Sunucuları
- DNS Sunucuları

## Gereksinimler

### 1. Temel Güvenlik Politikaları (20 puan)  
- Varsayılan gelen/giden trafik politikalarını belirleyin
- Loglama ayarlarını yapılandırın
- Ağ segmentlerini tanımlayın

### 2. POS ve ERP Erişim Yönetimi (20 puan)
- POS sistemi erişimini düzenleyin:
  * Sadece TECHNO_POS ve TECHNO_STAFF ağlarına izin verin
  * TECHNO_CUSTOMER ağından erişimi engelleyin
- ERP sistemi erişimini yapılandırın:
  * Sadece TECHNO_STAFF ağına izin verin
  * Rate limiting uygulayın

### 3. İnternet Erişim Kontrolü (20 puan)
- Her ağ segmenti için HTTP/HTTPS erişimlerini düzenleyin
- Rate limiting uygulayın:
  * TECHNO_CUSTOMER: 30 istek/dakika
  * TECHNO_POS: 50 istek/dakika  
  * TECHNO_STAFF: Sınırsız

### 4. Güvenlik Önlemleri (20 puan)
- SSH brute force koruması yapılandırın
- Her ağ segmenti için connection limiting uygulayın
- DOS ve DDOS koruması ekleyin

### 5. Servis Politikaları (20 puan)
- DNS servislerini yapılandırın
- Mail servislerini (SMTP, POP3, IMAP) sadece TECHNO_STAFF ağına açın
- Her servise uygun rate limiting kuralları ekleyin

## Teslim Gereksinimleri
1. UFW kurallarını içeren bir bash script hazırlayın (technomart_ufw.sh)
2. Her kuralı yorum satırları ile açıklayın
3. README.md dosyası oluşturun:
   - Kurulum adımları
   - Test senaryoları
   - Önemli notlar
4. Test sonuçlarını belgeleyin

## Değerlendirme Kriterleri
- Kod düzeni ve okunabilirlik (%20)
- Güvenlik politikalarının doğru uygulanması (%30)
- Yorum ve açıklamaların yeterliliği (%20)
- Rate limiting ve connection limiting ayarlarının uygunluğu (%15)
- Test senaryolarının kapsamı (%15)








