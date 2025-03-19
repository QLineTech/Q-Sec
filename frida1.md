### Araçların Mantığı ve Kullanımı

| **Araç**         | **Mantık**                                      | **Kullanım**                              |
|-------------------|------------------------------------------------|-------------------------------------------|
| **Frida**        | Uygulamaları çalıştığı anda değiştirmeye yarar. | Kod değiştirmeden analiz, SSL atlama.     |
| **Frida Server** | Android cihazda Frida’yı çalıştırır.           | Cihazda komutları yürütme.                |
| **Genymotion**   | Sanal Android cihaz oluşturur.                 | Uygulama test etme, kolay yönetim.         |
| **Burp Suite**   | Uygulama trafiğini izler ve değiştirir.        | Güvenlik testi, HTTPS analiz etme.        |
| **ADB**          | Android cihazlarla bağlantı kurar.             | Uygulama yükleme, dosya aktarma.          |

---

### Kurulum ve Kullanım Adımları

#### 1. Ön Koşulları Kurma
- Araçların çalışması için gerekli temel yazılımlar.

| **Adım**         | **Windows 11**                       | **macOS**                       | **Linux**                       |
|-------------------|--------------------------------------|---------------------------------|---------------------------------|
| **Python Kur**   | Python.org’dan indir, kur. PATH ekle.| `brew install python`          | `sudo apt-get install python3` |
| **Git Kur**      | Git-scm.com’dan indir, kur.          | `brew install git`             | `sudo apt-get install git`     |
| **ADB Kur**      | Android SDK indir, PATH’e ekle.      | `brew install android-platform-tools` | `sudo apt-get install android-tools-adb` |
| **Kontrol Et**   | `python --version` <br> `adb --version` | `python3 --version` <br> `adb --version` | `python3 --version` <br> `adb --version` |

---

#### 2. Frida ve Frida-Tools Kurma
- Frida ile uygulamaları analiz edebilirsin.

| **Adım**            | **Windows 11**                       | **macOS**                       | **Linux**                       |
|----------------------|--------------------------------------|---------------------------------|---------------------------------|
| **Frida-Tools Kur** | `pip install frida-tools`           | `pip3 install frida-tools`     | `pip3 install frida-tools`     |
| **Kontrol Et**      | `frida --version`                   | `frida --version`              | `frida --version`              |
| **Frida Server Al** | GitHub’dan indir (android-x86).     | GitHub’dan indir (android-x86).| GitHub’dan indir (android-x86).|
| **Yerleştir**       | 7-Zip ile aç, `C:\frida`’ya taşı.   | `xz -d frida-server-x.y.z-android-x86.xz` <br> `mv frida-server-x.y.z-android-x86 /usr/local/bin/frida-server` | `xz -d frida-server-x.y.z-android-x86.xz` <br> `sudo mv frida-server-x.y.z-android-x86 /usr/local/bin/frida-server` |

---

#### 3. Genymotion Kurma
- Sanal Android cihaz için kullanılır.

| **Adım**            | **Windows 11**                       | **macOS**                       | **Linux**                       |
|----------------------|--------------------------------------|---------------------------------|---------------------------------|
| **İndir ve Kur**    | Genymotion.com’dan indir, kur.       | Genymotion.com’dan indir, kur. | Genymotion.com’dan indir, kur. |
| **Cihaz Ekle**      | “+” ile cihaz ekle (örn. Galaxy S10).| “+” ile cihaz ekle.            | “+” ile cihaz ekle.            |
| **Cihazı Başlat**   | “Start” ile başlat.                  | “Start” ile başlat.            | “Start” ile başlat.            |
| **ADB Kontrol**     | `adb devices`                       | `adb devices`                  | `adb devices`                  |

---

#### 4. Burp Suite Kurma
- Trafik izlemek için proxy aracı.

| **Adım**            | **Windows 11**                       | **macOS**                       | **Linux**                       |
|----------------------|--------------------------------------|---------------------------------|---------------------------------|
| **İndir ve Kur**    | Portswigger.net’ten indir, kur.     | Portswigger.net’ten indir, kur.| Portswigger.net’ten indir, kur.|
| **Proxy Ayarla**    | Port `8080`, “All interfaces” seç.   | Port `8080`, “All interfaces”. | Port `8080`, “All interfaces”. |
| **Sertifika Al**    | DER formatında kaydet (burp-cert.der). | DER formatında kaydet.       | DER formatında kaydet.         |

---

#### 5. Genymotion’a Burp Sertifikası Kurma
- HTTPS trafiğini görmek için gerekli.

| **Adım**            | **Windows 11**                       | **macOS**                       | **Linux**                       |
|----------------------|--------------------------------------|---------------------------------|---------------------------------|
| **Sertifikayı Yükle**| `adb push C:\burp\burp-cert.der /sdcard/Download/` | `adb push ~/burp-cert.der /sdcard/Download/` | `adb push ~/burp-cert.der /sdcard/Download/` |
| **Kur (Android 9-)**| Ayarlar > Güvenlik > Sertifika Kur. | Ayarlar > Güvenlik > Sertifika.| Ayarlar > Güvenlik > Sertifika.|

---

#### 6. Genymotion’da Proxy Ayarlama
- Trafiği Burp’a yönlendirme.

| **Adım**            | **Windows 11**                       | **macOS**                       | **Linux**                       |
|----------------------|--------------------------------------|---------------------------------|---------------------------------|
| **Proxy Gir**       | Wi-Fi > Modify > Proxy > IP:Port (örn. 192.168.x.x:8080) | Wi-Fi > Modify > Proxy > IP:Port | Wi-Fi > Modify > Proxy > IP:Port |
| **Test Et**         | Tarayıcı aç, Burp’ta trafik gör.     | Tarayıcı aç, Burp’ta trafik gör.| Tarayıcı aç, Burp’ta trafik gör.|

---

#### 7. Frida Server’ı Genymotion’a Kurma
- Frida’yı cihazda çalıştırma.

| **Adım**            | **Windows 11**                       | **macOS**                       | **Linux**                       |
|----------------------|--------------------------------------|---------------------------------|---------------------------------|
| **Yükle**           | `adb push C:\frida\frida-server /data/local/tmp/` | `adb push /usr/local/bin/frida-server /data/local/tmp/` | `adb push /usr/local/bin/frida-server /data/local/tmp/` |
| **Çalıştır**        | `adb shell` <br> `chmod 755 /data/local/tmp/frida-server` <br> `/data/local/tmp/frida-server &` | `adb shell` <br> `chmod 755 /data/local/tmp/frida-server` <br> `/data/local/tmp/frida-server &` | `adb shell` <br> `chmod 755 /data/local/tmp/frida-server` <br> `/data/local/tmp/frida-server &` |
| **Kontrol Et**      | `frida-ps -U`                       | `frida-ps -U`                  | `frida-ps -U`                  |

---

#### 8. Uygulama Trafiğini İzleme
- Burp ile trafiği analiz etme.

| **Adım**            | **Windows 11**                       | **macOS**                       | **Linux**                       |
|----------------------|--------------------------------------|---------------------------------|---------------------------------|
| **Uygulama Yükle**  | `adb install path\to\app.apk`       | `adb install path/to/app.apk`  | `adb install path/to/app.apk`  |
| **Başlat ve İzle**  | Uygulamayı aç, Burp’ta kontrol et.  | Uygulamayı aç, Burp’ta kontrol.| Uygulamayı aç, Burp’ta kontrol.|
| **SSL Atla (Gerekirse)** | `frida -U -f com.example.app -l C:\ssl-bypass.js --no-pause` | `frida -U -f com.example.app -l /path/to/ssl-bypass.js --no-pause` | `frida -U -f com.example.app -l /path/to/ssl-bypass.js --no-pause` |

---

### İpuçları
- **Trafik Görünmüyorsa**: Proxy ayarlarını, sertifikayı kontrol et.
- **Frida Çalışmıyorsa**: Frida Server’ı yeniden başlat, ADB’yi kontrol et.
- **Sorun Varsa**: Araçları güncelle.
