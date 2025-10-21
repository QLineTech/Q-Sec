## Ödev Senaryoları: Basitten Zora Unix/Linux Komutları

### Başlangıç Seviyesi Ödevler
Bu seviye, Unix/Linux terminaline yeni başlayanlar için temel gezinme ve dosya işlemlerine odaklanır. Amaç, temel komutların (pwd, cd, ls, touch, mkdir, cp, mv) kullanımını anlamaktır.

#### Ödev 1: Dizin Yapısı Oluşturma ve Dosya İşlemleri
**Senaryo:** Bir proje için aşağıdaki dizin yapısını oluşturmanız gerekiyor:
```
~/Egitim/
├── dersler/
│   ├── notlar.txt
│   └── odevler.txt
├── kaynaklar/
│   └── referans.pdf
└── scriptler/
    └── komutlar.sh
```
**Talimatlar:**
1. **Dizinleri oluşturun:**
   - `mkdir` komutunu kullanarak `~/Egitim` dizinini ve alt dizinlerini (`dersler`, `kaynaklar`, `scriptler`) oluşturun. İç içe dizinler için `-p` seçeneğini kullanın.
   - Örnek komut: `mkdir -p ~/Egitim/dersler`
2. **Dosyaları oluşturun:**
   - `touch` komutunu kullanarak her dizinde belirtilen dosyaları oluşturun (örn. `notlar.txt`, `odevler.txt`, `referans.pdf`, `komutlar.sh`).
   - Örnek komut: `touch ~/Egitim/dersler/notlar.txt`
3. **Dosyalara içerik ekleyin:**
   - `nano` veya `cat` komutunu kullanarak her dosyaya bir satır içerik ekleyin. Örneğin:
     - `notlar.txt`: "Unix temel komutlar dersi"
     - `odevler.txt`: "Hafta 1 ödev listesi"
     - `referans.pdf`: "Linux komutları referansı"
     - `komutlar.sh`: "#!/bin/bash\n echo Merhaba"
   - Örnek komut: `echo "Unix temel komutlar dersi" > ~/Egitim/dersler/notlar.txt`
4. **Kontrol edin:**
   - `ls -R ~/Egitim` komutunu kullanarak dizin yapısını ve dosyaları listeleyin.
   - `cat` komutuyla her dosyanın içeriğini kontrol edin (örn. `cat ~/Egitim/dersler/notlar.txt`).
5. **Teslim:**
   - Oluşturduğunuz dizin yapısını ve dosya içeriklerini gösteren bir ekran çıktısı alın (örn. `ls -R` ve `cat` komutlarının çıktıları).

**Açıklama:** Bu ödev, `mkdir`, `touch`, `cat`, `echo`, ve `ls` komutlarının temel kullanımını öğretir. `-p` seçeneğiyle iç içe dizin oluşturma ve `cat` ile dosya içeriği ekleme/görüntüleme pratiği yapılır.

---

#### Ödev 2: Dosya Taşıma ve Kopyalama
**Senaryo:** `~/Egitim` dizinindeki dosyaları düzenlemeniz gerekiyor. Bazı dosyaları kopyalayacak ve taşıyacaksınız.
**Talimatlar:**
1. **Dosya kopyalama:**
   - `cp` komutunu kullanarak `~/Egitim/dersler/notlar.txt` dosyasını `~/Egitim/kaynaklar/notlar_yedek.txt` olarak kopyalayın.
   - `-i` seçeneğini kullanarak üzerine yazma uyarısı alacak şekilde kopyalayın.
   - Örnek komut: `cp -i ~/Egitim/dersler/notlar.txt ~/Egitim/kaynaklar/notlar_yedek.txt`
2. **Dosya taşıma:**
   - `mv` komutunu kullanarak `~/Egitim/scriptler/komutlar.sh` dosyasını `~/Egitim/dersler/komutlar.sh` dizinine taşıyın.
   - Örnek komut: `mv ~/Egitim/scriptler/komutlar.sh ~/Egitim/dersler/komutlar.sh`
3. **Yeniden adlandırma:**
   - `mv` komutunu kullanarak `~/Egitim/kaynaklar/referans.pdf` dosyasını `linux_referans.pdf` olarak yeniden adlandırın.
   - Örnek komut: `mv ~/Egitim/kaynaklar/referans.pdf ~/Egitim/kaynaklar/linux_referans.pdf`
4. **Kontrol edin:**
   - `ls -l ~/Egitim` ve alt dizinlerini kullanarak dosyaların doğru taşınıp kopyalandığını doğrulayın.
5. **Teslim:**
   - İşlemlerin sonucunda oluşan dizin yapısını ve dosyaları listeleyin (`ls -R ~/Egitim`).

**Açıklama:** Bu ödev, `cp` ve `mv` komutlarının dosya kopyalama, taşıma ve yeniden adlandırma işlemlerinde nasıl kullanıldığını gösterir. `-i` seçeneği, dikkatli dosya yönetimi için kullanıcıya kontrol sağlar.

---

### Orta Seviye Ödevler
Bu seviye, daha karmaşık dosya işlemleri, metin görüntüleme, sıkıştırma ve sistem bilgisi toplama gibi konuları kapsar. Kullanıcıların terminalde daha rahat hareket etmesi beklenir.

#### Ödev 3: Log Dosyası Oluşturma ve Takip Etme
**Senaryo:** Bir sistem izleme script’i için log dosyası oluşturmanız ve içeriğini canlı olarak takip etmeniz gerekiyor.
**Talimatlar:**
1. **Log dosyası oluşturun:**
   - `touch` ile `~/Egitim/loglar/sistem.log` dosyasını oluşturun.
   - Örnek komut: `mkdir -p ~/Egitim/loglar && touch ~/Egitim/loglar/sistem.log`
2. **Log’a içerik ekleyin:**
   - `echo` ve `>>` operatörünü kullanarak `sistem.log` dosyasına her 5 saniyede bir sistem zamanını ekleyen bir komut yazın. Örneğin:
     ```bash
     for i in {1..5}; do echo "$(date) - Sistem çalışıyor" >> ~/Egitim/loglar/sistem.log; sleep 5; done
     ```
3. **Log dosyasını takip edin:**
   - `tail -f` komutunu kullanarak `sistem.log` dosyasını canlı olarak izleyin.
   - Örnek komut: `tail -f ~/Egitim/loglar/sistem.log`
4. **Dosya içeriğini analiz edin:**
   - `cat -n sistem.log` ile satır numaralarını görüntüleyin.
   - `head -n 3 sistem.log` ile ilk 3 satırı görüntüleyin.
   - `less sistem.log` ile dosyayı sayfa sayfa inceleyin ve içinde “Sistem” kelimesini arayın (`/Sistem`).
5. **Teslim:**
   - `sistem.log` dosyasının içeriğini ve `tail -f` çıktısını gösterin.

**Açıklama:** Bu ödev, `tail`, `cat`, `head`, `less` gibi dosya içerik komutlarının kullanımını öğretir. Ayrıca, `>>` operatörüyle dosya ekleme ve `date` gibi sistem komutlarının pratik kullanımı gösterilir.

---

#### Ödev 4: Sıkıştırma ve Arşivleme
**Senaryo:** `~/Egitim` dizinindeki tüm dosyaları arşivleyip sıkıştırmanız ve ardından arşivi başka bir dizine açmanız gerekiyor.
**Talimatlar:**
1. **Arşivleme:**
   - `tar` komutunu kullanarak `~/Egitim` dizinini `egitim_arsiv.tar` olarak arşivleyin.
   - Örnek komut: `tar -cvf ~/egitim_arsiv.tar ~/Egitim`
2. **Sıkıştırma:**
   - `gzip` ile `egitim_arsiv.tar` dosyasını sıkıştırarak `egitim_arsiv.tar.gz` oluşturun.
   - Örnek komut: `gzip ~/egitim_arsiv.tar`
3. **Arşivi açma:**
   - Yeni bir dizin oluşturun (`~/Yedek`) ve sıkıştırılmış arşivi bu dizine açın.
   - Örnek komutlar:
     ```bash
     mkdir ~/Yedek
     gunzip ~/egitim_arsiv.tar.gz
     tar -xvf ~/egitim_arsiv.tar -C ~/Yedek
     ```
4. **Kontrol edin:**
   - `ls -R ~/Yedek` ile açılan dosyaları listeleyin.
5. **Teslim:**
   - Arşivleme ve açma işlemlerinin ekran çıktılarını ve `~/Yedek` dizininin içeriğini gösterin.

**Açıklama:** Bu ödev, `tar` ve `gzip` komutlarının arşivleme ve sıkıştırma işlemlerinde kullanımını öğretir. `-C` seçeneğiyle dizin belirtme ve `gunzip` ile açma pratiği yapılır.

---

### İleri Seviye Ödev
Bu seviye, birden fazla komutu birleştirerek karmaşık görevlerin üstesinden gelmeyi ve sistem bilgisi analizini içerir.

#### Ödev 5: Sistem Bilgisi Toplama ve Raporlama
**Senaryo:** Sistem yöneticisi olarak, sistem bilgilerini toplayıp düzenli bir rapora kaydetmeniz gerekiyor.
**Talimatlar:**
1. **Sistem bilgisi toplayın:**
   - Aşağıdaki komutları kullanarak sistem bilgilerini bir dosyaya (`~/Egitim/rapor.txt`) kaydedin:
     - `uname -a` (tüm sistem bilgisi)
     - `df -h` (disk kullanımı)
     - `du -sh ~/Egitim/*` (dizin boyutları)
   - Örnek komut:
     ```bash
     echo "Sistem Bilgisi" > ~/Egitim/rapor.txt
     uname -a >> ~/Egitim/rapor.txt
     echo "\nDisk Kullanımı" >> ~/Egitim/rapor.txt
     df -h >> ~/Egitim/rapor.txt
     echo "\nDizin Boyutları" >> ~/Egitim/rapor.txt
     du -sh ~/Egitim/* >> ~/Egitim/rapor.txt
     ```
2. **Raporu düzenleyin:**
   - `nano` veya `vim` ile `rapor.txt` dosyasını açın ve başlıkları düzenleyin (örn. her bölüm için bir başlık ekleyin).
3. **Raporu analiz edin:**
   - `less rapor.txt` ile raporu sayfa sayfa inceleyin.
   - `cat -n rapor.txt` ile satır numaralarını görüntüleyin.
   - `head -n 5 rapor.txt` ve `tail -n 5 rapor.txt` ile raporun başını ve sonunu kontrol edin.
4. **Yardım alın:**
   - `man df` komutunu kullanarak `df` komutunun detaylarını inceleyin ve `-h` seçeneğinin ne yaptığını not edin.
5. **Teslim:**
   - `rapor.txt` dosyasının içeriğini ve `less`, `cat`, `head`, `tail` komutlarının ekran çıktılarını teslim edin.

**Açıklama:** Bu ödev, sistem bilgisi komutları (`uname`, `df`, `du`) ile dosya içerik komutlarını (`cat`, `less`, `head`, `tail`) birleştirerek karmaşık bir görev yürütmeyi öğretir. Ayrıca, `man` komutuyla yardım alma becerisi kazandırır.

---

### Teslim Formatı
Her ödev için:
1. Kullandığınız komutları ve açıklamalarını bir metin dosyasına yazın.
2. Komutların ekran çıktılarını ekleyin (örn. `ls -R`, `cat`, `tail` çıktıları).
3. Dosyaları `~/Egitim/teslim` dizinine kaydedin ve `tar` ile arşivleyerek teslim edin:
   ```bash
   mkdir -p ~/Egitim/teslim
   mv odev_dosyasi.txt ~/Egitim/teslim/
   tar -czvf ~/odev_teslim.tar.gz ~/Egitim/teslim
   ```

---

### Ek Notlar
- **Yardım almak için:** Her komutun detaylarını öğrenmek için `man` komutunu kullanın (örn. `man ls`).
- **Hata yönetimi:** Komutlar hata verirse, hata mesajlarını okuyun ve `man` veya `whatis` ile çözüm arayın.
- **Pratik:** Her ödevi terminalde tekrarlayarak öğrenmeyi pekiştirin.

Bu ödevler, Unix/Linux komutlarının temelinden ileri seviyesine kadar kullanımını öğretmek için tasarlanmıştır. Başlangıç seviyesinde temel dosya ve dizin işlemleri, orta seviyede dosya içeriği yönetimi ve sıkıştırma, ileri seviyede ise sistem bilgisi analizi ve raporlama becerileri kazandırılır.
