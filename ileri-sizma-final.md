# İleri Sızma Testi Projeleri

## Proje Şablonu

### Temel Bilgiler
- Proje Adı:
- Öğrenci Adı ve Numarası:
- Teslim Tarihi:

### Teknik Dokümentasyon

#### Proje Tanımı
- Projenin amacı ve kapsamı
- Çözülen güvenlik problemi
- Hedef kitle ve kullanım alanları

#### Teknik Gereksinimler
- Kullanılan programlama dili
- Gerekli kütüphaneler ve sürümleri
- Çalışma ortamı gereksinimleri

#### Parametre Yapısı
**Zorunlu Parametreler:**
```json
{
    "parametre_adi": {
        "tip": "veri_tipi",
        "açıklama": "parametre açıklaması"
    }
}
```

**Opsiyonel Parametreler:**
```json
{
    "parametre_adi": {
        "tip": "veri_tipi",
        "varsayılan": "değer",
        "açıklama": "parametre açıklaması"
    }
}
```

#### Çıktı Formatı
```json
{
    "sonuç": {
        "durum": "başarılı/başarısız",
        "veri": {},
        "hata_mesajı": "varsa hata açıklaması"
    }
}
```

## Proje Konuları ve Açıklamaları

### 1. Keşif (Reconnaissance) Projeleri

#### 1. Subdomain Keşif Aracı
**Açıklama:** Hedef domain için kapsamlı bir subdomain tarama aracı geliştirilmesi. Pasif ve aktif tarama yöntemlerini birleştiren, DNS kayıtlarını analiz eden ve wildcard DNS yapılandırmalarını tespit eden bir sistem.

**Temel Özellikler:**
- Çeşitli DNS sunucularını kullanarak paralel sorgulama
- Sertifika şeffaflık loglarından subdomain çıkarımı
- Brute force ve permütasyon tabanlı tarama
- Sonuçların doğrulanması ve erişilebilirlik kontrolü

#### 2. DNS Kayıt Analiz Sistemi
**Açıklama:** Bir domain'in tüm DNS kayıt tiplerini analiz eden, geçmiş değişiklikleri takip eden ve güvenlik açısından kritik kayıtları tespit eden bir araç.

**Temel Özellikler:**
- A, AAAA, MX, TXT, NS, CNAME kayıtlarının analizi
- Zone transfer açıklıklarının tespiti
- DNS geçmişi ve değişiklik takibi
- SPF, DMARC ve DKIM kayıtlarının güvenlik analizi

#### 3. MAC Vendor Analiz Sistemi
**Açıklama:** Ağdaki cihazların MAC adreslerini analiz ederek üretici bilgilerini çıkaran, cihaz kategorilerini belirleyen ve potansiyel güvenlik risklerini tespit eden bir sistem.

**Temel Özellikler:**
- Güncel MAC vendor veritabanı yönetimi
- Cihaz kategorizasyonu (IoT, ağ ekipmanı, son kullanıcı vb.)
- Sahte MAC adresi tespiti
- Vendor bazlı güvenlik riski değerlendirmesi

#### 4. IP Intelligence Toplayıcı
**Açıklama:** IP adresleri hakkında kapsamlı bilgi toplayan, risk değerlendirmesi yapan ve tehdit istihbaratı sağlayan bir araç.

**Temel Özellikler:**
- WHOIS bilgisi toplama ve analiz
- Geolokasyon tespiti ve haritalama
- IP reputation kontrolü ve risk skorlaması
- ASN ve rota analizi

#### 5. Nmap Veritabanı Analizi
**Açıklama:** Nmap tarama sonuçlarını derinlemesine analiz eden, servis ve versiyon tespiti yapan, zafiyet eşleştirmesi gerçekleştiren bir sistem.

**Temel Özellikler:**
- Servis parmak izi analizi
- Versiyon bazlı zafiyet eşleştirme
- NSE script sonuçlarının kategorizasyonu
- Özelleştirilmiş tarama profilleri oluşturma

#### 6. SSL/TLS Analiz Aracı
**Açıklama:** SSL/TLS yapılandırmalarını analiz eden, güvenlik açıklıklarını tespit eden ve sertifika zincirini kontrol eden bir araç.

**Temel Özellikler:**
- Sertifika zinciri validasyonu
- Protokol ve cipher suite analizi
- Bilinen SSL/TLS zafiyetlerinin tespiti
- Yapılandırma önerileri sunma

### 2. Zafiyet Tarama Projeleri

#### 7. Web Teknoloji Parmak İzi Çıkarma
**Açıklama:** Web uygulamalarında kullanılan teknolojileri tespit eden, sürüm bilgilerini çıkaran ve olası güvenlik açıklıklarını belirleyen bir sistem.

**Temel Özellikler:**
- HTTP header analizi
- JavaScript kütüphane tespiti
- CMS ve framework sürüm tespiti
- Teknoloji stack güvenlik değerlendirmesi

#### 8. Port Knock Sequence Detector
**Açıklama:** Port knocking yapılandırmalarını tespit eden, sequence analizi yapan ve bypass yöntemlerini test eden bir araç.

**Temel Özellikler:**
- Knock sequence tespiti
- Pattern analizi ve optimizasyonu
- Bypass tekniklerinin test edilmesi
- Güvenlik önerilerinin sunulması

#### 9. OSINT Veri Toplayıcı
**Açıklama:** Açık kaynaklardan hedef hakkında bilgi toplayan, veri korelasyonu yapan ve risk değerlendirmesi sunan kapsamlı bir sistem.

**Temel Özellikler:**
- Sosyal medya taraması ve analizi
- Email harvesting ve validasyon
- Metadata analizi ve dökümü
- Veri görselleştirme ve raporlama

#### 10. Kablosuz Ağ Analiz Aracı
**Açıklama:** Kablosuz ağları analiz eden, güvenlik yapılandırmalarını kontrol eden ve potansiyel saldırıları tespit eden bir sistem.

**Temel Özellikler:**
- Beacon frame analizi
- Client probe request analizi
- Sinyal gücü haritalama
- Evil twin saldırı tespiti

### 3. Exploit Geliştirme Projeleri

#### 11. Özel Zafiyet Tarayıcısı
**Açıklama:** Hedef sistemlerde zafiyet taraması yapan, özel modüller ile genişletilebilen ve detaylı raporlama sunan bir tarayıcı.

**Temel Özellikler:**
- Port tarama ve servis tespiti
- Zafiyet veritabanı yönetimi
- Özelleştirilmiş modül geliştirme
- Risk bazlı raporlama

#### 12. Web Uygulama Crawler
**Açıklama:** Web uygulamalarını otomatik olarak tarayan, fonksiyonalite keşfi yapan ve güvenlik açıklıklarını tespit eden bir crawler.

**Temel Özellikler:**
- Dinamik path keşfi
- Form ve parametre analizi
- JavaScript rendering desteği
- Güvenlik açığı pattern eşleştirme

[Diğer projeler benzer formatta devam edecek...]

### Değerlendirme Kriterleri

1. **Teknik Yeterlilik (40%)**
   - Kodlama standartlarına uygunluk
   - Hata yönetimi
   - Performans optimizasyonu
   - Güvenlik önlemleri

2. **Dokümantasyon (25%)**
   - Kod dokümantasyonu
   - Kullanım kılavuzu
   - API dokümantasyonu
   - Kurulum talimatları

3. **Fonksiyonellik (20%)**
   - Gereksinimlerin karşılanması
   - Kullanılabilirlik
   - Hata toleransı
   - Test sonuçları

4. **Yenilikçilik (15%)**
   - Özgün çözümler
   - İleri teknikler
   - Ekstra özellikler
   - Araştırma derinliği

### Teslim Gereksinimleri

1. **Kaynak Kod**
   - Versiyon kontrol sistemi (Git) üzerinde
   - Düzenli commit geçmişi
   - Branch stratejisi
   - .gitignore dosyası

2. **Dokümantasyon**
   - README.md
   - Teknik dokümantasyon
   - API dokümantasyonu
   - Kurulum talimatları

3. **Test Sonuçları**
   - Birim testler
   - Entegrasyon testleri
   - Güvenlik testleri
   - Performans testleri

4. **Sunum**
   - Proje sunumu
   - Demo video
   - Test senaryoları
   - Örnek kullanım













--------------


# İleri Sızma Testi Proje Kategorileri ve Örnekleri

## Ana Kategoriler

1. Keşif (Reconnaissance)
   - Pasif Keşif
   - Aktif Keşif
   - OSINT
   - Ağ Keşfi

2. Zafiyet Tarama
   - Otomatik Tarama
   - Özel Tarama Araçları
   - Güvenlik Değerlendirmesi
   - Yapılandırma Analizi

3. Exploit Geliştirme
   - Web Uygulamaları
   - Ağ Servisleri
   - Yazılım Güvenliği
   - Kablosuz Sistemler

4. Post-Exploitation
   - Yetki Yükseltme
   - Yanal Hareket
   - Veri Çıkarımı
   - Kalıcılık

5. Savunma Sistemleri
   - IDS/IPS Sistemleri
   - WAF Çözümleri
   - Güvenlik İzleme
   - Tehdit Analizi

6. Özel Güvenlik Araçları
   - Analiz Araçları
   - Güvenlik Testleri
   - Raporlama Sistemleri
   - Otomasyon Araçları

## Proje Listesi (Kategorilere Göre)

### 1. Keşif (Reconnaissance) Projeleri

#### Pasif Keşif
1. Alt Alan Adı Tespit Sistemi
   - DNS kayıtlarından alt alan keşfi
   - Sertifika şeffaflık loglarından subdomain çıkarımı
   - Pasif kaynaklardan bilgi toplama

2. DNS Kayıt Analiz Aracı
   - Tüm DNS kayıt tiplerinin analizi
   - Geçmiş kayıt değişikliklerinin tespiti
   - DNS güvenlik yapılandırması kontrolü

3. WHOIS Veri Madenciliği Aracı
   - Domain kayıt bilgisi analizi
   - Registrar değişiklik takibi
   - İlişkili domain tespiti

4. SSL/TLS Sertifika Analiz Sistemi
   - Sertifika zinciri analizi
   - Güvenlik yapılandırması kontrolü
   - Sertifika geçerliliği takibi

#### Aktif Keşif
5. Port Tarama ve Servis Tespit Aracı
   - Akıllı port tarama
   - Servis versiyon tespiti
   - Zafiyet eşleştirme

6. Banner Grabbing Otomasyonu
   - Servis banner analizi
   - Versiyon bilgisi çıkarımı
   - Güvenlik başlıkları kontrolü

7. Web Teknoloji Analiz Aracı
   - Kullanılan teknolojilerin tespiti
   - Framework ve CMS analizi
   - Versiyon tespit sistemi

#### OSINT
8. Sosyal Medya Keşif Aracı
   - Profil bilgisi toplama
   - İlişki analizi
   - Metadata çıkarımı

9. Email Harvesting Sistemi
   - Email adres toplama
   - Format tespit
   - Geçerlilik kontrolü

10. Dijital Ayak İzi Analiz Aracı
    - Online varlık tespiti
    - Veri sızıntısı kontrolü
    - İtibar analizi

### 2. Zafiyet Tarama Projeleri

#### Web Uygulama Güvenliği
11. SQL Injection Tarama Aracı
    - Otomatik payload üretimi
    - Bypass teknikleri testi
    - Veri çıkarım kontrolleri

12. XSS Tespit Sistemi
    - Context-aware payload üretimi
    - DOM bazlı XSS tespiti
    - Filter bypass teknikleri

13. SSRF Scanner
    - İç ağ keşfi
    - Cloud metadata erişim testi
    - Bypass teknik kontrolleri

#### Ağ Güvenliği
14. Güvenlik Duvarı Analiz Aracı
    - Kural seti analizi
    - Bypass teknik tespiti
    - Yapılandırma kontrolü

15. VPN Güvenlik Tarayıcı
    - Protokol güvenlik analizi
    - Yapılandırma kontrolü
    - Sızıntı tespiti

16. Kablosuz Ağ Güvenlik Tarayıcı
    - WPA/WPA2 güvenlik analizi
    - Evil twin tespiti
    - Rogue AP kontrolü

### 3. Exploit Geliştirme Projeleri

#### Web Exploitleri
17. Authentication Bypass Framework
    - Oturum yönetimi analizi
    - Bypass teknik geliştirme
    - Token manipülasyonu

18. File Upload Exploit Kit
    - Bypass teknik geliştirme
    - Shell yükleme otomasyonu
    - Dosya türü analizi

19. XXE Exploit Generator
    - Payload üretimi
    - Data exfiltration
    - Blind XXE tespiti

#### Binary Exploitation
20. Buffer Overflow Exploit Generator
    - Pattern üretimi
    - ROP chain oluşturma
    - Shellcode entegrasyonu

21. Format String Exploit Kit
    - Zafiyet tespiti
    - Exploit geliştirme
    - Memory manipulation

22. Heap Exploitation Framework
    - Heap spray teknikleri
    - Use-after-free tespiti
    - Memory leak analizi

### 4. Post-Exploitation Projeleri

#### Yetki Yükseltme
23. Linux Privilege Escalation Scanner
    - SUID binary analizi
    - Capability kontrolü
    - Misconfiguration tespiti

24. Windows Privilege Escalation Tool
    - Service analizi
    - Registry kontrolü
    - Token manipulation

25. Container Escape Scanner
    - Container güvenlik analizi
    - Escape vektör tespiti
    - Privilege escalation kontrolü

#### Kalıcılık
26. Persistence Generator
    - Startup entry oluşturma
    - Service manipulation
    - Registry modification

27. Backdoor Generator
    - Custom payload üretimi
    - Anti-detection
    - Command & Control

28. Rootkit Development Kit
    - Kernel module geliştirme
    - Process hiding
    - File system manipulation

### 5. Savunma Sistemleri

#### IDS/IPS
29. Custom IDS Geliştirme
    - Pattern matching
    - Anomali tespiti
    - Alert generation

30. Network IPS Framework
    - Paket analizi
    - Block rule generation
    - False positive reduction

31. Host-based IDS
    - File integrity monitoring
    - Process monitoring
    - Behavioral analysis

#### WAF
32. Custom WAF Geliştirme
    - Request filtering
    - Rule management
    - Learning mode

33. API Gateway Security
    - Rate limiting
    - Input validation
    - Authentication control

34. Bot Protection System
    - Behavior analysis
    - CAPTCHA integration
    - Rate limiting

### 6. Özel Güvenlik Araçları

#### Analiz Araçları
35. Malware Analysis Sandbox
    - Static analysis
    - Dynamic analysis
    - Network behavior monitoring

36. Traffic Analysis Tool
    - Protocol analysis
    - Anomaly detection
    - Data visualization

37. Log Analysis Framework
    - Pattern matching
    - Correlation engine
    - Alert generation

#### Raporlama
38. Automated Pentest Reporter
    - Vulnerability assessment
    - Risk scoring
    - Report generation

39. Security Compliance Checker
    - Policy verification
    - Configuration audit
    - Remediation guidance

40. Security Metrics Dashboard
    - KPI tracking
    - Risk visualization
    - Trend analysis

### 7. IoT Güvenliği

41. IoT Protocol Analyzer
    - MQTT security testing
    - CoAP analysis
    - Zigbee security

42. IoT Firmware Analysis Tool
    - Binary analysis
    - Vulnerability scanning
    - Backdoor detection

43. Smart Device Security Scanner
    - Protocol analysis
    - Default credential testing
    - Vulnerability assessment

### 8. Cloud Güvenliği

44. Cloud Configuration Analyzer
    - S3 bucket security
    - IAM policy review
    - Network security groups

45. Serverless Security Scanner
    - Function security
    - Permission analysis
    - Runtime security

46. Container Security Tool
    - Image scanning
    - Runtime protection
    - Compliance checking

### 9. Mobil Güvenlik

47. Android App Security Scanner
    - Static analysis
    - Dynamic testing
    - Permission analysis

48. iOS Security Assessment Tool
    - Binary analysis
    - Runtime manipulation
    - Security control testing

49. Mobile API Security Tester
    - Authentication testing
    - Authorization checks
    - Data validation

### 10. Kriptografik Güvenlik

50. Crypto Implementation Analyzer
    - Algorithm analysis
    - Key management review
    - Implementation testing

51. SSL/TLS Configuration Checker
    - Protocol testing
    - Cipher suite analysis
    - Certificate validation

52. Hash Cracking Framework
    - Dictionary attack
    - Rainbow table generation
    - GPU acceleration

### 11. Adli Bilişim

53. Memory Forensics Tool
    - Process analysis
    - Memory dumping
    - Artifact extraction

54. Disk Forensics Framework
    - File carving
    - Timeline analysis
    - Deleted file recovery

55. Network Forensics Tool
    - Packet capture analysis
    - Flow reconstruction
    - Protocol analysis

### 12. Red Team Araçları

56. C2 Framework Development
    - Command & Control
    - Payload delivery
    - Data exfiltration

57. Social Engineering Framework
    - Phishing automation
    - Credential harvesting
    - Campaign management

58. Custom RAT Development
    - Remote access
    - Anti-detection
    - Plugin system

### 13. Blue Team Araçları

59. SIEM Integration Framework
    - Log collection
    - Alert correlation
    - Incident response

60. Threat Hunting Platform
    - IOC detection
    - Behavior analysis
    - Threat intelligence

## Not
Her proje için aşağıdaki detaylar ayrıca belirlenmelidir:
- Teknik gereksinimler
- Değerlendirme kriterleri
- Teslim formatı
- Dokümantasyon standartları
