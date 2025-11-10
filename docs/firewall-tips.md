
Amacınız, "Bu komut ne yapar?" sorusundan ziyade, "Neden bu komutu bu *şekilde* kullanmalıyım?" sorusunun cevabını anlamak olmalı.

### Temel Güvenlik Duvarı Terminolojisi

| Türkçe Terim | İngilizce Terim | Açıklaması |
| :--- | :--- | :--- |
| İzin Verme | Allow | Bir ağ paketinin güvenlik duvarından geçmesine izin veren kural. |
| Reddetme (Engelle) | Deny / Block | Bir ağ paketini *sessizce* (yanıt göndermeden) durduran kural. |
| Reddetme (Geri Çevir) | Reject | Bir ağ paketini, "erişim reddedildi" (örn: ICMP yanıtı) mesajı göndererek *aktif olarak* reddeden kural. |
| Hız Sınırlama | Rate Limiting | [cite_start]Belirli bir zaman dilimindeki *istek sayısını* kısıtlama (örn: dakikada 10 istek)[cite: 37, 38]. |
| Bağlantı Sınırlama | Connection Limiting | Bir kaynaktan gelen *eşzamanlı toplam bağlantı sayısını* kısıtlama (örn: aynı anda 20 bağlantı). |
| Port | Port | Bir IP adresi üzerindeki belirli bir hizmeti tanımlayan dijital kapı numarası (örn: 443 HTTPS'tir). |
| Protokol | Protocol | Verinin nasıl transfer edileceğini tanımlayan kurallar dizisi (örn: TCP, UDP, ICMP). |
| Kaynak | Source | Ağ paketinin *geldiği* yer (IP adresi veya ağ). |
| Hedef | Target / Destination | Ağ paketinin *gittiği* yer (IP adresi veya ağ). |
| Durum Tabanlı | Stateful | Güvenlik duvarının, bağlantıların durumunu (yeni, kurulu, vb.) takip etmesi. |
| Gelen (Trafik) | Ingress / Incoming | Dışarıdan güvenlik duvarına (ve sunucuya) gelen trafik. |
| Giden (Trafik) | Egress / Outgoing | Sunucudan (ve güvenlik duvarından) dışarıya giden trafik. |
| Kural Kümesi | Rule Set | Güvenlik duvarının uyguladığı tüm kuralların sıralı listesi. |
| Loglama | Logging | Güvenlik duvarı kararlarının (izin verilen/reddedilen) kaydının tutulması. |

---


### Mantıksal Temeller: "Neden?"

Güvenlik duvarı mantığını anlamak için üç temel prensibi bilmelisiniz:

#### 1. Temel Duruş: "Sıfır Güven" (Zero Trust) Mantığı

[cite_start]En temel mantık, "tümünü reddet" (default deny-all) politikasıdır[cite: 4, 13].

* **Zayıf Mantık:** "Bana lazım olabilecek her şeyi açayım, tehlikeli bir şey görürsem kapatırım." (Bu, evinizin tüm kapılarını kilitsiz bırakmaktır).
* **Güçlü Mantık (Default Deny):** "Evimin tüm kapıları varsayılan olarak kilitlidir (Default Deny Incoming). Sadece *tanıdığım* ve *beklediğim* bir misafir (örn: HTTPS trafiği) *belirli* bir kapıdan (örn: Port 443) gelirse, ona kapıyı açarım (Allow 443)."

[cite_start]Bu, saldırı yüzeyini en aza indirir[cite: 13]. [cite_start]Açık olmayan bir port, otomatik olarak korunur[cite: 13]. [cite_start]Bu ilkeye "En Az Ayrıcalık" (Least Privilege) denir[cite: 15].

#### 2. Reddetme Mantığı: "Block" (Engelle) vs. "Reject" (Geri Çevir)

Kullanıcı "red etme" dediğinde genellikle iki farklı eylem kast edilir:

1.  **Block (Sessiz Engelleme):**
    * **Ne Yapar?** Paketi sessizce "düşürür" (drop). Karşı tarafa *hiçbir yanıt göndermez*.
    * **Mantığı Nedir?** "Bilgi Sızıntısını Önleme." Özellikle dış ağda (WAN) kullanılır. Eğer bir saldırgan portunuzu taradığında "Reject" yanıtı alırsa, orada bir sunucu olduğunu ve bir güvenlik duvarının onu aktif olarak engellediğini anlar. "Block" yanıtı alırsa (yani yanıt alamazsa), portun kapalı mı, filtrelenmiş mi, yoksa o IP'nin boş mu olduğunu anlayamaz. Düşmana bilgi vermemek esastır.
    * **Senaryo:** İnternetten gelen zararlı bir IP'yi engellemek.

2.  **Reject (Aktif Geri Çevirme):**
    * **Ne Yapar?** Paketi reddeder ve karşı tarafa "buraya erişemezsin" (örn: TCP RST veya ICMP "unreachable") mesajı gönderir.
    * **Mantığı Nedir?** "Hızlı Hata Ayıklama." Özellikle iç ağda (LAN) tercih edilir. Eğer iç ağınızdaki meşru bir uygulama, yanlışlıkla yasaklı bir sunucuya erişmeye çalışırsa, "Reject" yanıtı sayesinde uygulama "bağlantı zaman aşımı" (timeout) beklemeden *anında* hata alır. Bu, iç ağdaki sorunları çözmeyi hızlandırır.
    * **Senaryo:** Muhasebe departmanının, geliştirici sunucusuna erişimini engellemek.

#### 3. Portların Mantığı: "Nereye?"

Portlar, bir sunucuya (IP adresi) gelen "dijital kapı numaralarıdır".

* **Mantık:** Bir IP adresi (örn: `10.20.30.40`) bir binanın adresi gibidir. Portlar ise o binadaki farklı departmanların kapı numaralarıdır:
    * **Port 80 (HTTP):** Ziyaretçi Danışma Kapısı (Güvensiz).
    * **Port 443 (HTTPS):** Güvenli Kasa Dairesi Kapısı (Güvenli).
    * **Port 22 (SSH):** Sadece Yöneticilerin Girdiği Sistem Odası Kapısı.
    * **Port 3306 (MySQL):** Veri Arşivi Odası Kapısı.

[cite_start]Bir kural yazdığınızda (`ufw allow 22/tcp`), aslında şunu dersiniz: "Bu binaya (sunucu IP'si) gelen ve 'Sistem Odası' kapısını (Port 22) çalmak isteyenlere izin ver."[cite: 11, 14].

---

### "Limit Koyma" Mantığı ve Yapısal Farkları

Bu, güvenliğin en önemli katmanlarından biridir. Limitlemenin iki temel yapısı vardır:

#### Yapı 1: Hız Sınırlama (Rate Limiting)

* **Temel Soru:** Bir kaynak *ne sıklıkta* istek atıyor?
* [cite_start]**Mantık:** "Kaynak Koruması" (Resource Protection)[cite: 39]. [cite_start]Amacı, hizmetin kendisini (örn: web sunucusu) aşırı kullanımdan (DDoS, Brute-force) korumaktır[cite: 37, 38].
* **Senaryo (Brute Force):** Bir saldırgan SSH (Port 22) kapısını dakikada binlerce kez deneyerek şifre kırmaya çalışır.
* **Kural Mantığı (`ufw limit 22/tcp`):** "Eğer aynı IP adresi 30 saniye içinde 6'dan fazla kez Port 22'yi *denemeye* çalışırsa, o IP'yi bir süreliğine engelle.". Bu, meşru bir yöneticinin (6 denemeden az yapar) çalışmasını etkilemez ama saldırganı durdurur.
* **Senaryo (Web DDoS):** Bir botnet, web sitenize (Port 80/443) saniyede 10.000 istek göndererek çökertmeye çalışır.
* **Kural Mantığı (`...limit in rate 30/minute`):** "Aynı IP'den Port 80'e dakikada 30'dan fazla *istek* gelirse, fazlasını engelle.".

#### Yapı 2: Bağlantı Sınırlama (Connection Limiting)

* **Temel Soru:** Bir kaynak *aynı anda kaç bağlantı* açıyor?
* **Mantık:** "Durum Tablosu Koruması" (State Table Protection). Hızdan farklıdır. Bir saldırgan, *yavaş yavaş* binlerce "yeni" bağlantı (state new) açıp, bunları kapatmadan bekleyebilir (örn: TCP SYN Flood). Bu, sunucunun bağlantı tablosunu doldurur ve yeni meşru kullanıcıların bağlanmasını engeller.
* **Senaryo (DoS):** Saldırgan, tam bir istek göndermeden binlerce "bağlantı başlatma" paketi gönderir.
* **Kural Mantığı (`...state new recent set ... recent 20`):** Bu gelişmiş kuralın mantığı şudur: "Bir IP adresinden 'yeni' bir bağlantı isteği geldiğinde onu listeye ekle (`recent set`). Eğer bu IP'nin listede *aynı anda* 20'den fazla kaydı (`recent 20`) varsa, bu yeni isteği engelle.".

### Kuralları Güçlendirme: Katmanlı Mantık

Kurallarınızı yazarken bu mantıkları birleştirirsiniz. [cite_start]Bu, "Katmanlı Güvenlik" (Layered Security) prensibidir[cite: 43].

* **Seviye 1 (Zayıf):** `ufw allow 3306/tcp` (Port bazlı)
    * *Mantık:* MySQL veritabanına herkesin erişmesine izin ver. (Çok tehlikeli).

* [cite_start]**Seviye 2 (Daha İyi):** `ufw allow from 10.0.0.0/8 to any port 3306` (Kaynak bazlı) [cite: 40]
    * [cite_start]*Mantık:* Veritabanına *sadece* 10'lu IP bloğundan (güvenilir iç ağ) gelenlerin erişmesine izin ver[cite: 41, 43]. [cite_start]Bu, "Güvenlik Zonları" (Security Zones) mantığıdır[cite: 32].

* **Seviye 3 (Güçlü):** `ufw route allow proto tcp from 192.168.1.0/24 to any port 80 limit in rate 60/minute` (Kaynak + Port + Hız Limiti)
    * *Mantık:* Sadece iç ağdan gelenlerin Web Sunucusuna erişmesine izin ver, ancak onların bile dakikada 60'tan fazla istek atmasını engelle.

* **Seviye 4 (Çıkış Kontrolü):** `ufw allow out to 8.8.8.8 port 53`
    * *Mantık:* Sunucumun *dışarıya* sadece 8.8.8.8 adresindeki DNS sunucusuna (Port 53) gitmesine izin ver. [cite_start]Bu, "Hedef Bazlı Kontrol" (Egress Filtering) olup, eğer sunucuya bir virüs bulaşırsa, o virüsün dışarıdaki bir C2 (Komuta Kontrol) sunucusuna bağlanmasını (veri sızdırmasını) engeller[cite: 34, 35, 36].

Güvenlik duvarı yapılandırması, bu mantık katmanlarını senaryonuza göre birleştirmektir.

---
https://github.com/keyvanarasteh
Keyvan ARASTEH ;-)
2025 - Firewall solutions
Istinye University
