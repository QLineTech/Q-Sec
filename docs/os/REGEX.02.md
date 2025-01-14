# Düzenli İfadeler (Regex) için Başlangıç Rehberi

Merhaba! Bugün düzenli ifadeleri (regex) öğrenmeye başlayacağız. Bunu bir oyun gibi düşünebilirsiniz - metinlerde hazine avına çıkıyoruz! 🎯

## 1. Düzenli İfade Nedir?
Düzenli ifadeler, metin içinde belirli kalıpları aramak için kullandığımız özel bir dildir. Örneğin, bir metnin içinde tüm e-posta adreslerini veya telefon numaralarını bulmak istediğimizde kullanırız.

## 2. En Basit Regex: Düz Metin Arama

### 🎯 Örnek 1: Kelime Arama
```bash
# "error" kelimesini arama
grep "error" log.txt

# Kullanım senaryosu:
echo "this is an error message" > log.txt
grep "error" log.txt
# Çıktı: this is an error message
```

## 3. Büyük/Küçük Harf Duyarsız Arama

### 🎯 Örnek 2: Harf Duyarsız Arama
```bash
# "ERROR" veya "error" veya "Error" arama
grep -i "error" log.txt

# Kullanım senaryosu:
echo "ERROR: system failed" > log.txt
echo "error: disk full" >> log.txt
grep -i "error" log.txt
# Her iki satırı da bulacaktır
```

## 4. Sayı Arama

### 🎯 Örnek 3: Basit Sayı Desenleri
```bash
# Tek basamaklı sayıları bulma: [0-9]
grep "[0-9]" sayilar.txt

# Kullanım senaryosu:
echo "Oda 5" > sayilar.txt
echo "Kat 3" >> sayilar.txt
grep "[0-9]" sayilar.txt
# Çıktı: Her iki satırı da gösterecek
```

## 5. Telefon Numarası Arama

### 🎯 Örnek 4: Basit Telefon Numarası
```bash
# 10 haneli telefon numarası arama
grep "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" telefonlar.txt

# Daha kısa yazımı:
grep "[0-9]\{10\}" telefonlar.txt

# Kullanım senaryosu:
echo "5321234567" > telefonlar.txt
grep "[0-9]\{10\}" telefonlar.txt
```

## 6. E-posta Adresi Arama

### 🎯 Örnek 5: Basit E-posta
```bash
# @ işareti içeren satırları bulma
grep "@" mailler.txt

# Kullanım senaryosu:
echo "ali@gmail.com" > mailler.txt
echo "bu bir @ işareti içerir" >> mailler.txt
grep "@" mailler.txt
```

## 7. Başlangıç ve Bitiş

### 🎯 Örnek 6: Satır Başı/Sonu
```bash
# "Test" ile başlayan satırlar
grep "^Test" dosya.txt

# "son" ile biten satırlar
grep "son$" dosya.txt

# Kullanım senaryosu:
echo "Test başladı" > dosya.txt
echo "Bu bir test son" >> dosya.txt
grep "^Test" dosya.txt
grep "son$" dosya.txt
```

## 8. Pratik Alıştırmalar 🎮

### Alıştırma 1: Log Dosyasında Hata Arama
```bash
# test.log dosyası oluşturalım
echo "INFO: Program başladı" > test.log
echo "ERROR: Bağlantı hatası" >> test.log
echo "Warning: Disk dolmak üzere" >> test.log

# Şimdi hataları bulalım
grep -i "error" test.log
```

### Alıştırma 2: Kullanıcı Adı Arama
```bash
# kullanicilar.txt oluşturalım
echo "kullanici_1" > kullanicilar.txt
echo "admin_user" >> kullanicilar.txt
echo "test123" >> kullanicilar.txt

# "_" içeren kullanıcıları bulalım
grep "_" kullanicilar.txt
```

## 9. Önemli İpuçları 💡

1. Her zaman önce basit aramalarla başlayın
2. Test etmek istediğiniz deseni küçük bir dosyada deneyin
3. grep komutunun çıktısını kontrol edin
4. Emin olmadığınızda -i flag'ini kullanın (büyük/küçük harf duyarsız)

## 10. Sık Yapılan Hatalar ⚠️

1. Çok karmaşık regex yazmaya çalışmak
2. Test etmeden uzun regex kullanmak
3. Özel karakterleri escape etmeyi unutmak (örn: nokta için \.)

## 11. Basit Egzersizler 🏋️‍♂️

1. Bir metin dosyası oluşturun ve içine:
   - Birkaç e-posta adresi
   - Telefon numaraları
   - Normal metinler yazın
   
2. Aşağıdaki aramaları deneyin:
   - Tüm e-posta adreslerini bulun (@'e göre)
   - Tüm telefon numaralarını bulun (ardışık sayılara göre)
   - Belirli bir kelimeyle başlayan satırları bulun

## 12. Test Etme 🧪

Her yeni regex'i test etmek için:
```bash
# test.txt oluştur
echo "test@email.com" > test.txt
echo "5551234567" >> test.txt

# regex'i dene
grep "@" test.txt        # e-posta için
grep "[0-9]\{10\}" test.txt  # telefon için
```

Regex öğrenmek zaman ve pratik gerektirir. Acele etmeyin ve her adımı iyice anlayarak ilerleyin. Bol bol pratik yapın! 🚀


# Regex Pratik Alıştırmalar Rehberi

## 🎯 Alıştırma 1: Log Dosyası Analizi

Önce örnek bir log dosyası oluşturalım:
```bash
# ornek_log.txt içeriği:
[2024-01-14 10:15:30] ERROR: Login failed for user admin
[2024-01-14 10:16:45] INFO: System startup
[2024-01-14 10:17:22] WARNING: Disk usage at 85%
[2024-01-14 10:18:50] ERROR: Database connection timeout
[2024-01-14 10:19:15] INFO: Backup completed
```

Şimdi bu log dosyası üzerinde çalışalım:

1. Sadece hata mesajlarını bulma:
```bash
grep "ERROR" ornek_log.txt
# Açıklama: Bu komut sadece ERROR içeren satırları gösterir
```

2. Tarih ve saati ayıklama:
```bash
grep -E "\[[0-9-]{10} [0-9:]{8}\]" ornek_log.txt
# Açıklama: Köşeli parantez içindeki tarih ve saat formatını bulur
```

## 🎯 Alıştırma 2: Kullanıcı Bilgileri

Örnek bir kullanıcı listesi oluşturalım:
```bash
# kullanicilar.txt içeriği:
ad: Ali Yilmaz, tel: 05321234567, email: ali@firma.com
ad: Ayse Demir, tel: 05423456789, email: ayse@firma.com
ad: Can Kaya, tel: 05559876543, email: can.kaya@firma.com
```

Pratik arama örnekleri:

1. E-posta adreslerini bulma:
```bash
grep -E "[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\.[a-zA-Z]+" kullanicilar.txt
# Açıklama: @ işareti etrafındaki karakterleri kontrol ederek e-posta adreslerini bulur
```

2. Telefon numaralarını bulma:
```bash
grep -E "0[0-9]{10}" kullanicilar.txt
# Açıklama: 0 ile başlayan ve toplam 11 haneli numaraları bulur
```

## 🎯 Alıştırma 3: Web Sunucu Logları

Örnek bir web sunucu log dosyası oluşturalım:
```bash
# web_log.txt içeriği:
192.168.1.100 - - [14/Jan/2024:10:15:30 +0300] "GET /index.html HTTP/1.1" 200
192.168.1.101 - - [14/Jan/2024:10:16:45 +0300] "GET /login.php HTTP/1.1" 404
192.168.1.102 - - [14/Jan/2024:10:17:22 +0300] "POST /api/data HTTP/1.1" 500
```

Pratik aramalar:

1. IP adreslerini bulma:
```bash
grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" web_log.txt
# Açıklama: Satır başındaki IP adreslerini bulur
```

2. Hatalı istekleri bulma (404 ve 500):
```bash
grep -E "(404|500)$" web_log.txt
# Açıklama: Satır sonundaki hata kodlarını bulur
```

## 🎯 Alıştırma 4: Güvenlik Logları

Güvenlik log örneği oluşturalım:
```bash
# security_log.txt içeriği:
ALERT: Failed login attempt from IP: 192.168.1.50 at 10:15:30
WARNING: Multiple password attempts - user: admin@system.com
CRITICAL: Unauthorized access detected - MAC: 00:1B:44:11:3A:B7
INFO: Firewall rule updated for port 443
```

Güvenlik analizi örnekleri:

1. Kritik olayları bulma:
```bash
grep -E "^(ALERT|CRITICAL)" security_log.txt
# Açıklama: ALERT veya CRITICAL ile başlayan satırları bulur
```

2. MAC adreslerini bulma:
```bash
grep -E "([0-9A-F]{2}:){5}[0-9A-F]{2}" security_log.txt -i
# Açıklama: MAC adresi formatına uyan desenleri bulur
```

## 🎯 Alıştırma 5: Yapılandırma Dosyası

Örnek bir yapılandırma dosyası oluşturalım:
```bash
# config.txt içeriği:
# Database Settings
DB_HOST=localhost
DB_PORT=3306
DB_USER=admin
DB_PASS=secure123

# API Settings
API_KEY=ak_1234567890abcdef
API_URL=https://api.example.com
```

Konfigürasyon analizi:

1. Tüm ayar değerlerini bulma:
```bash
grep -E "^[A-Z_]+=.+" config.txt
# Açıklama: Büyük harfle başlayan ve = içeren ayar satırlarını bulur
```

2. API ile ilgili ayarları bulma:
```bash
grep "^API_" config.txt
# Açıklama: API_ ile başlayan tüm ayarları bulur
```

## 💡 Pratik İpuçları:

1. Her alıştırmadan önce küçük bir test dosyası oluşturun
2. grep komutunun çıktısını kontrol edin
3. Düzenli ifadeyi adım adım karmaşıklaştırın
4. Hata yaparsanız endişelenmeyin, regex öğrenmenin normal bir parçası

## 🎓 İleri Seviye Alıştırmalar İçin:

1. Birden fazla dosyada aynı anda arama yapın
2. Sonuçları farklı formatlarda kaydedin
3. Bulunan sonuçları başka komutlarla işleyin
4. Kendi log dosyalarınızı oluşturup analiz edin

Bu alıştırmaları yaparken, her adımı anlayarak ilerleyin ve sonuçları kontrol edin. Regex öğrenmek pratik yaptıkça kolaylaşır! 🚀
