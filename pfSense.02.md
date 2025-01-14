# Kapsamlı Güvenlik Duvarı Yönetim Kılavuzu

## Giriş

pfSense güvenlik duvarı yönetim arayüzü, ağ güvenliğinizi yapılandırmanız ve yönetmeniz için güçlü araçlar sunar. Bu kapsamlı kılavuz, her bir özelliği derinlemesine inceleyecek ve günlük yönetim görevlerinizde size yardımcı olacaktır.

## Arayüz Genel Bakış

### Varsayılan Kurallar ve Özellikleri

pfSense'in **Firewall > Rules** ekranında ilk olarak WAN kural seti görüntülenir. Bu ekranda varsayılan olarak:

1. **Özel Ağları Engelleme Kuralı (Block private networks)**
   - Özel IP adresi aralıklarından gelen trafiği engeller
   - Dişli simgesine tıklayarak yapılandırılabilir
   - Ağ güvenliğinin temel taşlarından biridir

2. **Bogon Ağları Engelleme Kuralı (Block bogon networks)**
   - Geçersiz veya ayrılmış IP adreslerinden gelen trafiği engeller
   - WAN arayüzü yapılandırmasından özelleştirilebilir
   - Ağınızı sahte trafikten korur

### Kural Göstergeleri ve Anlamları

Her kuralın yanında bulunan görsel göstergeler şunları ifade eder:

1. **Eylem Göstergeleri:**
   - ✓ (Yeşil onay): Trafiğe izin verilir
   - × (Kırmızı çarpı): Trafik engellenir
   - 🤚 (El işareti): Trafik reddedilir ve bildirim gönderilir

2. **Durum Göstergeleri:**
   - 📋 (Liste): Kural için günlükleme aktif
   - ⚙️ (Dişli): Gelişmiş seçenekler kullanımda
   - 🔅 (Soluk görünüm): Kural devre dışı

## Detaylı Kural Yönetimi

### Kural İzleme ve Analiz

Kuralların etkinliğini ve kullanımını izlemek için "States" (Durumlar) sütunu önemli bilgiler sunar:

1. **Durum Sayacı:**
   - Aktif bağlantı sayısını gösterir
   - Trafik miktarını takip eder
   - Fare üzerine getirildiğinde detaylı istatistikler sunar

2. **İstatistik Detayları:**
   ```plaintext
   Aktif Bağlantılar: 125
   Toplam Trafik: 1.2 GB
   Son Aktivite: 2 dakika önce
   ```

### Durum Yönetimi

Kural durumlarını yönetmek için çeşitli seçenekler bulunur:

1. **Durum Temizleme:**
   ```plaintext
   1. Kuralın yanındaki çarpı simgesine tıklayın
   2. Onay isteğini kabul edin
   3. İlgili arayüzdeki durumlar temizlenir
   ```

2. **Önemli Not:** Durum temizleme işlemi sadece seçili arayüzdeki durumları etkiler. Diğer arayüzlerdeki ilişkili durumlar etkilenmez.

### Kuralları Devre Dışı Bırakma ve Etkinleştirme

Kuralları geçici olarak devre dışı bırakmak veya yeniden etkinleştirmek için:

1. **Tekli İşlem:**
   ```plaintext
   Devre Dışı Bırakma:
   1. Yasak simgesine tıklayın
   2. Kural soluk renkle gösterilir
   3. Simge onay işaretine dönüşür

   Etkinleştirme:
   1. Onay işaretine tıklayın
   2. Kural normal rengine döner
   3. Simge yasak işaretine dönüşür
   ```

2. **Çoklu İşlem:**
   ```plaintext
   1. İşlem yapılacak kuralları seçin
   2. "Aç/Kapat" düğmesini kullanın
   3. Tüm seçili kuralların durumu değişir
   ```

3. **Düzenleme ile Devre Dışı Bırakma:**
   - Kuralı düzenleyin
   - "Devre Dışı" onay kutusunu işaretleyin
   - Değişiklikleri kaydedin

### Kural Ayırıcıları ile Organizasyon

Kural setinizi daha iyi organize etmek için ayırıcıları kullanabilirsiniz:

1. **Yeni Ayırıcı Oluşturma:**
   ```plaintext
   1. "Ayırıcı" düğmesine tıklayın
   2. Açıklayıcı bir metin girin
   3. Renk seçin (görsel organizasyon için)
   4. İstenen konuma sürükleyin
   5. İçeriği kaydedin
   6. Kural listesini kaydedin
   ```

2. **Ayırıcı Yönetimi:**
   ```plaintext
   Taşıma:
   1. Ayırıcıyı tutun
   2. Yeni konuma sürükleyin
   3. Listeyi kaydedin

   Silme:
   1. Çöp kutusu simgesine tıklayın
   2. Listeyi kaydedin
   ```

### Değişiklik Takibi ve Güvenlik

pfSense, kural değişikliklerini detaylı şekilde takip eder:

1. **Kayıt Edilen Bilgiler:**
   - Değişikliği yapan kullanıcının adı
   - IP adresi
   - Zaman damgası
   - Otomatik oluşturma bilgisi

2. **Değişiklik Görüntüleme:**
   ```plaintext
   Son Güncelleme:
   Kullanıcı: admin
   IP: 192.168.1.100
   Tarih: 14/01/2025 15:30
   ```

## Pratik Uygulama Örnekleri

### Örnek 1: Güvenli Web Sunucu Yapılandırması
```plaintext
[Web Sunucusu Güvenliği] - Mavi
- HTTPS trafiğine izin ver (443)
- HTTP trafiğini reddet (80)
- Yönetim erişimini kısıtla

[Güvenlik Önlemleri] - Kırmızı
- Rate limiting kuralları
- Brute force koruması
- DDoS önleme
```

### Örnek 2: VPN ve Uzak Erişim
```plaintext
[VPN Erişimi] - Yeşil
- OpenVPN portu (1194/UDP)
- İç ağ erişim kuralları
- İnternet erişim politikası

[Yönetim Erişimi] - Turuncu
- SSH erişimi (özel IP'ler)
- HTTPS yönetim arayüzü
- SNMP izleme
```

## En İyi Uygulamalar ve Öneriler

1. **Kural Organizasyonu:**
   - Kuralları mantıksal gruplara ayırın
   - Her grup için açıklayıcı ayırıcılar kullanın
   - En önemli kuralları üste yerleştirin

2. **Güvenlik Önlemleri:**
   - Anti-lockout kuralını asla devre dışı bırakmayın
   - Kural değişikliklerini test edin
   - Düzenli yedekleme alın

3. **Performans İyileştirmeleri:**
   - Durum tablosunu düzenli kontrol edin
   - Kullanılmayan kuralları temizleyin
   - Kural sıralamasını optimize edin

4. **Dokümantasyon:**
   - Önemli kuralları belgeleyin
   - Değişiklikleri kayıt altına alın
   - Düzenli denetim yapın

Bu kılavuz, pfSense güvenlik duvarı yönetiminin tüm yönlerini kapsar.
