## **ADB Nedir ve Neden Kullanılır?**
- **Tanım**: ADB, bilgisayardan Android cihazlara (telefon, emülatör) komut göndermeni sağlayan bir araçtır.
- **Genel Kullanım**: Uygulama yükleme, dosya aktarma, cihaz kontrolü.
- **Tersine Mühendislikte Kullanım**: APK yükleme, cihazdan dosya çekme, uygulamaları izleme gibi işler için çok önemlidir.

---

## **ADB Kurulumu**
- **Neden?**: ADB’yi kullanmadan önce sistemine kurman lazım.
- **Mantık**: Bilgisayar, Android cihazla konuşabilmek için bu aracı tanır.
- **Adımlar**:
  1. Android SDK Platform Tools’u indir: [developer.android.com](https://developer.android.com/studio/releases/platform-tools).
  2. ZIP dosyasını aç (örneğin `C:\adb` ya da `/usr/local/adb`).
  3. PATH’e ekle:
     - **Windows**: Sistem Ayarları > Ortam Değişkenleri > Path’e ekle.
     - **macOS/Linux**: Terminalde `export PATH=$PATH:/usr/local/adb` yaz.

- **Kontrol**: Terminal aç, `adb version` yaz. Versiyon çıkarsa kurulum tamam!

---

## **Temel ADB Komutları ve Kullanımları**

### **Tablo: Genel ve Tersine Mühendislik Kullanımları**
| **Komut**                  | **Ne İşe Yarar?**                              | **Genel Kullanım Örneği**                  | **Tersine Mühendislikte Kullanımı**                       |
|----------------------------|-----------------------------------------------|--------------------------------------------|---------------------------------------------------------|
| `adb devices`             | Bağlı cihazları listeler.                    | Hangi cihazların bağlı olduğunu gör.       | Analiz yapacağın cihazı kontrol et (örneğin emülatör).   |
| `adb install <dosya>.apk` | APK’yı cihaza yükler.                        | Yeni bir uygulamayı telefona kur.          | Test için APK’yı emülatöre yükle (örneğin UnCrackable). |
| `adb uninstall <paket>`   | Uygulamayı kaldırır.                         | Gereksiz bir uygulamayı sil.               | Eski sürümü temizleyip yeni APK’yı yükle.              |
| `adb push <dosya> <hedef>`| Bilgisayardan cihaza dosya yollar.           | Fotoğraf ya da dosya aktar.                | Frida Server’ı cihaza gönder (örneğin `/data/local/tmp`). |
| `adb pull <hedef> <dosya>`| Cihazdan bilgisayara dosya çeker.            | Telefondan bir şey indir.                  | APK ya da veri dosyalarını analiz için çek.            |
| `adb shell`               | Cihazda terminal açar.                       | Cihazda komut çalıştır (örneğin `ls`).     | Cihazda dosya gez, süreçleri kontrol et.               |
| `adb shell pm list packages` | Yüklü uygulamaların paket adlarını listeler. | Telefonda neler var gör.                   | Hedef uygulamanın paket adını bul (örneğin `owasp...`). |
| `adb shell dumpsys`       | Cihaz hakkında bilgi döker.                  | Sistem durumunu kontrol et.                | Uygulamanın çalıştığı süreçleri analiz et.             |
| `adb logcat`              | Cihazın loglarını (günlüklerini) gösterir.   | Uygulama çökerse hata bul.                 | Uygulamanın debug mesajlarını izle, ipucu yakala.       |
| `adb shell ps`            | Çalışan süreçleri listeler.                  | Hangi uygulamalar açık gör.                | Hedef uygulamanın PID’sini bul, Frida ile bağlan.       |

---

## **Tersine Mühendislikte ADB Kullanımı: Adım Adım Açıklama**

### **1. Cihazı Kontrol Et (`adb devices`)**
- **Neden?**: Hangi cihazla çalışacağını bilmen lazım.
- **Mantık**: Birden fazla cihaz bağlıysa (telefon, emülatör), doğru olanı seçersin.
- **Örnek**: 
  ```
  adb devices
  ```
  Çıktı: `emulator-5554   device` (emülatör bağlı).

### **2. APK Yükle (`adb install`)**
- **Neden?**: Analiz edeceğin uygulamayı cihaza kurman gerek.
- **Mantık**: APK’yı çalıştırıp davranışını izleyeceksin.
- **Örnek**: 
  ```
  adb install UnCrackable-Level1.apk
  ```
  Çıktı: `Success` (kurulum tamam).

### **3. Dosya Aktar (`adb push` ve `adb pull`)**
- **Neden?**: Tersine mühendislikte araçları (Frida Server gibi) cihaza yollaman veya cihazdan dosya alman lazım.
- **Mantık**: Frida Server cihaza gidip çalışmalı, ya da APK’yı çekip Jadx ile açmalısın.
- **Örnek**:
  - Frida Server yolla:
    ```
    adb push frida-server /data/local/tmp/
    ```
  - APK’yı çek:
    ```
    adb pull /data/app/owasp.mstg.uncrackable1-1/base.apk uncrackable1.apk
    ```

### **4. Shell ile Cihaza Gir (`adb shell`)**
- **Neden?**: Cihazda komut çalıştırmak için terminal açman lazım.
- **Mantık**: Dosya gezmek, izin vermek ya da Frida’yı başlatmak için kullanırsın.
- **Örnek**:
  ```
  adb shell
  ```
  İçinde: 
  ```
  cd /data/local/tmp
  chmod 755 frida-server
  ./frida-server &
  ```

### **5. Paket Adını Bul (`adb shell pm list packages`)**
- **Neden?**: Uygulamanın tam adını bilmezsen Frida gibi araçlarla ona bağlanamazsın.
- **Mantık**: Her uygulamanın bir “paket adı” var (örneğin `com.example.app`).
- **Örnek**:
  ```
  adb shell pm list packages | grep owasp
  ```
  Çıktı: `package:owasp.mstg.uncrackable1`.

### **6. Logları İzle (`adb logcat`)**
- **Neden?**: Uygulamanın ne yaptığını anlamak için mesajlarını görürsün.
- **Mantık**: Uygulama hata verirse veya gizli bir şey yazarsa, buradan yakalarsın.
- **Örnek**:
  ```
  adb logcat | grep uncrackable
  ```
  Çıktı: Uygulamanın debug mesajları.

### **7. Süreçleri Gör (`adb shell ps`)**
- **Neden?**: Uygulamanın çalıştığını ve PID’sini (süreç numarası) bulman lazım.
- **Mantık**: Frida ile bağlanmak için PID gerekebilir.
- **Örnek**:
  ```
  adb shell ps | grep owasp
  ```
  Çıktı: `app_123  4567  ...  owasp.mstg.uncrackable1`.

---

## **Tersine Mühendislikte Örnek Senaryo**
**Hedef**: UnCrackable-Level1.apk’da gizli dizgiyi bulmak.

1. **Cihazı Kontrol Et**:
   ```
   adb devices
   ```
   Emülatör bağlı mı, gör.

2. **APK’yı Yükle**:
   ```
   adb install UnCrackable-Level1.apk
   ```

3. **Frida Server’ı Yolla**:
   ```
   adb push frida-server /data/local/tmp/
   adb shell
   chmod 755 /data/local/tmp/frida-server
   ./frida-server &
   ```

4. **Paket Adını Bul**:
   ```
   adb shell pm list packages | grep owasp
   ```
   Çıktı: `owasp.mstg.uncrackable1`.

5. **Logları İzle**:
   ```
   adb logcat
   ```
   Uygulamayı aç, root kontrolü hata verirse gör.

6. **Sonuç**: Frida ile root kontrolünü atlatıp dizgiyi bulmak için hazırız.

---

## **Son İpuçları**
- **Hata Alırsan**: `adb devices` ile cihazın bağlı olduğundan emin ol.
- **Kolaylık**: Komutları bir dosyaya yazıp çalıştırabilirsin (örneğin `script.sh`).
- **Öğren**: Her komutu denedikçe mantığını kavrarsın!
