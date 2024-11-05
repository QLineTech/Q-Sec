Linux sistemlerinde yaygın olarak kullanılan portları ve bunların UFW komutlarını listeleyeceğim:

# Yaygın Sistem Portları

### FTP İlişkili
- **Port 20** (FTP-Data)
  - Kullanım: FTP veri transferi
  - UFW Komutu: `sudo ufw allow 20/tcp`

- **Port 21** (FTP-Control)
  - Kullanım: FTP kontrol bağlantısı
  - UFW Komutu: `sudo ufw allow 21/tcp`

### SSH ve Telnet
- **Port 22** (SSH)
  - Kullanım: Güvenli uzak bağlantı
  - UFW Komutu: `sudo ufw allow 22/tcp`

- **Port 23** (Telnet)
  - Kullanım: Uzak terminal bağlantısı (güvensiz)
  - UFW Komutu: `sudo ufw allow 23/tcp`

### Mail Servisleri
- **Port 25** (SMTP)
  - Kullanım: Mail gönderimi
  - UFW Komutu: `sudo ufw allow 25/tcp`

- **Port 110** (POP3)
  - Kullanım: Mail alımı
  - UFW Komutu: `sudo ufw allow 110/tcp`

- **Port 143** (IMAP)
  - Kullanım: Mail yönetimi
  - UFW Komutu: `sudo ufw allow 143/tcp`

- **Port 587** (SMTP-TLS)
  - Kullanım: Güvenli mail gönderimi
  - UFW Komutu: `sudo ufw allow 587/tcp`

### Web Servisleri
- **Port 80** (HTTP)
  - Kullanım: Web sayfası erişimi
  - UFW Komutu: `sudo ufw allow 80/tcp`

- **Port 443** (HTTPS)
  - Kullanım: Güvenli web sayfası erişimi
  - UFW Komutu: `sudo ufw allow 443/tcp`

### Veritabanı Servisleri
- **Port 3306** (MySQL/MariaDB)
  - Kullanım: MySQL veritabanı bağlantısı
  - UFW Komutu: `sudo ufw allow 3306/tcp`

- **Port 5432** (PostgreSQL)
  - Kullanım: PostgreSQL veritabanı bağlantısı
  - UFW Komutu: `sudo ufw allow 5432/tcp`

### Dosya Paylaşımı
- **Port 137-139** (Samba/NetBIOS)
  - Kullanım: Windows ağ paylaşımı
  - UFW Komutu: 
    ```bash
    sudo ufw allow 137/tcp
    sudo ufw allow 138/tcp
    sudo ufw allow 139/tcp
    ```

- **Port 445** (SMB)
  - Kullanım: Dosya paylaşımı
  - UFW Komutu: `sudo ufw allow 445/tcp`

### DNS Servisi
- **Port 53** (DNS)
  - Kullanım: Alan adı çözümleme
  - UFW Komutu: 
    ```bash
    sudo ufw allow 53/tcp
    sudo ufw allow 53/udp
    ```

### Uzak Masaüstü
- **Port 3389** (RDP)
  - Kullanım: Uzak masaüstü bağlantısı
  - UFW Komutu: `sudo ufw allow 3389/tcp`

### Proxy Servisleri
- **Port 8080** (HTTP Proxy)
  - Kullanım: Proxy sunucusu
  - UFW Komutu: `sudo ufw allow 8080/tcp`

### Yararlı UFW Komutları
```bash
# UFW'yi etkinleştirme
sudo ufw enable

# UFW durumunu kontrol etme
sudo ufw status verbose

# Tüm kuralları silme
sudo ufw reset

# Belirli bir IP'ye izin verme
sudo ufw allow from 192.168.1.100

# Belirli bir port aralığına izin verme
sudo ufw allow 6000:6007/tcp

# Belirli bir servisi engelleme
sudo ufw deny http

# Kuralları numaralı gösterme
sudo ufw status numbered

# Belirli bir kuralı silme
sudo ufw delete [kural_numarası]
```

Not: Port açarken güvenlik risklerini göz önünde bulundurmanız önemlidir. Sadece gerçekten ihtiyaç duyduğunuz portları açmanız önerilir.





Size 100'den fazla port ve kullanımlarını listeleyeceğim. Liste uzun olacağı için kategorilere ayırarak sunacağım.

# Sistem ve Ağ Portları (1-1023)

### Temel Sistem Portları (1-99)
- **Port 1** (tcpmux)
  - TCP port servis çoğullayıcı
  - `sudo ufw allow 1/tcp`

- **Port 7** (Echo)
  - Echo protokolü
  - `sudo ufw allow 7/tcp`

- **Port 9** (Discard)
  - Null servisi
  - `sudo ufw allow 9/tcp`

- **Port 11** (Systat)
  - Sistem istatistikleri
  - `sudo ufw allow 11/tcp`

- **Port 13** (Daytime)
  - Tarih ve saat bilgisi
  - `sudo ufw allow 13/tcp`

- **Port 17** (QOTD)
  - Günün sözü servisi
  - `sudo ufw allow 17/tcp`

- **Port 18** (MSP)
  - Message Send Protocol
  - `sudo ufw allow 18/tcp`

- **Port 19** (CHARGEN)
  - Karakter üreteci
  - `sudo ufw allow 19/tcp`

- **Port 20** (FTP-Data)
  - FTP veri transferi
  - `sudo ufw allow 20/tcp`

- **Port 21** (FTP-Control)
  - FTP kontrol
  - `sudo ufw allow 21/tcp`

- **Port 22** (SSH)
  - Güvenli kabuk
  - `sudo ufw allow 22/tcp`

- **Port 23** (Telnet)
  - Terminal emülasyonu
  - `sudo ufw allow 23/tcp`

- **Port 25** (SMTP)
  - Mail transferi
  - `sudo ufw allow 25/tcp`

- **Port 37** (Time)
  - Zaman protokolü
  - `sudo ufw allow 37/tcp`

- **Port 39** (RLP)
  - Resource Location Protocol
  - `sudo ufw allow 39/tcp`

- **Port 42** (WINS)
  - Host Name Server
  - `sudo ufw allow 42/tcp`

- **Port 43** (WHOIS)
  - WHOIS protokolü
  - `sudo ufw allow 43/tcp`

- **Port 49** (TACACS)
  - Login Host Protocol
  - `sudo ufw allow 49/tcp`

- **Port 50** (RE-MAIL-CK)
  - Remote Mail Checking
  - `sudo ufw allow 50/tcp`

- **Port 53** (DNS)
  - Domain Name System
  - `sudo ufw allow 53/{tcp,udp}`

### Mail ve Mesajlaşma Portları (100-200)
- **Port 101** (HOSTNAME)
  - NIC Host Name
  - `sudo ufw allow 101/tcp`

- **Port 102** (ISO-TSAP)
  - ISO TSAP Class 0
  - `sudo ufw allow 102/tcp`

- **Port 105** (CSNET-NS)
  - Mailbox Name Server
  - `sudo ufw allow 105/tcp`

- **Port 107** (RTelnet)
  - Remote Telnet
  - `sudo ufw allow 107/tcp`

- **Port 109** (POP2)
  - Post Office Protocol v2
  - `sudo ufw allow 109/tcp`

- **Port 110** (POP3)
  - Post Office Protocol v3
  - `sudo ufw allow 110/tcp`

- **Port 111** (RPCbind)
  - RPC Port Mapper
  - `sudo ufw allow 111/{tcp,udp}`

- **Port 113** (IDENT)
  - Authentication Service
  - `sudo ufw allow 113/tcp`

- **Port 115** (SFTP)
  - Simple File Transfer Protocol
  - `sudo ufw allow 115/tcp`

### Güvenlik ve Yetkilendirme Portları (200-399)
- **Port 123** (NTP)
  - Network Time Protocol
  - `sudo ufw allow 123/udp`

- **Port 137** (NetBIOS-NS)
  - NetBIOS Name Service
  - `sudo ufw allow 137/{tcp,udp}`

- **Port 138** (NetBIOS-DGM)
  - NetBIOS Datagram Service
  - `sudo ufw allow 138/{tcp,udp}`

- **Port 139** (NetBIOS-SSN)
  - NetBIOS Session Service
  - `sudo ufw allow 139/tcp`

- **Port 143** (IMAP)
  - Internet Message Access Protocol
  - `sudo ufw allow 143/tcp`

- **Port 161** (SNMP)
  - Simple Network Management Protocol
  - `sudo ufw allow 161/udp`

- **Port 162** (SNMPTRAP)
  - SNMP Trap
  - `sudo ufw allow 162/udp`

- **Port 174** (MAILQ)
  - MAILQ protokolü
  - `sudo ufw allow 174/tcp`

- **Port 177** (XDMCP)
  - X Display Manager Control Protocol
  - `sudo ufw allow 177/tcp`

### Web ve Uygulama Portları (400-999)
- **Port 389** (LDAP)
  - Lightweight Directory Access Protocol
  - `sudo ufw allow 389/tcp`

- **Port 443** (HTTPS)
  - HTTP Secure
  - `sudo ufw allow 443/tcp`

- **Port 445** (Microsoft-DS)
  - Active Directory
  - `sudo ufw allow 445/tcp`

- **Port 465** (SMTPS)
  - SMTP over SSL
  - `sudo ufw allow 465/tcp`

- **Port 500** (ISAKMP)
  - Internet Security Association and Key Management Protocol
  - `sudo ufw allow 500/udp`

- **Port 512** (exec)
  - Remote Process Execution
  - `sudo ufw allow 512/tcp`

- **Port 513** (login)
  - Remote Login
  - `sudo ufw allow 513/tcp`

- **Port 514** (shell)
  - Remote Shell
  - `sudo ufw allow 514/tcp`

- **Port 515** (printer)
  - Line Printer Daemon
  - `sudo ufw allow 515/tcp`

- **Port 520** (RIP)
  - Routing Information Protocol
  - `sudo ufw allow 520/udp`

- **Port 521** (RIPng)
  - RIP Next Generation
  - `sudo ufw allow 521/udp`

- **Port 540** (UUCP)
  - Unix-to-Unix Copy
  - `sudo ufw allow 540/tcp`

### Veritabanı ve Uygulama Portları (1000-9999)
- **Port 1080** (SOCKS)
  - SOCKS Proxy
  - `sudo ufw allow 1080/tcp`

- **Port 1194** (OpenVPN)
  - OpenVPN
  - `sudo ufw allow 1194/{tcp,udp}`

- **Port 1433** (MS-SQL-S)
  - Microsoft SQL Server
  - `sudo ufw allow 1433/tcp`

- **Port 1434** (MS-SQL-M)
  - Microsoft SQL Monitor
  - `sudo ufw allow 1434/tcp`

- **Port 1521** (Oracle)
  - Oracle Database
  - `sudo ufw allow 1521/tcp`

- **Port 1701** (L2TP)
  - Layer 2 Tunneling Protocol
  - `sudo ufw allow 1701/udp`

- **Port 1723** (PPTP)
  - Point-to-Point Tunneling Protocol
  - `sudo ufw allow 1723/tcp`

- **Port 1812** (RADIUS)
  - Authentication
  - `sudo ufw allow 1812/{tcp,udp}`

- **Port 1813** (RADIUS)
  - Accounting
  - `sudo ufw allow 1813/{tcp,udp}`

- **Port 2049** (NFS)
  - Network File System
  - `sudo ufw allow 2049/{tcp,udp}`

- **Port 2082** (cPanel)
  - cPanel default
  - `sudo ufw allow 2082/tcp`

- **Port 2083** (cPanel SSL)
  - cPanel SSL
  - `sudo ufw allow 2083/tcp`

- **Port 2086** (WHM)
  - WebHost Manager
  - `sudo ufw allow 2086/tcp`

- **Port 2087** (WHM SSL)
  - WHM SSL
  - `sudo ufw allow 2087/tcp`

### Yüksek Portlar (10000+)
- **Port 3128** (Squid)
  - Proxy sunucusu
  - `sudo ufw allow 3128/tcp`

- **Port 3306** (MySQL)
  - MySQL Database
  - `sudo ufw allow 3306/tcp`

- **Port 3389** (RDP)
  - Remote Desktop Protocol
  - `sudo ufw allow 3389/tcp`

- **Port 5432** (PostgreSQL)
  - PostgreSQL Database
  - `sudo ufw allow 5432/tcp`

- **Port 5900** (VNC)
  - Virtual Network Computing
  - `sudo ufw allow 5900/tcp`

- **Port 6379** (Redis)
  - Redis Database
  - `sudo ufw allow 6379/tcp`

- **Port 8080** (HTTP-ALT)
  - Alternative HTTP
  - `sudo ufw allow 8080/tcp`

- **Port 8443** (HTTPS-ALT)
  - Alternative HTTPS
  - `sudo ufw allow 8443/tcp`

- **Port 9000** (PHP-FPM)
  - PHP FastCGI Process Manager
  - `sudo ufw allow 9000/tcp`

- **Port 9090** (Webmin)
  - Webmin Control Panel
  - `sudo ufw allow 9090/tcp`

- **Port 10000** (Webmin-SSL)
  - Webmin SSL
  - `sudo ufw allow 10000/tcp`

### Oyun Sunucusu Portları
- **Port 25565** (Minecraft)
  - Minecraft Server
  - `sudo ufw allow 25565/tcp`

- **Port 27015** (Source)
  - Source Engine Games (CS:GO, etc.)
  - `sudo ufw allow 27015/{tcp,udp}`

- **Port 27017** (MongoDB)
  - MongoDB Database
  - `sudo ufw allow 27017/tcp`

### Özel Servis Portları
- **Port 32400** (Plex)
  - Plex Media Server
  - `sudo ufw allow 32400/tcp`

- **Port 49152-65535** (Dinamik Portlar)
  - Geçici/Dinamik portlar
  - `sudo ufw allow 49152:65535/tcp`

### Güvenli Mesajlaşma ve Mail Portları
- **Port 993** (IMAPS)
  - IMAP over SSL
  - `sudo ufw allow 993/tcp`

- **Port 995** (POP3S)
  - POP3 over SSL
  - `sudo ufw allow 995/tcp`

### Medya Streaming Portları
- **Port 554** (RTSP)
  - Real Time Streaming Protocol
  - `sudo ufw allow 554/{tcp,udp}`

- **Port 1935** (RTMP)
  - Real Time Messaging Protocol
  - `sudo ufw allow 1935/tcp`

### Önemli UFW Komutları
```bash
# Tüm aktif kuralları görüntüleme
sudo ufw status verbose

# Belirli bir portu kapatma
sudo ufw deny [port]/[protocol]

# Port aralığı açma
sudo ufw allow [start_port]:[end_port]/[protocol]

# Özel IP adreslerine izin verme
sudo ufw allow from [ip_address] to any port [port_number]

# Servis bazlı kural ekleme
sudo ufw allow [service_name]

# Kuralları numaralandırılmış görüntüleme
sudo ufw status numbered

# Belirli bir kuralı silme
sudo ufw delete [rule_number]

# UFW'yi sıfırlama
sudo ufw reset
```

Not: 
1. Her portu açmadan önce güvenlik risklerini değerlendirin
2. Sadece kullandığınız servislerin portlarını açın
3. Düzenli olarak açık portları kontrol edin
4. Gerekli olmayan portları kapatın
5. Mümkünse port yönlendirmede rate limiting uygulayın

Bu liste en yaygın kullanılan portları içermektedir. Bazı özel uygulamalar veya servisler farklı portlar kullanabilir.
