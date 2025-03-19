https://github.com/OWASP/owasp-mastg/tree/master/Crackmes/Android

## **Genel Mantık**
Bu APK’lar, mobil güvenlik öğrenmek için OWASP tarafından hazırlanmış örnek uygulamalar. İçinde gizli bir dizgi (secret string) var ve amaç bunu bulmak. Uygulamalar, tersine mühendisliği zorlaştırmak için bazı korumalar kullanıyor. Biz de bu korumaları aşarak dizgiyi bulacağız.

### **Araçların Mantığı**
- **ADB**: Telefonla ya da emülatörle konuşmamızı sağlar. Dosya yollar, komut çalıştırır.
- **Jadx**: APK’yı açar ve içindeki Java kodunu okunabilir hale getirir.
- **Frida**: Uygulama çalışırken ona müdahale eder, kodunu değiştirir.
- **Ghidra**: Native kod (.so dosyaları) varsa, onu analiz eder.

---

## **UnCrackable-Level1.apk Analizi**

Bu seviye daha basit. Root kontrolü gibi temel bir koruma var ve gizli dizgi Java kodunda saklı.

### **Adım Adım Açıklama**

#### **1. APK’yı Cihaza Yükle**
- **Neden?**: Uygulamayı çalıştırmadan önce bir Android cihaza (veya emülatöre) koymamız lazım.
- **Mantık**: ADB, bilgisayardan telefona dosya yollar ve kurar.
- **Nasıl?**: APK dosyasını ADB ile yüklüyoruz.

| **Komut**                  | **Windows**                  | **macOS**                  | **Linux**                  |
|----------------------------|-----------------------------|----------------------------|----------------------------|
| `adb install UnCrackable-Level1.apk` | `adb install UnCrackable-Level1.apk` | `adb install UnCrackable-Level1.apk` | `adb install UnCrackable-Level1.apk` |

- **Sonuç**: Uygulama telefonda/emülatörde görünür.

#### **2. Uygulamayı Çalıştır ve Sorunu Gör**
- **Neden?**: Uygulamanın nasıl çalıştığını anlamak için önce açmamız lazım.
- **Mantık**: Uygulama, root’lu cihazda çalışmayı reddedebilir. Bu bir koruma.
- **Nasıl?**: Uygulamayı elle aç (telefonda simgesine tıkla).
- **Sonuç**: “Root detected” gibi bir hata alıp kapanabilir.

#### **3. APK’yı Jadx ile Çöz (Decompile Et)**
- **Neden?**: İçindeki kodu görmek için APK’yı açmamız lazım.
- **Mantık**: APK, bir ZIP dosyası gibi. İçinde sıkıştırılmış Java kodu var. Jadx bunu çözer ve okunabilir hale getirir.
- **Nasıl?**:
  1. Jadx’i indir (https://github.com/skylot/jadx/releases).
  2. Komutla çalıştır.

| **Komut**                  | **Windows**                  | **macOS**                  | **Linux**                  |
|----------------------------|-----------------------------|----------------------------|----------------------------|
| Jadx ile aç                | `jadx UnCrackable-Level1.apk` | `jadx UnCrackable-Level1.apk` | `jadx UnCrackable-Level1.apk` |

- **Sonuç**: Bir klasör oluşur (örneğin `UnCrackable-Level1`), içinde `sources` klasöründe Java kodları var.

#### **4. Kodu Jadx ile Oku**
- **Neden?**: Gizli dizgiyi ve korumaları bulmak için kodun ne yaptığını anlamalıyız.
- **Mantık**: Java kodunda, uygulamanın neyi kontrol ettiği ve dizgiyi nerede sakladığı yazıyor.
- **Nasıl?**:
  1. `sources` klasöründe `owasp/mstg/uncrackable1` yoluna git.
  2. `MainActivity.java` dosyasını aç.
  3. `onCreate` metoduna bak. Root kontrolü burada olabilir (örneğin `isRooted` diye bir fonksiyon).
  4. Gizli dizgi için `verify` veya `check` gibi bir metod ara.

- **Sonuç**: Root kontrolü ve dizgiyle ilgili ipuçları bulursun.

#### **5. Root Kontrolünü Frida ile Atlat**
- **Neden?**: Uygulama root kontrolüyle kapanıyorsa, bunu kandırmalıyız.
- **Mantık**: Frida, uygulamayı çalışırken “hack’ler” ve root kontrolünü geçersiz kılar.
- **Nasıl?**:
  1. Basit bir Frida scripti yaz (örnek aşağıda).
  2. Scripti çalıştır.

- **Örnek Script (`bypass_root.js`)**:
  ```javascript
  Java.perform(function() {
      var MainActivity = Java.use("owasp.mstg.uncrackable1.MainActivity");
      MainActivity.isRooted.implementation = function() {
          return false; // Her zaman "root yok" de
      };
  });
  ```

| **Komut**                  | **Windows**                  | **macOS**                  | **Linux**                  |
|----------------------------|-----------------------------|----------------------------|----------------------------|
| Frida ile çalıştır         | `frida -U -f owasp.mstg.uncrackable1 -l bypass_root.js` | `frida -U -f owasp.mstg.uncrackable1 -l bypass_root.js` | `frida -U -f owasp.mstg.uncrackable1 -l bypass_root.js` |

- **Sonuç**: Uygulama root kontrolünü atlar ve çalışır.

#### **6. Gizli Dizgiyi Kodda Bul**
- **Neden?**: Dizgi genelde kodda saklıdır ve bizim onu bulmamız lazım.
- **Mantık**: `verify` gibi bir metodda, kullanıcı girişini dizgiyle karşılaştırır. Dizgi burada olabilir.
- **Nasıl?**:
  1. `MainActivity.java` içinde `verify` metoduna bak.
  2. Mesela `strcmp` veya bir string karşılaştırması görürsen, dizgi orada olabilir.
- **Sonuç**: Dizgiyi bulursun (örneğin “secret123”).

#### **7. Dizgiyi Test Et**
- **Neden?**: Bulduğun şeyin doğru olup olmadığını kontrol etmeliyiz.
- **Mantık**: Uygulamada bir giriş kutusu varsa, dizgiyi yazıp denersin.
- **Nasıl?**: Uygulamayı aç, bulduğun dizgiyi yaz, “Success” mesajı alırsın.
- **Sonuç**: Tebrikler, Level 1 bitti!

---

## **UnCrackable-Level2.apk Analizi**

Bu seviye daha zor çünkü native kod (C ile yazılmış) kullanıyor. Ama mantığı yine basit tutacağım.

### **Adım Adım Açıklama**

#### **1. APK’yı Cihaza Yükle**
- **Neden?**: Analiz için uygulamayı çalıştırmalıyız.
- **Mantık**: Yine ADB ile yüklüyoruz.

| **Komut**                  | **Windows**                  | **macOS**                  | **Linux**                  |
|----------------------------|-----------------------------|----------------------------|----------------------------|
| `adb install UnCrackable-Level2.apk` | `adb install UnCrackable-Level2.apk` | `adb install UnCrackable-Level2.apk` | `adb install UnCrackable-Level2.apk` |

#### **2. APK’yı Jadx ile Çöz**
- **Neden?**: Java koduna bakacağız ama bu sefer native kod da var.
- **Mantık**: Jadx, Java kısmını çözer, native için başka araç gerekecek.

| **Komut**                  | **Windows**                  | **macOS**                  | **Linux**                  |
|----------------------------|-----------------------------|----------------------------|----------------------------|
| `jadx UnCrackable-Level2.apk` | `jadx UnCrackable-Level2.apk` | `jadx UnCrackable-Level2.apk` | `jadx UnCrackable-Level2.apk` |

#### **3. Java Koduna Bak**
- **Neden?**: Native kodun nereye bağlandığını anlamalıyız.
- **Mantık**: Java, native fonksiyonları çağırır. Bu bağlantıyı bulacağız.
- **Nasıl?**:
  1. `MainActivity.java` dosyasını aç.
  2. `System.loadLibrary("native-lib")` gibi bir şey ara.
  3. `native` diye işaretlenmiş metodlara bak (örneğin `public native String verify()`).

- **Sonuç**: Native kodun adı ve ne yaptığı hakkında fikir edinirsin.

#### **4. Native Kodu Ghidra ile İncele**
- **Neden?**: Gizli dizgi büyük ihtimalle native kodda.
- **Mantık**: `.so` dosyaları C ile yazılmış. Ghidra bunu açar ve bize gösterir.
- **Nasıl?**:
  1. Ghidra’yı indir (https://ghidra-sre.org/).
  2. `resources/lib/armeabi-v7a/libnative-lib.so` dosyasını Ghidra’ya yükle.
  3. `verify` fonksiyonunu bul (Java’dan çağrılan isimle eşleşir).
  4. İçinde dizgiyle karşılaştırma yapan yeri ara.

- **Sonuç**: Dizgiyi veya mantığını bulursun.

#### **5. Java Kontrollerini Frida ile Atlat**
- **Neden?**: Uygulama yine root veya başka kontrol yapıyorsa, geçmeliyiz.
- **Mantık**: Frida ile Java fonksiyonlarını kandırırız.

- **Örnek Script (`bypass_java.js`)**:
  ```javascript
  Java.perform(function() {
      var MainActivity = Java.use("owasp.mstg.uncrackable2.MainActivity");
      MainActivity.isRooted.implementation = function() {
          return false;
      };
  });
  ```

| **Komut**                  | **Windows**                  | **macOS**                  | **Linux**                  |
|----------------------------|-----------------------------|----------------------------|----------------------------|
| `frida -U -f owasp.mstg.uncrackable2 -l bypass_java.js` | Aynı | Aynı | Aynı |

#### **6. Native Koda Frida ile Bulaş**
- **Neden?**: Dizgi native kodda saklıysa, Frida ile onu çekeriz.
- **Mantık**: Native fonksiyonu izler ve dizgiyi konsola yazdırırız.
- **Nasıl?**:
  - Örnek Script (`hook_native.js`):
    ```javascript
    Interceptor.attach(Module.findExportByName("libnative-lib.so", "Java_owasp_mstg_uncrackable2_MainActivity_verify"), {
        onEnter: function(args) {
            console.log("Girdi: " + Memory.readUtf8String(args[2]));
        },
        onLeave: function(retval) {
            console.log("Çıktı: " + retval);
        }
    });
    ```

| **Komut**                  | **Windows**                  | **macOS**                  | **Linux**                  |
|----------------------------|-----------------------------|----------------------------|----------------------------|
| `frida -U -f owasp.mstg.uncrackable2 -l hook_native.js` | Aynı | Aynı | Aynı |

- **Sonuç**: Konsolda gizli dizgi çıkar.

#### **7. Dizgiyi Test Et**
- **Neden?**: Bulduğumuzun doğru olduğunu kontrol edelim.
- **Mantık**: Uygulamada yazıp “Success” alırsak, doğru demektir.
- **Nasıl?**: Uygulamaya gir, dizgiyi yaz, sonucu gör.

---

## **Sonuç ve İpuçları**
- **Neden Yaptık?**: Her adım, korumaları aşmak ve gizli dizgiyi bulmak içindi.
- **Mantık**: Kodun nasıl çalıştığını anlamak ve ona müdahale etmek.
- **İpucu**: Script yazarken hata olursa, internetten örnek bak. Frida çok güçlü bir araç!
- **Eğlence**: Bunlar sadece öğrenmek için. Gerçek hayatta kötü şeyler yapma!
