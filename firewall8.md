SQL Enjeksiyon saldırılarına karşı savunma stratejilerini ve örnek payload'ları detaylı olarak açıklayacağım.



```sql
-- 1. Temel SQL Enjeksiyon Payload'ları
-- 1.1 Basit Denemeler
'
''
`
``
,
"
""
\
/
;
-- Noktalı virgül ile komut zincirleme
;SELECT @@version
;SELECT * FROM users

-- 1.2 Mantıksal Operatörler
' OR '1'='1
' OR 1=1--
' OR 'x'='x
" OR "a"="a
') OR ('1'='1
' OR '1'='1' --
' OR 'unusual' LIKE 'unusual
' AND id IS NOT NULL; --

-- 1.3 UNION Tabanlı Saldırılar
' UNION SELECT NULL--
' UNION SELECT NULL,NULL--
' UNION ALL SELECT username, password FROM users--
' UNION SELECT @@version,NULL--
' UNION SELECT table_name,NULL FROM information_schema.tables--

-- 1.4 Zaman Bazlı Saldırılar
'; WAITFOR DELAY '0:0:10'--
'; IF (SELECT COUNT(*) FROM users) > 100 WAITFOR DELAY '0:0:5'--
'; SELECT CASE WHEN (1=1) THEN pg_sleep(5) ELSE pg_sleep(0) END--
'; SELECT IF(SUBSTRING(user(),1,1)='r',SLEEP(5),0)--

-- 1.5 Hata Tabanlı Saldırılar
' AND 1=CONVERT(int,(SELECT @@version))--
' AND 1=CAST((SELECT user) as int)--
' AND 1=(SELECT TOP 1 table_name FROM information_schema.tables)--

-- 2. Savunma Kodları

-- 2.1 Python - Parametreli Sorgular
import sqlite3

def güvenli_sorgu():
    conn = sqlite3.connect('veritabani.db')
    cursor = conn.cursor()
    
    # YANLIŞ KULLANIM - Güvensiz
    user_id = "1' OR '1'='1"
    sorgu = f"SELECT * FROM kullanicilar WHERE id = '{user_id}'"  # Güvensiz!
    
    # DOĞRU KULLANIM - Parametreli sorgu
    cursor.execute("SELECT * FROM kullanicilar WHERE id = ?", (user_id,))
    
    # DOĞRU KULLANIM - Çoklu parametre
    cursor.execute("""
        SELECT * FROM kullanicilar 
        WHERE kullanici_adi = ? AND sifre = ?
    """, (kullanici_adi, sifre))

-- 2.2 PHP - PDO Kullanımı
<?php
try {
    $db = new PDO("mysql:host=localhost;dbname=test", "kullanici", "sifre");
    
    // YANLIŞ KULLANIM
    $id = $_GET['id'];
    $sorgu = "SELECT * FROM kullanicilar WHERE id = " . $id;  // Güvensiz!
    
    // DOĞRU KULLANIM
    $stmt = $db->prepare("SELECT * FROM kullanicilar WHERE id = :id");
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    
} catch(PDOException $e) {
    // Hata yönetimi
    error_log($e->getMessage());
    echo "Bir hata oluştu";
}
?>

-- 2.3 Java - PreparedStatement Kullanımı
try (Connection conn = DriverManager.getConnection(url, user, password)) {
    // YANLIŞ KULLANIM
    String userId = request.getParameter("id");
    Statement stmt = conn.createStatement();
    String sorgu = "SELECT * FROM kullanicilar WHERE id = '" + userId + "'";  // Güvensiz!
    
    // DOĞRU KULLANIM
    PreparedStatement pstmt = conn.prepareStatement(
        "SELECT * FROM kullanicilar WHERE id = ?"
    );
    pstmt.setString(1, userId);
    ResultSet rs = pstmt.executeQuery();
}

-- 3. Güvenlik Kontrol Listesi
-- 3.1 Giriş Doğrulama Regex Örnekleri
^[a-zA-Z0-9_]{3,16}$                   -- Kullanıcı adı kontrolü
^[0-9]{1,10}$                          -- Sayısal ID kontrolü
^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$  -- E-posta kontrolü

-- 3.2 Veritabanı Kullanıcı Yetkileri
CREATE USER 'uygulama_kullanici'@'localhost' 
    IDENTIFIED BY 'guclu_sifre';
GRANT SELECT, INSERT, UPDATE 
    ON uygulama_db.* 
    TO 'uygulama_kullanici'@'localhost';
REVOKE DROP, ALTER, CREATE 
    ON uygulama_db.* 
    FROM 'uygulama_kullanici'@'localhost';

```

SQL Enjeksiyon saldırılarına karşı savunma stratejilerini ve önemli noktaları detaylıca açıklayalım:

1. Parametreli Sorgu Kullanımı:
   - Her zaman parametreli sorguları tercih etmeliyiz
   - Farklı programlama dillerinde doğru kullanım örneklerini yukarıdaki kodda görebilirsiniz
   - Parametreli sorgular, kullanıcı girdisini otomatik olarak escape eder

2. Giriş Doğrulama:
   - Whitelist yaklaşımı kullanın: Sadece izin verilen karakterlere izin verin
   - Veri tiplerini sıkı şekilde kontrol edin
   - Uzunluk sınırlamaları koyun
   - Özel karakterleri filtreleyip dönüştürün

3. Hata Yönetimi:
   - Detaylı hata mesajlarını son kullanıcıya göstermeyin
   - Hataları loglayın ama hassas bilgileri loglamayın
   - Özel hata sayfaları kullanın

4. En Az Yetki Prensibi:
   - Veritabanı kullanıcılarına minimum gerekli yetkileri verin
   - Her uygulama için ayrı veritabanı kullanıcısı oluşturun
   - Kritik tablolara erişimi sınırlayın

5. Web Application Firewall (WAF):
   - ModSecurity gibi açık kaynak WAF'lar kullanın
   - SQL enjeksiyon imzalarını güncel tutun
   - False positive oranını düşük tutacak şekilde kuralları optimize edin

6. Düzenli Güvenlik Testleri:
   - Otomatik SQL enjeksiyon tarama araçları kullanın (örn: SQLMap)
   - Penetrasyon testleri yaptırın
   - Kod güvenlik analizleri yapın

Ekstra önlemler:
- Stored Procedure'lar kullanın
- ORM framework'leri tercih edin
- Query Builder'lar kullanın
- Escape fonksiyonlarını doğru kullanın
- Second-order SQL enjeksiyonlarına karşı dikkatli olun

Örnek bir saldırı senaryosu düşünelim:

```sql
-- Saldırgan şöyle bir giriş yapabilir:
kullanici_adi = "admin' --"
sifre = "herhangi_birsey"

-- Bu durumda güvensiz sorgu şöyle olur:
SELECT * FROM kullanicilar 
WHERE kullanici_adi = 'admin' --' AND sifre = 'herhangi_birsey'
```

Bu saldırıya karşı güvenli kod:

```python
# Parametreli sorgu kullanımı
cursor.execute("""
    SELECT * FROM kullanicilar 
    WHERE kullanici_adi = ? AND sifre = ?
""", (kullanici_adi, sifre))
```




----------------------------


SQL enjeksiyon saldırılarının güvenlik duvarları tarafından nasıl tespit edildiğini farklı katmanlar ve mekanizmalar üzerinden açıklayacağım:

# 1. Kalıp Eşleştirme ve İmzalar 

Güvenlik duvarları, bilinen zararlı kalıpları tespit etmek için gelişmiş algoritmalar kullanır. Örneğin, şu tür yapıları arar:
```sql
'1=1--
UNION SELECT
SLEEP(
exec(
```

Bu kalıplar düzenli ifadeler (regex) kullanılarak yakalanır ve sürekli güncellenen saldırı imza veritabanlarıyla karşılaştırılır.

# 2. Davranışsal Analiz

Sistem, veritabanı erişim kalıplarını sürekli izler. Normal kullanımdan sapan durumlar tespit edilir:
```sql
-- Örnek şüpheli kalıplar
SELECT * FROM users; DELETE FROM users; -- (Çoklu sorgu)
SELECT CONCAT(@@version,'|',user()) -- (Sistem bilgisi toplama)
```

Özellikle dikkat edilen noktalar:
- Sorgu sıklığındaki ani artışlar
- Alışılmadık sorgu yapıları
- Hızlı ardışık istekler

# 3. Bağlamsal Algılama

Sistem gelen sorguları bağlamsal olarak analiz eder:
```sql
-- Normal sorgu örneği
SELECT * FROM products WHERE category_id = 5

-- Şüpheli sorgu örneği
SELECT * FROM products WHERE category_id = '5' OR '1'='1'
```

İncelenen özellikler:
- Girdi uzunluklarının normalliği
- Karakter dağılımları
- Veri tipi uygunluğu
- Sorgu karmaşıklığı

# 4. Protokol Analizi

SQL protokolü seviyesinde yapılan kontroller:
```sql
-- Geçerli SQL sözdizimi
SELECT column FROM table WHERE condition

-- Geçersiz/şüpheli sözdizimi
SELECT /*! CONCAT(user,password) */ FROM users
```

# 5. Makine Öğrenimi Tabanlı Tespit

Makine öğrenimi modelleri şu özellikleri analiz eder:
```python
# Analiz edilen özellikler
ozellikler = {
    'girdi_uzunlugu': len(sorgu),
    'ozel_karakter_orani': ozel_karakter_say(sorgu)/len(sorgu),
    'entropi': entropi_hesapla(sorgu),
    'token_kaliplari': token_kaliplari_cikar(sorgu)
}
```

# 6. Yaygın Tespit Kuralları

Sistem özellikle şu durumları yakından izler:
```sql
-- Ardışık tek tırnaklar
SELECT '' '' ''
-- Kodlanmış karakterler
SELECT CHAR(0x73) 
-- Yorum işaretleri
/* zararlı kod */
```

# 7. Önleme Aksiyonları

Tespit edilen saldırılara karşı alınan önlemler:
```
- Şüpheli isteklerin engellenmesi
- Hız sınırlama
- Oturum sonlandırma
- Uyarı oluşturma
- IP engelleme
- İstek kayıt tutma
```

# 8. Gelişmiş Tespit Yöntemleri

Son olarak, daha ileri seviye teknikler kullanılır:
- Sanal Yama Uygulamasi
- Sezgisel Analiz
- Anomali Puanlama
- Trafik Öğrenimi
- İstatistiksel Analiz

----------------------------------------------

Kalıp Eşleştirme ve İmza tabanlı tespiti daha detaylı açıklayalım. Bu, SQL enjeksiyon saldırılarına karşı ilk savunma hattımızı oluşturur.

# Kalıp Eşleştirme Nasıl Çalışır?

Güvenlik duvarı, gelen her SQL sorgusunu bir dizi bilinen saldırı kalıbıyla karşılaştırır. Bu işlem, bir kütüphanedeki kitapların dizinini kontrol etmeye benzer. Nasıl ki bir kitabı bulmak için dizine bakıyorsak, güvenlik duvarı da zararlı kodları bulmak için bu kalıpları kullanır.

İşte temel süreç:

```sql
-- Örnek bir kullanıcı girişi:
kullanici_adi = "admin' OR '1'='1"

-- Güvenlik duvarı bu girişteki şüpheli kalıpları tespit eder:
1. '1'='1' kalıbı (Her zaman doğru olan mantıksal ifade)
2. OR operatörü (Mantıksal işlem ekleme girişimi)
3. Tek tırnak karakterinin anormal kullanımı
```

# İmza Veritabanı Yönetimi

İmza veritabanı sürekli güncellenen bir tehdit istihbarat sistemidir. Şöyle çalışır:

```python
# Örnek imza veritabanı yapısı
imza_veritabani = {
    'temel_kaliplar': [
        r"'\s*OR\s*'1'='1",      # OR tabanlı saldırılar
        r"--\s*$",               # Satır sonu yorumları
        r"/\*.*?\*/",            # Çok satırlı yorumlar
        r"UNION\s+SELECT",       # UNION tabanlı saldırılar
        r"EXEC(\s|\+)+(xp|sp)"   # Stored procedure çağrıları
    ],
    
    'risk_puanlari': {
        'dusuk': 1,
        'orta': 5,
        'yuksek': 10
    }
}
```

# Regex Kullanımı

Düzenli ifadeler (regex), saldırı kalıplarını esnek bir şekilde yakalamak için kullanılır. Örneğin:

```python
# Örnek regex kalıpları ve açıklamaları
regex_ornekleri = {
    r"(?i)(select.*from)": "SELECT sorguları arar",
    r"(?i)(union.*select)": "UNION SELECT saldırılarını yakalar",
    r"(?i)(exec.*sp)": "Stored procedure çağrılarını tespit eder",
    r"'.*?'.*?'": "Çoklu tek tırnak kullanımını bulur"
}
```

# Yanlış Pozitif Yönetimi

Kalıp eşleştirme bazen meşru sorguları da saldırı olarak işaretleyebilir. Bu durumu yönetmek için:

```python
# Yanlış pozitifleri azaltma stratejileri
def sorgu_analiz(sorgu):
    puan = 0
    
    # Birden fazla kriter kontrolü
    if regex_kontrol(sorgu):
        puan += 2
    
    if ozel_karakter_orani(sorgu) > 0.3:
        puan += 3
        
    if yorum_iceriyor(sorgu):
        puan += 2
    
    # Sadece belirli bir eşik üzerinde alarm üret
    return puan >= 5
```

# Kalıp Güncelleme Mekanizması

İmza veritabanı dinamik olarak güncellenir:

1. Yeni saldırı teknikleri tespit edildiğinde
2. Mevcut kalıplar iyileştirildiğinde
3. Yanlış pozitif oranları yüksek olan kalıplar düzeltildiğinde

Bu sürekli öğrenme ve güncelleme süreci, sistemin güncel tehditlere karşı etkili kalmasını sağlar.


---------------------------------

SQL enjeksiyon saldırılarında davranışsal analiz, bir güvenlik görevlisinin bir alışveriş merkezindeki şüpheli davranışları izlemesine benzer. Nasıl ki güvenlik görevlisi normal müşteri davranışlarından sapmaları fark edebiliyorsa, güvenlik duvarı da normal veritabanı erişim kalıplarından sapmaları tespit eder. Gelin bu süreci detaylıca inceleyelim.

# Veritabanı Erişim Profili Oluşturma

Öncelikle sistem, "normal" davranışın ne olduğunu öğrenir. Bu öğrenme süreci şöyle işler:

```python
# Normal kullanıcı davranış profilini oluşturan örnek kod
class DavranisAnalizi:
    def __init__(self):
        self.normal_profil = {
            'sorgu_sikligi': 0,      # Birim zamandaki sorgu sayısı
            'ortalama_uzunluk': 0,   # Sorguların ortalama uzunluğu
            'sorgu_cesitleri': {},   # SELECT, INSERT gibi sorgu tipleri
            'zamansal_dagilim': {}   # Günün hangi saatlerinde ne kadar sorgu
        }
    
    def profil_guncelle(self, sorgu, zaman):
        # Her yeni sorguyla profili günceller
        self.normal_profil['sorgu_sikligi'] = self.hesapla_frekans(zaman)
        self.normal_profil['ortalama_uzunluk'] = self.guncelle_ortalama(len(sorgu))
```

# Anormal Davranış Tespiti

Sistem şu tür sapmaları tespit eder:

```sql
-- Normal sorgu örneği (Tek bir işlem)
SELECT * FROM urunler WHERE kategori_id = 5;

-- Şüpheli sorgu örneği (Çoklu işlem)
SELECT * FROM urunler; DROP TABLE urunler; --
```

Tespit edilen anormal davranışlar şunları içerir:

```python
def anomali_tespit(sorgu, kullanici_davranis):
    skor = 0
    
    # Hızlı ardışık istekler
    if kullanici_davranis.sorgu_frekansi > NORMAL_FREKANS * 3:
        skor += 5
        
    # Alışılmadık sorgu yapıları
    if karmasiklik_analizi(sorgu) > NORMAL_KARMASIKLIK * 2:
        skor += 3
        
    # Çoklu işlem içeren sorgular
    if noktalı_virgul_sayisi(sorgu) > 1:
        skor += 4
```

# Zamansal Analiz

Sistem, sorguların zamansal dağılımını da inceler:

```python
class ZamansalAnaliz:
    def __init__(self):
        self.saat_bazli_istatistik = {saat: 0 for saat in range(24)}
        
    def analiz_et(self, sorgu, zaman):
        saat = zaman.hour
        normal_yogunluk = self.saat_bazli_istatistik[saat]
        
        # Ani artış tespiti
        if self.mevcut_yogunluk > normal_yogunluk * 2:
            return "Şüpheli aktivite: Ani sorgu artışı"
```

# Sorgu Karmaşıklığı Analizi

Normal sorgularla karmaşık saldırı sorgularını ayırt etmek için:

```python
def karmasiklik_analizi(sorgu):
    karmasiklik_puani = 0
    
    # SQL anahtar kelime sayısı
    karmasiklik_puani += sql_keyword_sayisi(sorgu) * 2
    
    # İç içe sorgu derinliği
    karmasiklik_puani += ic_ice_sorgu_derinligi(sorgu) * 3
    
    # Koşul sayısı (WHERE, HAVING vb.)
    karmasiklik_puani += kosul_sayisi(sorgu)
    
    return karmasiklik_puani
```

# Kullanıcı Oturum Analizi

Her kullanıcının normal davranış kalıbı öğrenilir ve sapmalar tespit edilir:

```python
class OturumAnalizcisi:
    def __init__(self, kullanici_id):
        self.kullanici_gecmisi = []
        self.normal_davranis = self.kullanici_profilini_yukle(kullanici_id)
    
    def davranis_analiz(self, mevcut_aktivite):
        sapma = self.sapma_hesapla(mevcut_aktivite, self.normal_davranis)
        if sapma > SAPMA_ESIGI:
            return self.alarm_uret(sapma_detaylari)
```

Davranışsal analiz, saldırıların gerçek zamanlı tespitinde çok önemlidir çünkü yeni ve bilinmeyen saldırı türlerini bile yakalayabilir. Bu sistem sürekli öğrenir ve kendini günceller, böylece zamanla daha da etkili hale gelir.


--------------------------

Bağlamsal Algılama, SQL enjeksiyon saldırılarının tespitinde çok önemli bir katmandır. Bu yaklaşımı günlük hayattan bir örnekle açıklayabiliriz: Bir banka görevlisinin, müşterinin normal davranış kalıplarını bilmesi ve anormal bir işlem gördüğünde hemen fark etmesi gibi, bağlamsal algılama da veritabanına gelen isteklerin "normalliğini" değerlendirir.

# Girdi Uzunluğu Analizi

Bir SQL sorgusunun normal uzunluğu, yapılmak istenen işleme göre belirli bir aralıkta olmalıdır. Bunu kod üzerinde görelim:

```python
class GirdiAnalizcisi:
    def __init__(self):
        self.uzunluk_istatistikleri = {
            'login_sorgusu': {'min': 20, 'max': 100, 'ortalama': 45},
            'urun_arama': {'min': 10, 'max': 150, 'ortalama': 60},
            'profil_guncelleme': {'min': 30, 'max': 200, 'ortalama': 85}
        }
    
    def uzunluk_kontrol(self, sorgu_tipi, girdi):
        normal_aralik = self.uzunluk_istatistikleri[sorgu_tipi]
        
        if len(girdi) > normal_aralik['max'] * 1.5:
            return f"Uyarı: Sorgu uzunluğu normal aralığın çok üstünde"
```

# Karakter Dağılımı İncelemesi

Normal bir sorguda belirli karakterlerin dağılımı genellikle dengeli olmalıdır. Saldırı girişimlerinde bu denge bozulur:

```python
def karakter_dagilim_analizi(sorgu):
    # Karakter sayımı yapılır
    karakter_sayaci = Counter(sorgu)
    
    # Özel karakterlerin oranı hesaplanır
    ozel_karakterler = set("'\"();--/*+")
    ozel_karakter_orani = sum(karakter_sayaci[k] for k in ozel_karakterler) / len(sorgu)
    
    if ozel_karakter_orani > 0.15:  # %15'ten fazla özel karakter şüpheli
        return "Şüpheli karakter dağılımı tespit edildi"
```

# Veri Tipi Doğrulama

Her alan için beklenen veri tipi kontrol edilir. Örneğin, sayısal bir alana metin girişi şüphelidir:

```python
class VeriTipiDogrulayici:
    def __init__(self):
        self.beklenen_tipler = {
            'kullanici_id': int,
            'email': str,
            'dogum_tarihi': datetime,
            'telefon': str
        }
    
    def tip_kontrol(self, alan_adi, deger):
        beklenen_tip = self.beklenen_tipler[alan_adi]
        
        try:
            # Değeri beklenen tipe çevirmeyi dene
            deger = beklenen_tip(deger)
            return True, deger
        except ValueError:
            return False, f"{alan_adi} için geçersiz veri tipi"
```

# Sorgu Karmaşıklığı Değerlendirmesi

Normal bir sorgunun karmaşıklık seviyesi, işlemin türüne göre tahmin edilebilir olmalıdır:

```python
class KarmasiklikDegerlendirici:
    def analiz_et(self, sorgu):
        karmasiklik_skoru = 0
        
        # İç içe sorgu sayısı
        karmasiklik_skoru += sorgu.count('SELECT') - 1
        
        # Birleştirme (JOIN) sayısı
        karmasiklik_skoru += sorgu.count('JOIN')
        
        # Koşul sayısı
        karmasiklik_skoru += sorgu.count('AND') + sorgu.count('OR')
        
        # Fonksiyon kullanımı
        sql_fonksiyonlar = ['CONCAT', 'SUBSTRING', 'CAST', 'CONVERT']
        for fonk in sql_fonksiyonlar:
            karmasiklik_skoru += sorgu.count(fonk)
            
        return self.karmasiklik_degerlendirme(karmasiklik_skoru)
```

# Bağlam Tabanlı Kural Motoru

Sistemin tüm bu analizleri bir arada değerlendirmesi gerekir:

```python
class BaglamAnalizcisi:
    def __init__(self):
        self.girdi_analizcisi = GirdiAnalizcisi()
        self.karakter_analizcisi = KarakterAnalizcisi()
        self.tip_dogrulayici = VeriTipiDogrulayici()
        self.karmasiklik_degerlendiricisi = KarmasiklikDegerlendirici()
    
    def tam_analiz(self, sorgu, sorgu_tipi, alan_adi, deger):
        risk_puani = 0
        
        # Uzunluk kontrolü
        if not self.girdi_analizcisi.uzunluk_kontrol(sorgu_tipi, sorgu):
            risk_puani += 25
            
        # Karakter dağılımı kontrolü
        if self.karakter_analizcisi.karakter_dagilim_analizi(sorgu):
            risk_puani += 30
            
        # Veri tipi kontrolü
        if not self.tip_dogrulayici.tip_kontrol(alan_adi, deger)[0]:
            risk_puani += 20
            
        # Karmaşıklık değerlendirmesi
        karmasiklik = self.karmasiklik_degerlendiricisi.analiz_et(sorgu)
        risk_puani += karmasiklik * 5
        
        return risk_puani > 50  # Risk puanı 50'den büyükse saldırı olarak değerlendir
```

Bu bağlamsal algılama sistemi, her sorguyu kendi bağlamı içinde değerlendirir ve normal kullanımdan sapmaları tespit eder. Sistem sürekli olarak öğrenir ve kendini günceller, böylece zamanla daha da hassas hale gelir.


-----------------------

SQL veritabanı protokolünün analizi, bir nevi trafik polisinin yol kurallarını denetlemesine benzer. Nasıl ki trafik polisi araçların kurallara uygun hareket edip etmediğini kontrol ediyorsa, protokol analizi de SQL sorgularının veritabanı ile iletişim kurallarına uygunluğunu denetler.

# SQL Sözdizimi Doğrulama

Veritabanına gönderilen her sorgunun geçerli bir SQL sözdizimi olması gerekir. İşte bunu nasıl kontrol ettiğimizi inceleyelim:

```python
class SQLSozdizimiDogrulayici:
    def __init__(self):
        # SQL dilbilgisi kuralları ve anahtar kelimeler
        self.sql_keywords = set(['SELECT', 'FROM', 'WHERE', 'INSERT', 'UPDATE', 'DELETE'])
        self.valid_operators = set(['=', '>', '<', '>=', '<=', '<>', 'LIKE', 'IN'])
    
    def sozdizimiKontrol(self, sorgu):
        try:
            # Sorguyu parçalara ayır
            parcalar = self.sorguyuParcala(sorgu)
            
            # Her parçanın sözdizimi kurallarına uygunluğunu kontrol et
            for idx, parca in enumerate(parcalar):
                if parca.upper() in self.sql_keywords:
                    # Anahtar kelimeden sonra gelen yapının kontrolü
                    self.kontrolEt(parcalar[idx:])
                    
            return True, "Geçerli SQL sözdizimi"
            
        except SyntaxException as e:
            return False, f"Sözdizimi hatası: {str(e)}"
```

# Karakter Kodlama Kontrolü

SQL enjeksiyon saldırılarında sıkça kullanılan kodlanmış karakterlerin tespiti çok önemlidir:

```python
class KarakterKodlamaAnalizi:
    def __init__(self):
        self.tehlikeli_kodlamalar = {
            'hex': r'0x[0-9A-Fa-f]+',
            'unicode': r'u[0-9A-Fa-f]{4}',
            'url': r'%[0-9A-Fa-f]{2}',
            'ascii': r'CHAR\([0-9]+\)'
        }
    
    def kodlamaKontrol(self, sorgu):
        bulgular = []
        
        for kodlama_tipi, pattern in self.tehlikeli_kodlamalar.items():
            eslesmeler = re.finditer(pattern, sorgu)
            for eslesme in eslesmeler:
                bulgular.append({
                    'tip': kodlama_tipi,
                    'deger': eslesme.group(),
                    'pozisyon': eslesme.span()
                })
        
        return bulgular
```

# Protokol Uyum Kontrolü

Veritabanı protokolüne uygunluğun kontrolü şu şekilde yapılır:

```python
class ProtokolDenetleyici:
    def __init__(self):
        self.max_sorgu_boyutu = 1024 * 1024  # 1MB
        self.izinli_karakterset = 'UTF-8'
        self.izinli_islemler = {'SELECT', 'INSERT', 'UPDATE', 'DELETE'}
        
    def protokolKontrol(self, sorgu_paketi):
        kontroller = {
            'boyut': self.boyutKontrol(sorgu_paketi),
            'karakterset': self.karaktersetKontrol(sorgu_paketi),
            'islem_tipi': self.islemTipiKontrol(sorgu_paketi),
            'paket_yapisi': self.paketYapisiKontrol(sorgu_paketi)
        }
        
        return all(kontroller.values()), kontroller
```

# İşlem Sırası Kontrolü

Veritabanı işlemlerinin doğru sırada gerçekleştirilmesi gerekir:

```python
class IslemSirasiDenetleyici:
    def __init__(self):
        self.islem_sirasi = []
        self.beklenen_akislar = {
            'LOGIN': ['CONNECT', 'AUTHENTICATE', 'AUTHORIZE'],
            'QUERY': ['PREPARE', 'EXECUTE', 'FETCH'],
            'TRANSACTION': ['BEGIN', 'EXECUTE', 'COMMIT/ROLLBACK']
        }
    
    def siraKontrol(self, islem_tipi, adim):
        if islem_tipi in self.beklenen_akislar:
            beklenen_adimlar = self.beklenen_akislar[islem_tipi]
            
            if adim not in beklenen_adimlar:
                return False, f"Beklenmeyen işlem adımı: {adim}"
                
            if beklenen_adimlar.index(adim) != len(self.islem_sirasi):
                return False, "İşlem sırası hatası"
                
            self.islem_sirasi.append(adim)
            return True, "İşlem sırası geçerli"
```

# Anomali Tespiti

Protokol seviyesinde anormal durumların tespiti:

```python
class ProtokolAnomaliTespiti:
    def __init__(self):
        self.normal_parametreler = {
            'max_baglanti_suresi': 3600,  # 1 saat
            'max_sorgu_sayisi': 1000,     # Her bağlantı için
            'max_es_zamanli_sorgu': 10,   # Aynı anda
            'min_sorgu_araligi': 0.1      # saniye
        }
    
    def anomaliKontrol(self, baglanti_metrikleri):
        anomaliler = []
        
        if baglanti_metrikleri.sure > self.normal_parametreler['max_baglanti_suresi']:
            anomaliler.append("Aşırı uzun bağlantı süresi")
            
        if baglanti_metrikleri.sorgu_sayisi > self.normal_parametreler['max_sorgu_sayisi']:
            anomaliler.append("Aşırı sorgu sayısı")
            
        # Diğer kontroller...
        
        return len(anomaliler) == 0, anomaliler
```

Protokol analizi, SQL enjeksiyon saldırılarının tespitinde çok önemli bir rol oynar çünkü saldırganların protokol seviyesinde yaptıkları manipülasyonları tespit edebilir. Bu katman, diğer güvenlik katmanlarıyla birlikte çalışarak kapsamlı bir koruma sağlar.


-----------------------------

Makine öğrenimi tabanlı SQL enjeksiyon tespiti, sistemin sürekli öğrenen ve gelişen bir koruma mekanizması oluşturmasını sağlar. Bu yaklaşımı, deneyimli bir güvenlik uzmanının zamanla şüpheli davranışları daha iyi tanıması gibi düşünebiliriz.

# Özellik Çıkarımı (Feature Extraction)

Öncelikle, her SQL sorgusundan anlamlı özellikler çıkarılması gerekir:

```python
class OzellikCikarici:
    def __init__(self):
        self.ozellik_fonksiyonlari = {
            'uzunluk': len,
            'entropi': self.entropi_hesapla,
            'karakter_dagilimi': self.karakter_dagilimi_hesapla,
            'token_desenleri': self.token_desenleri_bul
        }
    
    def entropi_hesapla(self, metin):
        # Shannon entropi hesaplaması
        frekanslar = Counter(metin)
        entropi = 0
        for karakter in frekanslar:
            p = frekanslar[karakter] / len(metin)
            entropi -= p * log2(p)
        return entropi
    
    def karakter_dagilimi_hesapla(self, metin):
        # Özel karakterlerin dağılımını hesapla
        ozel_karakterler = set("'\"();/-*+")
        toplam = len(metin)
        
        return {
            'ozel_karakter_orani': sum(1 for c in metin if c in ozel_karakterler) / toplam,
            'rakam_orani': sum(c.isdigit() for c in metin) / toplam,
            'bosluk_orani': sum(c.isspace() for c in metin) / toplam
        }
```

# Öğrenme Modeli

Toplanan özellikleri kullanarak bir makine öğrenimi modeli eğitilir:

```python
from sklearn.ensemble import RandomForestClassifier

class SQLEnjeksiyonDetektoru:
    def __init__(self):
        self.model = RandomForestClassifier(
            n_estimators=100,
            max_depth=10,
            min_samples_split=5
        )
        self.ozellik_cikarici = OzellikCikarici()
        
    def egit(self, egitim_verileri, etiketler):
        # Eğitim verilerinden özellik çıkarımı
        X = []
        for sorgu in egitim_verileri:
            ozellikler = self.ozellikleri_hazirla(sorgu)
            X.append(ozellikler)
            
        # Modeli eğit
        self.model.fit(X, etiketler)
        
    def ozellikleri_hazirla(self, sorgu):
        ozellikler = []
        
        # Temel özellikler
        ozellikler.append(len(sorgu))  # Uzunluk
        ozellikler.append(self.ozellik_cikarici.entropi_hesapla(sorgu))  # Entropi
        
        # Karakter dağılımı özellikleri
        dagilim = self.ozellik_cikarici.karakter_dagilimi_hesapla(sorgu)
        ozellikler.extend(dagilim.values())
        
        return ozellikler
```

# Gerçek Zamanlı Tespit

Model eğitildikten sonra gerçek zamanlı tespit yapılabilir:

```python
class GercekZamanliDetector:
    def __init__(self):
        self.detector = SQLEnjeksiyonDetektoru()
        self.esik_degeri = 0.75  # Güven eşiği
        
    def sorgu_analiz(self, sorgu):
        # Özellikleri çıkar
        ozellikler = self.detector.ozellikleri_hazirla(sorgu)
        
        # Tahmin yap
        tahmin_olasiligi = self.detector.model.predict_proba([ozellikler])[0]
        
        if tahmin_olasiligi[1] > self.esik_degeri:
            return {
                'tehdit_tespit_edildi': True,
                'guven_skoru': tahmin_olasiligi[1],
                'analiz_detaylari': self.analiz_detaylarini_olustur(ozellikler)
            }
```

# Sürekli Öğrenme ve Güncelleme

Model, yeni örneklerle sürekli olarak güncellenir:

```python
class ModelGuncelleyici:
    def __init__(self, detector):
        self.detector = detector
        self.yeni_ornekler = []
        self.guncelleme_esigi = 1000  # Her 1000 örnekte bir güncelle
        
    def yeni_ornek_ekle(self, sorgu, etiket):
        self.yeni_ornekler.append((sorgu, etiket))
        
        if len(self.yeni_ornekler) >= self.guncelleme_esigi:
            self.modeli_guncelle()
            
    def modeli_guncelle(self):
        # Yeni örneklerle modeli güncelle
        X = []
        y = []
        
        for sorgu, etiket in self.yeni_ornekler:
            ozellikler = self.detector.ozellikleri_hazirla(sorgu)
            X.append(ozellikler)
            y.append(etiket)
            
        # Modeli yeni örneklerle güncelle
        self.detector.model.partial_fit(X, y)
        
        # Yeni örnekleri temizle
        self.yeni_ornekler = []
```

# Performans İzleme

Modelin başarısını sürekli olarak izlemek önemlidir:

```python
class PerformansIzleyici:
    def __init__(self):
        self.metrikler = {
            'yanlis_pozitif': 0,
            'yanlis_negatif': 0,
            'dogru_pozitif': 0,
            'dogru_negatif': 0
        }
        
    def metrik_guncelle(self, gercek_etiket, tahmin):
        if gercek_etiket == 1 and tahmin == 1:
            self.metrikler['dogru_pozitif'] += 1
        elif gercek_etiket == 0 and tahmin == 0:
            self.metrikler['dogru_negatif'] += 1
        elif gercek_etiket == 1 and tahmin == 0:
            self.metrikler['yanlis_negatif'] += 1
        else:
            self.metrikler['yanlis_pozitif'] += 1
            
    def performans_raporu_olustur(self):
        toplam = sum(self.metrikler.values())
        
        return {
            'dogruluk': (self.metrikler['dogru_pozitif'] + self.metrikler['dogru_negatif']) / toplam,
            'hassasiyet': self.metrikler['dogru_pozitif'] / (self.metrikler['dogru_pozitif'] + self.metrikler['yanlis_pozitif']),
            'geri_cagirma': self.metrikler['dogru_pozitif'] / (self.metrikler['dogru_pozitif'] + self.metrikler['yanlis_negatif'])
        }
```

Bu makine öğrenimi tabanlı sistem, geleneksel kural tabanlı yaklaşımların tespit edemediği karmaşık ve yeni saldırı türlerini bile tespit edebilir. Sistem sürekli öğrenerek ve kendini güncelleyerek zamanla daha da etkili hale gelir.


----------------------------------

SQL enjeksiyon saldırılarını tespit etmek için kullanılan yaygın kuralları detaylı olarak inceleyelim. Bu kurallar, bir dedektifin suç mahallinde aradığı tipik izlere benzer. Nasıl ki bir dedektif belirli kalıpları arar, güvenlik sistemleri de bu kurallar sayesinde potansiyel saldırıları tespit eder.

```python
class SQL_Injection_Detector:
    def __init__(self):
        # Çoklu tek tırnakların tespiti için kurallar
        self.tek_tirnak_kontrol(sorgu):
            # Ardışık tek tırnakları sayar
            ardisik_tirnak_sayisi = len(re.findall(r"'{2,}", sorgu))
            if ardisik_tirnak_sayisi > 0:
                return f"Uyarı: {ardisik_tirnak_sayisi} adet ardışık tek tırnak tespit edildi"
            
            # Tek tırnakların dengesini kontrol eder
            if sorgu.count("'") % 2 != 0:
                return "Uyarı: Dengesiz tek tırnak kullanımı"

        # Kodlanmış karakterlerin tespiti
        def kodlanmis_karakter_kontrol(self, sorgu):
            kodlanmis_karakterler = {
                'hex': re.compile(r'0x[0-9A-Fa-f]+'),
                'url': re.compile(r'%[0-9A-Fa-f]{2}'),
                'unicode': re.compile(r'\\u[0-9A-Fa-f]{4}'),
                'ascii': re.compile(r'CHAR\([0-9]+\)')
            }
            
            for kod_tipi, pattern in kodlanmis_karakterler.items():
                if pattern.search(sorgu):
                    return f"Uyarı: {kod_tipi} formatında kodlanmış karakter tespit edildi"
```

Yorum satırlarının tespiti özellikle önemlidir çünkü saldırganlar genellikle sorgunun kalan kısmını etkisiz hale getirmek için bunları kullanır:

```python
def yorum_kontrol(self, sorgu):
    yorum_kaliplari = {
        'cift_tire': '--',
        'hash': '#',
        'cok_satirli_baslangic': '/*',
        'cok_satirli_bitis': '*/'
    }
    
    tespit_edilen_yorumlar = []
    
    for yorum_tipi, kalip in yorum_kaliplari.items():
        if kalip in sorgu:
            # Yorumun bağlamını analiz et
            onceki_karakterler = sorgu[max(0, sorgu.find(kalip)-10):sorgu.find(kalip)]
            tespit_edilen_yorumlar.append({
                'tip': yorum_tipi,
                'pozisyon': sorgu.find(kalip),
                'baglam': onceki_karakterler
            })
            
    return tespit_edilen_yorumlar
```

SQL anahtar kelimelerinin beklenmeyen yerlerde kullanımını tespit etmek de kritik önem taşır:

```python
def sql_anahtar_kelime_kontrol(self, sorgu, beklenen_yer):
    tehlikeli_kelimeler = {
        'veri_manipulasyon': ['INSERT', 'UPDATE', 'DELETE', 'DROP', 'TRUNCATE'],
        'veri_sorgulama': ['UNION', 'SELECT', 'FROM', 'WHERE'],
        'sistem_komutlari': ['EXEC', 'EXECUTE', 'DECLARE', 'CAST']
    }
    
    for kategori, kelimeler in tehlikeli_kelimeler.items():
        for kelime in kelimeler:
            if kelime in sorgu.upper():
                pozisyon = sorgu.upper().find(kelime)
                if not self.kelime_beklenen_yerde_mi(pozisyon, beklenen_yer):
                    return f"Uyarı: '{kelime}' beklenmeyen pozisyonda kullanılmış"
```

Çoklu sorguların (stacked queries) tespiti için özel bir kontrol mekanizması gerekir:

```python
def coklu_sorgu_kontrol(self, sorgu):
    # Noktalı virgül sonrası anlamlı SQL komutu var mı kontrol et
    noktali_virgul_pozisyonlari = [m.start() for m in re.finditer(';', sorgu)]
    
    for pozisyon in noktali_virgul_pozisyonlari:
        kalan_kisim = sorgu[pozisyon+1:].strip()
        if self.anlamli_sql_komutu_mu(kalan_kisim):
            return f"Uyarı: Çoklu sorgu tespit edildi: {kalan_kisim}"
            
def anlamli_sql_komutu_mu(self, metin):
    sql_baslangic_kaliplari = [
        r'\s*SELECT\s+',
        r'\s*INSERT\s+',
        r'\s*UPDATE\s+',
        r'\s*DELETE\s+',
        r'\s*DROP\s+'
    ]
    
    return any(re.match(kalip, metin.upper()) for kalip in sql_baslangic_kaliplari)
```

Tüm bu kuralları bir araya getiren ana analiz fonksiyonu şöyle olabilir:

```python
def kapsamli_analiz(self, sorgu, baglam):
    tehditler = []
    
    # Tek tırnak kontrolü
    tek_tirnak_sonuc = self.tek_tirnak_kontrol(sorgu)
    if tek_tirnak_sonuc:
        tehditler.append(tek_tirnak_sonuc)
    
    # Kodlanmış karakter kontrolü
    kodlanmis_karakter_sonuc = self.kodlanmis_karakter_kontrol(sorgu)
    if kodlanmis_karakter_sonuc:
        tehditler.append(kodlanmis_karakter_sonuc)
    
    # Yorum kontrolü
    yorum_sonuclari = self.yorum_kontrol(sorgu)
    if yorum_sonuclari:
        tehditler.extend([f"Yorum yapısı tespit edildi: {y['tip']}" for y in yorum_sonuclari])
    
    # SQL anahtar kelime kontrolü
    anahtar_kelime_sonuc = self.sql_anahtar_kelime_kontrol(sorgu, baglam)
    if anahtar_kelime_sonuc:
        tehditler.append(anahtar_kelime_sonuc)
    
    # Çoklu sorgu kontrolü
    coklu_sorgu_sonuc = self.coklu_sorgu_kontrol(sorgu)
    if coklu_sorgu_sonuc:
        tehditler.append(coklu_sorgu_sonuc)
    
    return {
        'tehdit_var_mi': len(tehditler) > 0,
        'tehdit_sayisi': len(tehditler),
        'tehdit_detaylari': tehditler,
        'risk_seviyesi': self.risk_seviyesi_hesapla(tehditler)
    }
```

Bu kurallar sistemi, bilinen SQL enjeksiyon tekniklerinin çoğunu yakalayabilir. Ancak saldırganlar sürekli yeni teknikler geliştirdiğinden, bu kuralların da düzenli olarak güncellenmesi ve geliştirilmesi gerekir. Ayrıca bu kurallar tek başına yeterli değildir; diğer koruma katmanlarıyla birlikte kullanılmalıdır.


----------------------------------

SQL enjeksiyon saldırılarına karşı gelişmiş tespit yöntemlerini inceleyelim. Bu yöntemler, daha basit koruma katmanlarının üzerine inşa edilmiş, daha sofistike ve kapsamlı çözümlerdir. Bu konsepti bir bina güvenliği analojisi ile düşünebiliriz: Temel güvenlik önlemleri (kameralar, kilitler) önemliyken, gelişmiş sistemler (hareket sensörleri, biyometrik tarama, yapay zeka destekli gözetim) çok daha kapsamlı koruma sağlar.

```python
class GelismisDetectionSystem:
    def __init__(self):
        self.virtual_patcher = VirtualPatcher()
        self.heuristic_analyzer = HeuristicAnalyzer()
        self.anomaly_scorer = AnomalyScorer()
        self.traffic_learner = TrafficLearner()
        self.statistical_analyzer = StatisticalAnalyzer()

    def analyze_query(self, query, context):
        # Tüm gelişmiş analiz sonuçlarını birleştiren ana fonksiyon
        results = {}
        
        # Her bir analiz yönteminden gelen sonuçları topla
        results['virtual_patch'] = self.virtual_patcher.analyze(query)
        results['heuristic'] = self.heuristic_analyzer.analyze(query)
        results['anomaly'] = self.anomaly_scorer.calculate_score(query)
        results['traffic'] = self.traffic_learner.evaluate(query)
        results['statistical'] = self.statistical_analyzer.analyze(query)
        
        return self.combine_results(results)
```

Şimdi her bir gelişmiş tespit yöntemini detaylı olarak inceleyelim:

# 1. Sanal Yama (Virtual Patching)

```python
class VirtualPatcher:
    def __init__(self):
        self.patch_rules = self.load_patch_rules()
        self.vulnerability_patterns = self.load_vulnerability_patterns()
    
    def analyze(self, query):
        # Bilinen güvenlik açıklarına karşı kontrol
        potential_vulnerabilities = []
        
        for pattern, patch in self.vulnerability_patterns.items():
            if re.search(pattern, query):
                # Güvenlik açığı tespit edildi
                potential_vulnerabilities.append({
                    'pattern': pattern,
                    'suggested_patch': patch,
                    'risk_level': self.calculate_risk(pattern)
                })
                
                # Geçici koruma uygula
                query = self.apply_virtual_patch(query, patch)
                
        return query, potential_vulnerabilities
```

# 2. Sezgisel Analiz (Heuristic Analysis)

```python
class HeuristicAnalyzer:
    def __init__(self):
        self.known_patterns = self.load_attack_patterns()
        self.learning_threshold = 0.85
        
    def analyze(self, query):
        # Sezgisel kuralları uygula
        heuristic_scores = {
            'complexity': self.analyze_complexity(query),
            'structure': self.analyze_structure(query),
            'context': self.analyze_context(query),
            'history': self.analyze_historical_patterns(query)
        }
        
        # Yeni sezgisel kurallar öğren
        if self.should_learn_new_pattern(query, heuristic_scores):
            self.learn_new_pattern(query)
            
        return self.calculate_final_score(heuristic_scores)
```

# 3. Anomali Puanlama (Anomaly Scoring)

```python
class AnomalyScorer:
    def __init__(self):
        self.baseline_metrics = self.load_baseline_metrics()
        self.scoring_weights = self.initialize_weights()
        
    def calculate_score(self, query):
        # Her metrik için anomali puanı hesapla
        metric_scores = {
            'length': self.score_length_anomaly(query),
            'character_distribution': self.score_char_distribution(query),
            'syntax_complexity': self.score_syntax_complexity(query),
            'token_frequency': self.score_token_frequency(query)
        }
        
        # Ağırlıklı toplam hesapla
        final_score = sum(
            score * self.scoring_weights[metric] 
            for metric, score in metric_scores.items()
        )
        
        return final_score, metric_scores
```

# 4. Trafik Öğrenimi (Traffic Learning)

```python
class TrafficLearner:
    def __init__(self):
        self.traffic_patterns = {}
        self.learning_window = 3600  # 1 saat
        
    def evaluate(self, query):
        # Mevcut trafiği analiz et
        current_pattern = self.extract_pattern(query)
        
        # Normal trafik kalıplarıyla karşılaştır
        deviation_score = self.calculate_pattern_deviation(
            current_pattern, 
            self.traffic_patterns
        )
        
        # Trafiği sürekli öğren
        self.update_traffic_patterns(current_pattern)
        
        return {
            'deviation_score': deviation_score,
            'is_anomalous': deviation_score > self.get_threshold(),
            'pattern_details': current_pattern
        }
```

# 5. İstatistiksel Analiz (Statistical Analysis)

```python
class StatisticalAnalyzer:
    def __init__(self):
        self.distributions = self.load_statistical_distributions()
        self.confidence_level = 0.95
        
    def analyze(self, query):
        # Çeşitli istatistiksel ölçümleri hesapla
        measurements = {
            'z_score': self.calculate_z_score(query),
            'chi_square': self.perform_chi_square_test(query),
            'entropy': self.calculate_entropy(query),
            'distribution_fit': self.test_distribution_fit(query)
        }
        
        # Anormallik seviyesini hesapla
        anomaly_probability = self.calculate_anomaly_probability(measurements)
        
        return {
            'measurements': measurements,
            'anomaly_probability': anomaly_probability,
            'is_significant': anomaly_probability > self.confidence_level
        }
```

Tüm bu gelişmiş yöntemler birlikte çalışarak, tek başına hiçbir yöntemin yakalayamayacağı karmaşık saldırıları tespit edebilir. Bu sistemin güçlü yanı, farklı yaklaşımları birleştirerek daha kapsamlı bir koruma sağlamasıdır.
