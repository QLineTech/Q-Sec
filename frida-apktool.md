## **Apktool Nedir ve Neden Kullanılır?**
- **Tanım**: Apktool, Android APK dosyalarını açıp (decompile) içindeki kaynak dosyalarını ve kodunu incelememizi sağlayan bir araçtır.
- **Genel Kullanım**: APK’yı çözmek, dosyalarını görmek, değiştirmek ve tekrar paketlemek (rebuild).
- **Tersine Mühendislikte Kullanım**: Uygulamanın kaynak kodunu (smali) ve manifest dosyasını analiz etmek, korumaları atlatmak veya içeriği değiştirmek için kullanılır.

---

## **Apktool Kurulumu**
- **Neden?**: Apktool’u kullanmadan önce sistemine kurman lazım.
- **Mantık**: APK dosyalarını açıp değiştirebilmek için bu araç bilgisayarda çalışmalı.
- **Adımlar**:
  1. Apktool’u indir: [Apktool resmi sitesi](https://ibotpeaches.github.io/Apktool/).
     - `.jar` dosyasını al (örneğin `apktool_2.x.x.jar`).
  2. Dosyayı kolay bir yere koy (örneğin `C:\apktool` veya `/usr/local/apktool`).
  3. Çalıştırmak için Java kurulu olmalı:
     - Java’yı indir: [java.com](https://www.java.com).
     - Kontrol et: `java -version` (versiyon çıkmalı).
  4. Terminalden kolay erişim için PATH’e ekle (isteğe bağlı).

- **Kontrol**: Terminalde `java -jar apktool_2.x.x.jar` yaz, hata yoksa kurulum tamam!

---

## **Temel Apktool Komutları ve Kullanımları**

### **Tablo: Genel ve Tersine Mühendislik Kullanımları**
| **Komut**                          | **Ne İşe Yarar?**                              | **Genel Kullanım Örneği**                  | **Tersine Mühendislikte Kullanımı**                       |
|------------------------------------|-----------------------------------------------|--------------------------------------------|---------------------------------------------------------|
| `apktool d <dosya>.apk`           | APK’yı çözer (decompile).                    | APK’nın içeriğini görmek.                  | Kod (smali) ve kaynak dosyalarını analiz et.            |
| `apktool b <klasör>`              | Çözülen dosyaları tekrar APK yapar (rebuild). | Değiştirilmiş APK’yı paketlemek.           | Kodu veya dosyaları değiştirdikten sonra APK oluştur.   |
| `apktool if <framework>.apk`      | Sistem framework’ünü kurar.                  | Sistem dosyalarını çözmek için gerekli.    | Sistem uygulamalarını analiz ederken kullan.            |
| `apktool d -f <dosya>.apk`        | Var olan klasörü silip yeniden çözer.        | Eski dosyaları temizleyip baştan başlar.   | Hatalı çözümleri düzeltmek için.                        |
| `apktool d -s <dosya>.apk`        | Sadece kaynakları çözer, smali’yi atlar.     | Hızlıca manifest veya resimleri görmek.    | Kodla uğraşmadan dosyaları incele.                      |

---

## **Tersine Mühendislikte Apktool Kullanımı: Adım Adım Açıklama**

### **1. APK’yı Çöz (`apktool d`)**
- **Neden?**: APK’nın içindeki kod ve dosyaları görmek istiyoruz.
- **Mantık**: APK, sıkıştırılmış bir dosyadır. Apktool bunu açar ve:
  - `smali` dosyaları (Java kodunun düşük seviyeli hali),
  - `AndroidManifest.xml` (uygulamanın izinleri ve ayarları),
  - `res` klasörü (resimler, layout’lar) çıkar.
- **Nasıl?**:
  ```
  apktool d UnCrackable-Level1.apk
  ```
- **Sonuç**: `UnCrackable-Level1` adında bir klasör oluşur. İçinde tüm dosyalar var.

### **2. Çözülen Dosyaları İncele**
- **Neden?**: Uygulamanın nasıl çalıştığını anlamak için içeriğe bakmamız lazım.
- **Mantık**: Her dosya bir ipucu verir:
  - **AndroidManifest.xml**: Uygulamanın paket adını, izinlerini gösterir.
  - **smali**: Kodun düşük seviyeli hali, gizli dizgiler veya kontroller burada olabilir.
  - **res**: Kullanıcı arayüzü dosyaları (örneğin şifre kutusu).
- **Nasıl?**:
  1. `UnCrackable-Level1/AndroidManifest.xml` dosyasını aç.
     - Paket adı: `owasp.mstg.uncrackable1`.
  2. `smali/owasp/mstg/uncrackable1/MainActivity.smali` dosyasını aç.
     - `const-string` gibi satırlarda gizli dizgi olabilir.
- **Sonuç**: Kodda root kontrolü veya dizgiyle ilgili bir şey bulursun.

### **3. Dosyaları Değiştir**
- **Neden?**: Korumaları kaldırmak veya dizgiyi ortaya çıkarmak istiyoruz.
- **Mantık**: Smali dosyalarını düzenleyerek uygulamayı “kandırabilirsin”.
- **Nasıl?**:
  - Örnek: Root kontrolünü atlatmak.
    1. `MainActivity.smali` içinde `isRooted` metodunu bul.
    2. `if-eqz` (eğer root varsa) gibi bir kontrol varsa, bunu `const/4 v0, 0x0` (her zaman false) ile değiştir.
- **Sonuç**: Uygulama root kontrolünü atlar.

### **4. APK’yı Tekrar Paketle (`apktool b`)**
- **Neden?**: Değişiklikleri test etmek için APK’yı yeniden oluşturmalıyız.
- **Mantık**: Çözülen dosyalar bir klasörde. Apktool bunları birleştirip APK yapar.
- **Nasıl?**:
  ```
  apktool b UnCrackable-Level1
  ```
- **Sonuç**: `UnCrackable-Level1/dist/UnCrackable-Level1.apk` dosyası oluşur.

### **5. APK’yı İmzala ve Yükle**
- **Neden?**: Android, imzasız APK’ları çalıştırmaz.
- **Mantık**: APK’yı yeniden paketledikten sonra bir imza eklemeliyiz.
- **Nasıl?**:
  1. **Apksigner** veya **jarsigner** kullan:
     - Basit bir imza için `keytool` ile anahtar oluştur:
       ```
       keytool -genkey -v -keystore mykey.keystore -alias alias -keyalg RSA -keysize 2048 -validity 10000
       ```
     - APK’yı imzala:
       ```
       jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore mykey.keystore UnCrackable-Level1.apk alias
       ```
  2. Cihaza yükle:
     ```
     adb install UnCrackable-Level1.apk
     ```
- **Sonuç**: Değiştirilmiş APK çalışır.

---

## **Tersine Mühendislikte Örnek Senaryo**
**Hedef**: UnCrackable-Level1.apk’da root kontrolünü atlatıp dizgiyi bulmak.

1. **APK’yı Çöz**:
   ```
   apktool d UnCrackable-Level1.apk
   ```

2. **Root Kontrolünü Bul ve Değiştir**:
   - `smali/owasp/mstg/uncrackable1/MainActivity.smali` aç.
   - `invoke-static {p0}, Lowasp/mstg/uncrackable1/a;->a(Landroid/content/Context;)Z` (root kontrolü) bul.
   - `move-result v0` sonrası `if-eqz v0` varsa, `const/4 v0, 0x0` ile değiştir.

3. **APK’yı Paketle**:
   ```
   apktool b UnCrackable-Level1
   ```

4. **İmzala ve Yükle**:
   ```
   jarsigner -keystore mykey.keystore UnCrackable-Level1/dist/UnCrackable-Level1.apk alias
   adb install UnCrackable-Level1/dist/UnCrackable-Level1.apk
   ```

5. **Sonuç**: Uygulama root kontrolü olmadan çalışır, dizgiyi bulmak kolaylaşır.

---

## **Son İpuçları**
- **Hata Alırsan**: `apktool d -f` ile eski dosyaları silip tekrar dene.
- **Smali Zor Gelirse**: Küçük değişikliklerle başla, alıştıkça öğrenirsin.
- **Java Gerekiyor**: Apktool bir Java aracı, Java’nın kurulu olduğundan emin ol.
