 Bu senaryolarda güvenlik en üst düzeyde tutulacak ve adım adım açıklamalarla ilerleyeceğiz.

# Senaryo 1: Finans Şirketi Ağ Güvenliği

## Senaryo Detayı
Bir finans şirketinin güvenlik duvarı yapılandırmasını gerçekleştireceğiz. Şirketin üç ana ağ segmenti var:
- FINANCE_TRADE (10.10.0.0/16): Trading sistemleri
- FINANCE_OFFICE (172.16.0.0/16): Ofis çalışanları
- FINANCE_DMZ (192.168.0.0/16): DMZ bölgesi

### Kritik Sistemler
- Trading Sunucuları: 10.10.10.0/24
- Veritabanı Sunucuları: 172.16.10.0/24
- Load Balancers: 192.168.10.0/24
- API Gateway: 192.168.20.0/24

```bash
#!/bin/bash

# Ağ Tanımları
TRADE_NET="10.10.0.0/16"
TRADE_SERVERS="10.10.10.0/24"
OFFICE_NET="172.16.0.0/16"
DB_SERVERS="172.16.10.0/24"
DMZ_NET="192.168.0.0/16"
LB_SERVERS="192.168.10.0/24"
API_SERVERS="192.168.20.0/24"

# Temel Güvenlik Politikaları
ufw default deny incoming
ufw default deny outgoing  # Tüm çıkış trafiği de varsayılan olarak kapalı
ufw logging full

# DMZ Bölgesi Kuralları
# Load Balancer'lar için HTTPS
ufw route allow proto tcp from any to $LB_SERVERS port 443 \
limit in rate 100/minute comment "HTTPS to Load Balancers"

# API Gateway Erişimi
ufw route allow proto tcp from any to $API_SERVERS port 443 \
limit in rate 200/minute comment "HTTPS to API Gateway"

# Trading Sistemleri
# Sadece ofis ağından trading sunucularına erişim
ufw route allow proto tcp from $OFFICE_NET to $TRADE_SERVERS port 8443 \
limit in rate 50/minute comment "Trading access"

# Trading sunucularından veritabanına erişim
ufw route allow proto tcp from $TRADE_SERVERS to $DB_SERVERS port 5432 \
comment "Trading DB access"

# Ofis Ağı Kuralları
# DNS erişimi
ufw allow out proto udp from $OFFICE_NET to any port 53 \
comment "DNS queries"
ufw allow out proto tcp from $OFFICE_NET to any port 53 \
comment "DNS TCP"

# NTP senkronizasyonu
ufw allow out proto udp from any to any port 123 \
comment "NTP sync"

# Mail erişimi (sadece ofis ağından)
ufw route allow proto tcp from $OFFICE_NET to any port 587 \
comment "Mail submission"
ufw route allow proto tcp from $OFFICE_NET to any port 993 \
comment "IMAPS"

# SSH Erişim Kontrolü
for SERVER in $TRADE_SERVERS $DB_SERVERS $LB_SERVERS $API_SERVERS; do
    ufw route allow proto tcp from $OFFICE_NET to $SERVER port 22 \
    limit in rate 6/minute comment "SSH access"
done

# Monitoring ve Logging
ufw route allow proto tcp from $OFFICE_NET to any port 9090 \
comment "Prometheus"
ufw route allow proto tcp from $OFFICE_NET to any port 3000 \
comment "Grafana"

# DDoS Koruması
ufw limit proto tcp from any to $DMZ_NET port 443 \
comment "HTTPS DDoS protection"
ufw limit proto icmp from any to any \
comment "ICMP flood protection"

# Connection Tracking
for NET in $TRADE_NET $OFFICE_NET $DMZ_NET; do
    ufw append deny proto tcp from $NET to any state new recent set
    ufw append deny proto tcp from $NET to any recent 30
done

# Logrotate ve Alert Ayarları
echo "*/5 * * * * /usr/sbin/logrotate /etc/logrotate.d/ufw" >> /etc/crontab
echo ":msg, contains, \"UFW BLOCK\" /var/log/ufw.log" > /etc/rsyslog.d/ufw.conf

ufw enable
```

### Yapılan İşlemler ve Açıklamalar:

1. **Ağ Segmentasyonu**:
   - Her segment için ayrı güvenlik politikaları
   - DMZ bölgesi için özel koruma
   - Trading sistemleri izolasyonu

2. **Erişim Kontrolü**:
   - Sadece gerekli portlar açık
   - Her segmentten çıkış trafiği kontrollü
   - SSH erişimi rate limiting ile korumalı

3. **DDoS Koruması**:
   - Rate limiting tüm kritik servislerde aktif
   - Connection tracking ile flood koruması
   - ICMP flood koruması

4. **Monitoring**:
   - Prometheus ve Grafana erişimi kontrollü
   - Detaylı loglama aktif
   - Log rotasyonu otomatik

# Senaryo 2: Sağlık Kuruluşu Ağ Güvenliği

## Senaryo Detayı
Bir sağlık kuruluşunun ağ güvenliği yapılandırması. HIPAA uyumluluğu gerekiyor.

### Ağ Segmentleri
- HEALTH_PATIENT (10.20.0.0/16): Hasta kayıt sistemleri
- HEALTH_STAFF (172.20.0.0/16): Personel sistemleri
- HEALTH_DEVICES (192.168.0.0/16): Tıbbi cihazlar

```bash
#!/bin/bash

# Ağ Tanımları
PATIENT_NET="10.20.0.0/16"
PATIENT_DB="10.20.10.0/24"
STAFF_NET="172.20.0.0/16"
STAFF_DB="172.20.10.0/24"
DEVICE_NET="192.168.0.0/16"
BACKUP_NET="192.168.10.0/24"

# Temel Güvenlik
ufw default deny incoming
ufw default deny outgoing
ufw logging full

# SSL/TLS Gereksinimleri
echo "ssl_protocols TLSv1.2 TLSv1.3;" > /etc/nginx/conf.d/ssl.conf
echo "ssl_ciphers HIGH:!aNULL:!MD5;" >> /etc/nginx/conf.d/ssl.conf

# Hasta Sistemleri
# Hasta verilerine sadece staff ağından erişim
ufw route allow proto tcp from $STAFF_NET to $PATIENT_DB port 5432 \
limit in rate 100/minute comment "Patient DB access"

# HL7 trafiği (Sağlık verileri iletişimi)
ufw route allow proto tcp from $STAFF_NET to $PATIENT_NET port 2575 \
comment "HL7 traffic"

# DICOM trafiği (Tıbbi görüntüleme)
ufw route allow proto tcp from $DEVICE_NET to $PATIENT_NET port 104 \
comment "DICOM traffic"

# Tıbbi Cihaz Ağı
for PORT in 80 443 2575 104; do
    ufw route allow proto tcp from $DEVICE_NET to any port $PORT \
    limit in rate 50/minute comment "Medical device traffic"
done

# Backup Sistemi
ufw route allow proto tcp from $PATIENT_DB to $BACKUP_NET port 2049 \
comment "NFS backup"
ufw route allow proto tcp from $STAFF_DB to $BACKUP_NET port 2049 \
comment "NFS backup"

# Monitoring (HIPAA Uyumlu)
# Prometheus metrics
ufw route allow proto tcp from $STAFF_NET to any port 9090 \
comment "Prometheus"

# Grafana dashboard
ufw route allow proto tcp from $STAFF_NET to any port 3000 \
comment "Grafana"

# ELK Stack
ufw route allow proto tcp from any to any port 9200 \
comment "Elasticsearch"
ufw route allow proto tcp from $STAFF_NET to any port 5601 \
comment "Kibana"

# Audit Logging
echo "*.* @@audit-server:514" > /etc/rsyslog.d/audit.conf
echo "module(load=\"imuxsock\")" >> /etc/rsyslog.conf
echo "module(load=\"imjournal\")" >> /etc/rsyslog.conf

# IDS/IPS Kuralları
for NET in $PATIENT_NET $STAFF_NET $DEVICE_NET; do
    ufw append deny proto tcp from $NET to any state new recent set
    ufw append deny proto tcp from $NET to any recent 20
done

# DDoS Koruması
ufw limit proto tcp from any to any port 80 \
comment "HTTP DDoS protection"
ufw limit proto tcp from any to any port 443 \
comment "HTTPS DDoS protection"
ufw limit proto icmp from any to any \
comment "ICMP flood protection"

ufw enable
```

### Yapılan İşlemler ve Açıklamalar:

1. **HIPAA Uyumluluğu**:
   - Tüm trafiğin şifrelenmesi
   - Detaylı audit logging
   - Hasta verisi izolasyonu

2. **Tıbbi Cihaz Güvenliği**:
   - DICOM trafiği kontrolü
   - Cihaz ağı izolasyonu
   - HL7 protokol güvenliği

3. **Yedekleme ve Felaket Kurtarma**:
   - NFS yedekleme sistemi
   - Yedek sistemlere kontrollü erişim
   - Audit logging

4. **Monitoring ve Denetim**:
   - ELK Stack entegrasyonu
   - HIPAA uyumlu logging
   - Real-time monitoring

Her iki senaryo da:
- Yüksek güvenlik gereksinimleri
- Karmaşık ağ segmentasyonu
- Detaylı logging ve monitoring
- DDoS koruması
- Rate limiting ve connection tracking
özelliklerini içermektedir.



