


```python
import os
import subprocess

def sh_dosyalarini_listele(dizin='scripts'):
    """
    Belirtilen dizindeki tüm .sh dosyalarını listeler.
    
    :param dizin: Aranacak dizin (varsayılan 'scripts')
    :return: .sh dosya adlarının listesi
    """
    sh_dosyalari = []
    for dosya in os.listdir(dizin):
        if dosya.endswith('.sh'):
            sh_dosyalari.append(dosya)
    return sh_dosyalari

def sh_betiği_çalıştır(betik_yolu):
    """
    Python kullanarak bir shell betiğini çalıştırır.
    
    :param betik_yolu: Shell betiğinin yolu
    :return: Betik çalıştırmanın çıktısı
    """
    sonuç = subprocess.run(['sh', betik_yolu], capture_output=True, text=True)
    return sonuç.stdout

def bash_komutu_çalıştır(komut):
    """
    Python kullanarak bir bash komutunu çalıştırır.
    
    :param komut: Çalıştırılacak bash komutu
    :return: Komut çalıştırmanın çıktısı
    """
    sonuç = subprocess.run(komut, shell=True, capture_output=True, text=True)
    return sonuç.stdout

```

İşte istediğiniz fonksiyonların Türkçe açıklamalarla birlikte uygulaması:

1. `sh_dosyalarini_listele(dizin='scripts')`: Bu fonksiyon, belirtilen dizindeki (varsayılan olarak 'scripts') tüm .sh dosyalarını listeler.

2. `sh_betiği_çalıştır(betik_yolu)`: Bu fonksiyon, Python'ın subprocess modülünü kullanarak bir shell betiğini çalıştırır.

3. `bash_komutu_çalıştır(komut)`: Bu fonksiyon, Python'ın subprocess modülünü kullanarak bir bash komutunu çalıştırır.





Tabii, UFW komutlarını daha detaylı açıklayabilirim. Her bir komut için daha fazla ayrıntı ve kullanım senaryoları sunacağım:

# UFW (Uncomplicated Firewall) Detaylı Komut Kılavuzu

## 1. UFW'yi Yönetme

### UFW'yi Etkinleştirme:
```bash
sudo ufw enable
```
Bu komut, UFW'yi etkinleştirir ve sistem başlangıcında otomatik olarak başlatılmasını sağlar.

### UFW'yi Devre Dışı Bırakma:
```bash
sudo ufw disable
```
Bu, UFW'yi devre dışı bırakır ve tüm kuralları geçici olarak kaldırır.

### UFW Durumunu Kontrol Etme:
```bash
sudo ufw status
```
Mevcut kuralları ve UFW'nin genel durumunu gösterir.

```bash
sudo ufw status verbose
```
Daha detaylı bilgi sunar, varsayılan politikaları da içerir.

```bash
sudo ufw status numbered
```
Kuralları numaralandırılmış şekilde gösterir, silme işlemleri için kullanışlıdır.

## 2. Varsayılan Politikaları Ayarlama

### Gelen Trafiği Reddetme:
```bash
sudo ufw default deny incoming
```
Özel olarak izin verilmeyen tüm gelen bağlantıları reddeder.

### Giden Trafiği İzin Verme:
```bash
sudo ufw default allow outgoing
```
Tüm giden bağlantılara izin verir.

## 3. Port ve Protokol Bazlı Kurallar

### Belirli Bir Porta İzin Verme:
```bash
sudo ufw allow 22/tcp
```
22 numaralı TCP portuna (SSH) gelen bağlantılara izin verir.

### Belirli Bir Portu Reddetme:
```bash
sudo ufw deny 80/tcp
```
80 numaralı TCP portuna (HTTP) gelen bağlantıları reddeder.

### Port Aralığına İzin Verme:
```bash
sudo ufw allow 6000:6007/tcp
```
6000 ile 6007 arasındaki TCP portlarına izin verir.

### Servis İsmine Göre İzin Verme:
```bash
sudo ufw allow ssh
```
SSH servisine (varsayılan olarak 22/tcp) izin verir.

## 4. IP ve Subnet Bazlı Kurallar

### Belirli Bir IP'ye İzin Verme:
```bash
sudo ufw allow from 192.168.1.100
```
192.168.1.100 IP adresinden gelen tüm bağlantılara izin verir.

### Belirli Bir IP'yi Reddetme:
```bash
sudo ufw deny from 10.0.0.5
```
10.0.0.5 IP adresinden gelen tüm bağlantıları reddeder.

### Subnet'e İzin Verme:
```bash
sudo ufw allow from 192.168.1.0/24
```
192.168.1.0/24 subnet'inden gelen tüm bağlantılara izin verir.

## 5. Kombine Kurallar

### IP ve Port Kombinasyonu:
```bash
sudo ufw allow from 192.168.1.100 to any port 22
```
192.168.1.100 IP adresinden 22 numaralı porta gelen bağlantılara izin verir.

### Belirli Bir Arayüze Kural Uygulama:
```bash
sudo ufw allow in on eth0 to any port 80
```
eth0 arayüzünden 80 numaralı porta gelen bağlantılara izin verir.

## 6. Kural Yönetimi

### Numaraya Göre Kural Silme:
```bash
sudo ufw delete 2
```
2 numaralı kuralı siler (önce `sudo ufw status numbered` ile kuralları listeleyin).

### Kurala Göre Silme:
```bash
sudo ufw delete allow 80/tcp
```
80/tcp portuna izin veren kuralı siler.

### Tüm Kuralları Sıfırlama:
```bash
sudo ufw reset
```
Tüm kuralları sıfırlar ve UFW'yi varsayılan ayarlarına döndürür.

## 7. Loglama

### Loglamayı Etkinleştirme:
```bash
sudo ufw logging on
```
UFW loglamasını etkinleştirir.

### Loglama Seviyesini Ayarlama:
```bash
sudo ufw logging medium
```
Loglama seviyesini orta düzeye ayarlar (low, medium, high, full seçenekleri mevcuttur).

Bu detaylı açıklamalar, UFW'nin temel ve orta düzey kullanımını kapsar. Her bir komutun nasıl çalıştığını ve hangi durumlarda kullanılabileceğini anlamanıza yardımcı olacaktır.


size gerçekçi bir senaryo örneği verebilirim. Bu senaryoda, bir web sunucusu kurup güvenliğini UFW ile sağlamaya çalışacağız.

Senaryo: Küçük bir işletme için web sunucusu kurma

Diyelim ki küçük bir işletme için Ubuntu 22.04 LTS üzerinde bir web sunucusu kuruyorsunuz. Bu sunucu şunları barındıracak:
1. Bir web sitesi (HTTP ve HTTPS)
2. Bir SSH sunucusu (uzaktan yönetim için)
3. Bir FTP sunucusu (dosya transferleri için)

Ayrıca, şirket ağınızdan (192.168.1.0/24) gelen tüm trafiğe izin vermek ve sadece belirli bir IP adresinden (203.0.113.10) SSH bağlantısına izin vermek istiyorsunuz.

İşte bu senaryoyu gerçekleştirmek için kullanabileceğiniz UFW komutları ve açıklamaları:

```bash
# UFW'yi etkinleştir
sudo ufw enable

# Varsayılan olarak gelen trafiği reddet, giden trafiğe izin ver
sudo ufw default deny incoming
sudo ufw default allow outgoing

# SSH için sadece belirli bir IP'ye izin ver
sudo ufw allow from 203.0.113.10 to any port 22

# HTTP ve HTTPS trafiğine izin ver
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# FTP trafiğine izin ver
sudo ufw allow 21/tcp

# Şirket ağından gelen tüm trafiğe izin ver
sudo ufw allow from 192.168.1.0/24

# Kuralları kontrol et
sudo ufw status verbose
```

Bu komutların açıklaması:

1. İlk olarak UFW'yi etkinleştiriyoruz.
2. Varsayılan politikayı, gelen tüm trafiği reddetmek ve giden tüm trafiğe izin vermek olarak ayarlıyoruz.
3. SSH için sadece belirli bir IP adresinden (203.0.113.10) gelen bağlantılara izin veriyoruz. Bu, SSH erişimini sınırlandırarak güvenliği artırır.
4. Web sunucusu için 80 (HTTP) ve 443 (HTTPS) portlarına izin veriyoruz.
5. FTP sunucusu için 21 numaralı porta izin veriyoruz.
6. Şirket ağından (192.168.1.0/24 subnet'i) gelen tüm trafiğe izin veriyoruz. Bu, iç ağdan sunucuya tam erişim sağlar.
7. Son olarak, oluşturulan kuralları kontrol ediyoruz.

Bu konfigürasyon:
- Web sitenize internet üzerinden erişime izin verir.
- FTP erişimini sağlar.
- SSH erişimini sadece güvenilir bir IP ile sınırlar.
- Şirket ağından gelen tüm trafiğe izin verir.
- Diğer tüm gelen bağlantıları reddeder.

Bu temel bir konfigürasyondur ve gerçek dünya senaryolarında ek güvenlik önlemleri (örneğin, rate limiting, daha spesifik port kısıtlamaları) gerekebilir. Ayrıca, FTP yerine daha güvenli olan SFTP kullanmak da düşünülebilir.
