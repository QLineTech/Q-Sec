# En Önemli Network Portları ve Kullanımları

## Sistem ve Güvenlik Portları

| Port | Protokol | İşletim Sistemi | Servis | Kullanım |
|------|----------|-----------------|---------|-----------|
| 20 | TCP | Tüm OS | FTP Data | Dosya transferi veri portu |
| 21 | TCP | Tüm OS | FTP Control | FTP kontrol ve komut portu |
| 22 | TCP | Linux/Unix | SSH | Güvenli uzak bağlantı |
| 23 | TCP | Tüm OS | Telnet | Uzak bağlantı (güvensiz) |
| 25 | TCP | Tüm OS | SMTP | E-posta gönderimi |
| 53 | TCP/UDP | Tüm OS | DNS | Alan adı çözümleme |
| 67-68 | UDP | Tüm OS | DHCP | IP adresi atama |
| 69 | UDP | Tüm OS | TFTP | Basit dosya transferi |
| 80 | TCP | Tüm OS | HTTP | Web trafiği |
| 88 | TCP/UDP | Windows | Kerberos | Kimlik doğrulama |
| 110 | TCP | Tüm OS | POP3 | E-posta alma |
| 123 | UDP | Tüm OS | NTP | Zaman senkronizasyonu |
| 137-139 | TCP/UDP | Windows | NetBIOS | Windows ağ servisleri |
| 143 | TCP | Tüm OS | IMAP | E-posta yönetimi |
| 161-162 | UDP | Tüm OS | SNMP | Ağ yönetimi |
| 389 | TCP/UDP | Tüm OS | LDAP | Dizin servisleri |
| 443 | TCP | Tüm OS | HTTPS | Güvenli web trafiği |
| 445 | TCP | Windows | SMB | Dosya paylaşımı |
| 464 | TCP/UDP | Windows | Kerberos | Şifre değişimi |
| 500 | UDP | Tüm OS | IKE | VPN anahtar değişimi |
| 514 | UDP | Linux/Unix | Syslog | Sistem logları |
| 515 | TCP | Tüm OS | LPD/LPR | Yazıcı servisi |
| 636 | TCP | Tüm OS | LDAPS | Güvenli dizin servisi |
| 873 | TCP | Linux/Unix | rsync | Dosya senkronizasyonu |
| 989-990 | TCP | Tüm OS | FTPS | Güvenli FTP |
| 993 | TCP | Tüm OS | IMAPS | Güvenli IMAP |
| 995 | TCP | Tüm OS | POP3S | Güvenli POP3 |

## Veritabanı Portları

| Port | Protokol | Veritabanı | Kullanım |
|------|----------|------------|-----------|
| 1433 | TCP | MS SQL | SQL Server |
| 1521 | TCP | Oracle | Oracle DB |
| 3306 | TCP | MySQL | MySQL/MariaDB |
| 5432 | TCP | PostgreSQL | PostgreSQL |
| 6379 | TCP | Redis | Redis cache |
| 27017 | TCP | MongoDB | MongoDB |

## Web Uygulama Portları

| Port | Protokol | Servis | Kullanım |
|------|----------|---------|-----------|
| 3000 | TCP | Node.js | Node.js uygulamaları |
| 4200 | TCP | Angular | Angular geliştirme |
| 5000 | TCP | Flask/Python | Python web uygulamaları |
| 8000 | TCP | Django | Django geliştirme |
| 8080 | TCP | Tomcat | Java web uygulamaları |
| 8443 | TCP | Tomcat SSL | Güvenli Tomcat |

## Uzak Masaüstü ve Yönetim

| Port | Protokol | OS | Servis | Kullanım |
|------|----------|------------|---------|-----------|
| 3389 | TCP | Windows | RDP | Uzak masaüstü |
| 5900 | TCP | Tüm OS | VNC | Uzak masaüstü |
| 5938 | TCP | TeamViewer | TeamViewer | Uzak destek |
| 7070 | TCP | RealVNC | RealVNC | VNC alternatifi |

## Monitoring ve Logging

| Port | Protokol | Servis | Kullanım |
|------|----------|---------|-----------|
| 9090 | TCP | Prometheus | Metrik toplama |
| 9100 | TCP | Node Exporter | Sistem metrikleri |
| 9200 | TCP | Elasticsearch | Log yönetimi |
| 9300 | TCP | Elasticsearch | Cluster iletişimi |
| 5601 | TCP | Kibana | Log görüntüleme |
| 3003 | TCP | Grafana | Metrik görselleştirme |

## Mail Servisleri

| Port | Protokol | Servis | Kullanım |
|------|----------|---------|-----------|
| 465 | TCP | SMTPS | Güvenli mail gönderimi |
| 587 | TCP | SMTP TLS | Mail gönderimi (TLS) |
| 2525 | TCP | SMTP Alt | Alternatif SMTP |

## Mesajlaşma ve Chat

| Port | Protokol | Servis | Kullanım |
|------|----------|---------|-----------|
| 1935 | TCP | RTMP | Medya streaming |
| 5222 | TCP | XMPP | Chat protokolü |
| 5269 | TCP | XMPP S2S | Server-to-server |
| 6665-6669 | TCP | IRC | Internet Relay Chat |

## Oyun Servisleri

| Port | Protokol | Oyun/Platform | Kullanım |
|------|----------|---------------|-----------|
| 27015 | UDP | Steam | Steam oyunları |
| 27016 | UDP | Steam | SRCDS sunucuları |
| 3074 | TCP/UDP | Xbox Live | Xbox oyun ağı |
| 3478 | UDP | PlayStation | PSN servisleri |
| 3724 | TCP | Battle.net | Blizzard oyunları |

## Güvenlik ve VPN

| Port | Protokol | Servis | Kullanım |
|------|----------|---------|-----------|
| 1194 | UDP | OpenVPN | VPN tünelleme |
| 1701 | UDP | L2TP | VPN protokolü |
| 1723 | TCP | PPTP | VPN protokolü |
| 4500 | UDP | IPSec NAT | VPN NAT-T |
| 8443 | TCP | OpenVPN | Alternatif OpenVPN |

## Containerization ve Orchestration

| Port | Protokol | Platform | Kullanım |
|------|----------|----------|-----------|
| 2375 | TCP | Docker | Docker daemon (güvensiz) |
| 2376 | TCP | Docker | Docker daemon (SSL) |
| 4243 | TCP | Docker | API |
| 6443 | TCP | Kubernetes | API server |
| 10250 | TCP | Kubernetes | Kubelet API |
| 10255 | TCP | Kubernetes | Read-only Kubelet |

## IoT ve Endüstriyel

| Port | Protokol | Servis | Kullanım |
|------|----------|---------|-----------|
| 1883 | TCP | MQTT | IoT mesajlaşma |
| 8883 | TCP | MQTT SSL | Güvenli IoT |
| 502 | TCP | Modbus | Endüstriyel kontrol |
| 20000 | TCP | DNP3 | SCADA sistemleri |

## Media Streaming

| Port | Protokol | Servis | Kullanım |
|------|----------|---------|-----------|
| 554 | TCP/UDP | RTSP | Streaming protokolü |
| 1755 | TCP | MMS | Windows Media |
| 8554 | TCP | RTSP Alt | Alternatif RTSP |
| 10554 | TCP | RTSP | Özel streaming |

## Diğer Servisler

| Port | Protokol | Servis | Kullanım |
|------|----------|---------|-----------|
| 111 | TCP/UDP | RPC | Remote Procedure Call |
| 135 | TCP | RPC | Windows servisleri |
| 179 | TCP | BGP | Routing protokolü |
| 427 | TCP/UDP | SLP | Service Location |
| 548 | TCP | AFP | Apple dosya paylaşımı |
| 631 | TCP | IPP | Internet yazıcı protokolü |
| 1433 | TCP | MSSQL | SQL Server |
| 1521 | TCP | Oracle | Oracle veritabanı |
| 2049 | TCP/UDP | NFS | Network dosya sistemi |
| 3306 | TCP | MySQL | MySQL veritabanı |
| 5432 | TCP | PostgreSQL | PostgreSQL veritabanı |
| 5900+ | TCP | VNC | Uzak masaüstü |
| 8140 | TCP | Puppet | Yapılandırma yönetimi |

## Yazılım Geliştirme ve CI/CD

| Port | Protokol | Platform | Kullanım |
|------|----------|----------|-----------|
| 8080 | TCP | Jenkins | CI/CD pipeline |
| 9000 | TCP | SonarQube | Kod kalite analizi |
| 9418 | TCP | Git | Git daemon |
| 9999 | TCP | Jenkins Agent | Jenkins worker |

## Güvenlik Uyarıları:
1. Kullanılmayan portları kapatın
2. Varsayılan port numaralarını değiştirin
3. Güvenlik duvarı kurallarını düzenli kontrol edin
4. Hassas portları sadece güvenli ağlardan erişime açın
5. Port taramalarını düzenli yapın
6. SSL/TLS kullanan versiyonları tercih edin
7. Rate limiting uygulayın
8. Log kayıtlarını düzenli kontrol edin
