# pfSense Güvenlik Duvarı Kapsamlı Yönetim Kılavuzu

## Giriş

pfSense güvenlik duvarı yönetim arayüzü, ağ güvenliğinizi yapılandırmanız ve yönetmeniz için güçlü araçlar sunar. Bu kapsamlı kılavuz, her bir özelliği derinlemesine inceleyecek ve günlük yönetim görevlerinizde size yardımcı olacaktır.

## Arayüzde Gezinme ve Temel Kavramlar

pfSense güvenlik duvarı arayüzü, **Firewall > Rules** menüsünde mantıksal bir düzende organize edilmiştir. Bu menüye girdiğinizde, sisteminizdeki tüm ağ arayüzleri için sekmeleri göreceksiniz. Her arayüz için kurallar ayrı yönetilir ve kendi özelliklerine sahiptir.

### WAN Arayüzü 

WAN arayüzünde varsayılan olarak iki temel koruma bulunur:

1. **Özel Ağları Engelleme Kuralı (Block private networks)**
   - Özel IP adresi aralıklarından gelen trafiği engeller
   - Dişli simgesine tıklayarak yapılandırılabilir
   - Ağ güvenliğinin temel taşlarından biridir

**Örnek Senaryo: E-ticaret Şirketi Dış Bağlantı Güvenliği**
```plaintext
[Dış Erişim Kuralları]
- HTTPS (443) trafiğine izin verme
- SSH (22) erişimini sadece güvenli IP'lere açma
- DNS (53) trafiğini yalnızca belirli sunuculara izin verme
```

2. **Bogon Ağları Engelleme Kuralı (Block bogon networks)**
   - Geçersiz veya ayrılmış IP adreslerinden gelen trafiği engeller
   - WAN arayüzü yapılandırmasından özelleştirilebilir
   - Ağınızı sahte trafikten korur

**Örnek Senaryo: DDoS Koruma Yapılandırması**
```plaintext
[Gelişmiş Güvenlik]
- Rate limiting kuralları
- Hatalı paket filtreleme
- Durum tablosu optimizasyonu
```

### LAN Arayüzü

LAN arayüzünde varsayılan olarak üç temel kural bulunur:

1. IPv4 için "Default allow LAN to any" kuralı
2. IPv6 için "Default allow LAN to any" kuralı
3. Anti-Lockout koruma kuralı

**Örnek Senaryo: Kurumsal Ofis İç Ağ Yapılandırması**
```plaintext
[Departman Erişimi]
- Departmanlar arası erişim kontrolü
- İnternet erişim politikaları
- Yerel sunucu erişim kuralları
```

**Örnek Senaryo: Güvenli Yönetim Erişimi**
```plaintext
[Yönetici Politikaları]
- WebGUI erişim kısıtlamaları
- SSH yönetim kuralları
- SNMP izleme yapılandırması
```

## Kural Göstergeleri ve Anlamları

Her kuralın yanında bulunan görsel işaretler, o kuralın durumu ve yapılandırması hakkında hızlı bilgi verir:

### Temel Göstergeler

1. **Eylem Göstergeleri:**
   - ✓ (Yeşil onay): Trafiğe izin verilir
   - × (Kırmızı çarpı): Trafik engellenir
   - 🤚 (El işareti): Trafik reddedilir ve bildirim gönderilir

2. **Durum Göstergeleri:**
   - 📋 (Liste): Kural için günlükleme aktif
   - ⚙️ (Dişli): Gelişmiş seçenekler kullanımda
   - 🔅 (Soluk görünüm): Kural devre dışı

**Örnek Senaryo: Trafik İzleme Yapılandırması**
```plaintext
[Trafik Analizi]
- Aktif bağlantı sayısı izleme
- Trafik günlükleme
- Performans metrikleri takibi
```

## Kural Yönetimi

### Kural Ekleme ve Düzenleme

Kuralları iki şekilde ekleyebilirsiniz:
1. Listenin başına eklemek için üst "Ekle" düğmesi
2. Listenin sonuna eklemek için alt "Ekle" düğmesi

**Örnek Senaryo: Web Sunucu Güvenlik Kuralları**
```plaintext
[Web Güvenliği]
1. HTTPS trafiğine izin ver
2. HTTP'yi HTTPS'e yönlendir
3. WebSocket bağlantılarını yapılandır
```

### Kural Kopyalama ve Taşıma

Kuralları farklı arayüzler arasında veya aynı arayüz içinde kopyalayabilir ve taşıyabilirsiniz:

1. **Tekli Kopyalama:**
   - Kural yanındaki kopyala simgesine tıklayın
   - Yeni konumu seçin
   - Gerekli düzenlemeleri yapın

2. **Toplu Kopyalama:**
   - Kuralları seçin
   - "Kopyala" düğmesini kullanın
   - Hedef arayüzü belirleyin
   - Arayüz tanımlarını dönüştürme seçeneğini değerlendirin

**Örnek Senaryo: Şube Ofisi Yapılandırması**
```plaintext
[Şube Politikaları]
1. Ana ofis kurallarını kopyala
2. Yerel gereksinimlere göre düzenle
3. Bağlantı kurallarını test et
```

### Durum Tablosu Yönetimi

Durum tablosu, aktif bağlantıları ve trafik akışını izler:

1. **States Sütunu Bilgileri:**
   - Aktif bağlantı sayısı
   - Trafik miktarı
   - Son aktivite zamanı

2. **Durum Temizleme:**
   - Belirli bir kural için durumları temizleme
   - Arayüze özel durum yönetimi
   - Performans optimizasyonu

**Örnek Senaryo: Yüksek Yük Optimizasyonu**
```plaintext
[Performans Yönetimi]
- Durum tablosu boyutunu izle
- Gereksiz durumları temizle
- Kaynak kullanımını optimize et
```

### Kural Ayırıcıları ve Organizasyon

Kuralları mantıksal gruplara ayırmak için ayırıcılar kullanabilirsiniz:

1. **Ayırıcı Oluşturma:**
   - "Ayırıcı" düğmesine tıklayın
   - Açıklayıcı metin girin
   - Renk seçin
   - Konumlandırın

2. **Ayırıcı Yönetimi:**
   - Sürükle-bırak ile taşıma
   - Renk ve metin düzenleme
   - Gruplama mantığını koruma

**Örnek Senaryo: Güvenlik Politikası Organizasyonu**
```plaintext
[Politika Grupları]
- Güvenlik seviyelerine göre gruplama
- Departman bazlı ayrım
- Özel erişim kuralları
```

## Değişiklik Takibi ve Güvenlik

pfSense, tüm kural değişikliklerini detaylı şekilde kaydeder:

1. **Kayıt Edilen Bilgiler:**
   - Kullanıcı adı
   - IP adresi
   - Zaman damgası
   - Değişiklik detayları

2. **Güvenlik İzleme:**
   - Değişiklik geçmişi
   - Kullanıcı aktivitesi
   - Sistem durumu

**Örnek Senaryo: Denetim ve Uyumluluk**
```plaintext
[Güvenlik Denetimi]
- Düzenli kural gözden geçirme
- Değişiklik dokümantasyonu
- Uyumluluk raporlaması
```

## En İyi Uygulamalar

1. **Kural Organizasyonu:**
   - Mantıksal gruplama kullanın
   - Açıklayıcı isimler verin
   - Düzenli gözden geçirin

2. **Güvenlik Önlemleri:**
   - Anti-lockout kuralını koruyun
   - Değişiklikleri test edin
   - Yedekleme yapın

3. **Performans İyileştirmeleri:**
   - Durum tablosunu optimize edin
   - Gereksiz kuralları temizleyin
   - Kaynak kullanımını izleyin

4. **Dokümantasyon:**
   - Değişiklikleri kaydedin
   - Kural açıklamaları ekleyin
   - Düzenli denetim yapın

Bu kılavuz, pfSense güvenlik duvarı yönetiminin tüm yönlerini kapsar. Sisteminizin ihtiyaçlarına göre bu bilgileri uyarlayabilir ve güvenli bir ağ altyapısı oluşturabilirsiniz.
