# Unix/Linux Ağ Yönetimi Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Servis Yönetimi](Q06_service_management.tr.md) | [Sonraki: Shell Scripting →](Q08_shell_scripting.tr.md)

## İçindekiler
1. [Temel Ağ Kavramları](#temel-ağ-kavramları)
2. [Ağ Yapılandırması](#ağ-yapılandırması)
3. [Ağ İzleme ve Test](#ağ-izleme-ve-test)
4. [Güvenlik Duvarı](#güvenlik-duvarı)
5. [SSH Yönetimi](#ssh-yönetimi)
6. [Ödevler](#ödevler)
7. [Kaynaklar](#kaynaklar)

## Temel Ağ Kavramları

### Ağ Arayüzleri
- **eth0/ens33**: Ethernet arayüzü
- **wlan0**: Kablosuz arayüz
- **lo**: Loopback arayüzü

### Temel Kavramlar
- IP Adresi
- Alt Ağ Maskesi
- Ağ Geçidi
- DNS Sunucuları
- MAC Adresi

## Ağ Yapılandırması

### IP Yapılandırması
```bash
# IP Bilgilerini Görüntüleme
ip addr show
ifconfig    # eski komut

# IP Atama
sudo ip addr add 192.168.1.100/24 dev eth0
sudo ip addr del 192.168.1.100/24 dev eth0

# Arayüz Açma/Kapama
sudo ip link set eth0 up
sudo ip link set eth0 down
```

### NetworkManager CLI
```bash
# Bağlantıları Listele
nmcli connection show

# WiFi Ağlarını Tara
nmcli device wifi list

# WiFi'ya Bağlan
nmcli device wifi connect "Ağ-Adı" password "şifre"

# Yeni Bağlantı Oluştur
nmcli connection add type ethernet con-name "Ev" ifname eth0
```

### Netplan (Ubuntu)
```yaml
# /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
```

```bash
# Yapılandırmayı Uygula
sudo netplan apply
```

## Ağ İzleme ve Test

### ping
```bash
# Basit Ping
ping google.com

# Belirli Sayıda Ping
ping -c 4 google.com

# Interval ile Ping
ping -i 2 google.com
```

### traceroute
```bash
# Rota Takibi
traceroute google.com

# TCP Traceroute
traceroute -T google.com

# UDP Traceroute
traceroute -U google.com
```

### netstat/ss
```bash
# Açık Portlar
ss -tuln
netstat -tuln

# Bağlantıları Göster
ss -ta
netstat -ta

# Soket İstatistikleri
ss -s
netstat -s
```

### tcpdump
```bash
# Temel Paket Yakalama
sudo tcpdump -i eth0

# HTTP Trafiği
sudo tcpdump -i eth0 port 80

# Dosyaya Kaydet
sudo tcpdump -i eth0 -w kayit.pcap

# Dosyadan Oku
tcpdump -r kayit.pcap
```

## Güvenlik Duvarı

### ufw (Uncomplicated Firewall)
```bash
# UFW Durumu
sudo ufw status

# UFW Etkinleştir/Devre Dışı
sudo ufw enable
sudo ufw disable

# Kural Ekleme
sudo ufw allow 22
sudo ufw deny 23
sudo ufw allow 80/tcp
sudo ufw allow from 192.168.1.0/24

# Kural Silme
sudo ufw delete allow 80

# Varsayılan Politika
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### iptables
```bash
# Kuralları Listele
sudo iptables -L

# Yeni Kural
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Kural Silme
sudo iptables -D INPUT 1

# Zincir Politikası
sudo iptables -P INPUT DROP

# Kuralları Kaydet
sudo iptables-save > /etc/iptables.rules

# Kuralları Geri Yükle
sudo iptables-restore < /etc/iptables.rules
```

## SSH Yönetimi

### SSH Bağlantısı
```bash
# Temel Bağlantı
ssh kullanici@sunucu

# Port Belirterek
ssh -p 2222 kullanici@sunucu

# Anahtar ile Bağlantı
ssh -i ~/.ssh/anahtar kullanici@sunucu

# X11 Forwarding
ssh -X kullanici@sunucu
```

### SSH Anahtar Yönetimi
```bash
# Anahtar Oluşturma
ssh-keygen -t rsa -b 4096

# Anahtarı Sunucuya Kopyalama
ssh-copy-id kullanici@sunucu

# Anahtarı Listeleme
ssh-add -l

# Anahtarı Ekleme
ssh-add ~/.ssh/anahtar
```

### SSH Yapılandırma
```bash
# ~/.ssh/config
Host sunucu
    HostName 192.168.1.100
    User kullanici
    Port 22
    IdentityFile ~/.ssh/anahtar
```

## Ödevler

### Başlangıç Seviyesi
1. Ağ yapılandırması:
```bash
# Mevcut ağ durumunu analiz et
ip addr
ip route
cat /etc/resolv.conf
```

2. Temel ağ testleri:
```bash
# Çeşitli hedeflere ping at
ping -c 4 google.com
ping -c 4 192.168.1.1
```

### Orta Seviye
1. Güvenlik duvarı yapılandırması:
```bash
# UFW ile temel güvenlik duvarı
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow http
sudo ufw enable
```

2. SSH anahtar yönetimi:
```bash
# SSH anahtarı oluştur ve yapılandır
ssh-keygen
ssh-copy-id kullanici@sunucu
```

### İleri Seviye
1. Ağ izleme scripti yaz:
```bash
# Ağ trafiğini izleyen script
```

2. Otomatik güvenlik duvarı yapılandırması:
```bash
# Güvenlik duvarı kurallarını otomatik yapılandıran script
```

## Kaynaklar

### Man Sayfaları
```bash
man ip
man nmcli
man ufw
man ssh
```

### Çevrimiçi Kaynaklar
1. [Linux Networking Guide](https://wiki.linuxfoundation.org/networking/start)
2. [UFW Guide](https://help.ubuntu.com/community/UFW)
3. [SSH Documentation](https://www.ssh.com/ssh/)

### Hızlı Başvuru Tablosu

| Komut | İşlev | Örnek |
|-------|-------|--------|
| ip addr | IP yapılandırması | ip addr show |
| ping | Bağlantı testi | ping google.com |
| traceroute | Rota takibi | traceroute google.com |
| ss | Soket durumu | ss -tuln |
| ufw | Güvenlik duvarı | ufw allow 22 |
| ssh | Uzak bağlantı | ssh user@host |

### Önemli Dosyalar

| Dosya | Açıklama | Konum |
|-------|-----------|--------|
| interfaces | Ağ yapılandırması | /etc/network/interfaces |
| hosts | Host tanımları | /etc/hosts |
| resolv.conf | DNS yapılandırması | /etc/resolv.conf |
| sshd_config | SSH sunucu ayarları | /etc/ssh/sshd_config |

[← Önceki: Servis Yönetimi](Q06_service_management.tr.md) | [Sonraki: Shell Scripting →](Q08_shell_scripting.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
