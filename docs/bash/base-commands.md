# Dosya Sistemi Gezinme

- Mevcut çalışma dizinini `pwd` ile yazdır:
```
pwd
```

- Mevcut çalışma dizinini `cd` ile değiştir:
```
cd data/raw # Mevcut dizin içindeki data dir'e git
```

- Mutlak yollar kök dizinden (/) başlar:
```
cd /home
```

- Göreceli yollar mevcut çalışma dizininden başlayabilir:
```
cd ./images
```

- Üst dizine geç `..` ile (tekrar tekrar kullanılabilir):
```
cd ../.. # Büyük ebeveyn dizinine git
```

- Mevcut çalışma dizinindeki dosya ve klasörleri `ls` ile listele:
```
ls
```

- Gizli olanlar dahil tüm dosya ve klasörleri listele (. ile başlayanlar) `ls -a` ile:
```
ls -a
```

- Dosya ve klasörleri insan okunabilir formatta `ls -lh` ile listele:
```
ls -lh
```

- Bir glob desenine uyan dosya ve klasörleri `ls pattern` ile listele:
```
ls *.csv # Tüm CSV dosyalarını döndürür
```

- Mevcut çalışma dizini altındaki tüm dosyaları özyinelemeli olarak `ls -R` ile listele:
```
ls -R
```

- Dosya ve klasörlerin tahmini disk kullanımını insan okunabilir formatta `du -ah` ile listele:
```
du -ah
```

- Mevcut dizin ve alt dizinlerinde ada göre dosya bul `find . -type f -name pattern` ile:
```
find . -type f -name *.ipynb # Jupyter notebooklarını bul
```


### Yeni Dizin Oluşturma: `mkdir`
```bash
mkdir yeni_dizin # Yeni bir dizin oluşturur
mkdir -p yol/içinde/yeni/dizin # Çok seviyeli bir dizin yapısı oluşturur
```

### Dosya Oluşturma: `touch`
```bash
touch yeni_dosya.txt # Boş bir metin dosyası oluşturur
```

### Dosya Silme: `rm`
**Dikkat:** `rm` komutu geri alınamaz bir işlemdir. Yanlışlıkla önemli dosyaları silmemek için dikkatli kullanın!
```bash
rm silinecek_dosya.txt # Tek bir dosya siler
rm -r silinecek_dizin # Bir dizin ve içindeki tüm içeriği siler
```

### Dosya Kopyalama: `cp`
```bash
cp kaynak_dosya.txt hedef_dosya.txt # Bir dosyayı kopyalar
cp -r kaynak_dizin hedef_dizin # Bir dizini ve içindeki tüm içeriği kopyalar
```

### Dosya Taşıma (Ad Değiştirme): `mv`
```bash
mv kaynak_dosya.txt hedef_dosya.txt # Bir dosyanın adını değiştirir
mv kaynak_dizin hedef_dizin # Bir dizini taşır (adını değiştirir)
```

### Örnek Senaryolar

* **Proje Yapısı Oluşturma:**
  ```bash
  mkdir proje
  cd proje
  mkdir data src tests
  touch src/main.py
  ```
* **Dosya ve Dizin İşlemleri:**
  ```bash
  cd data
  mkdir raw processed
  cp ../src/data.csv raw/
  mv raw/data.csv processed/data_cleaned.csv
  ```
* **Arama ve Filtreleme:**
  ```bash
  find . -name "*.py" -type f # Tüm Python dosyalarını bul
  find . -size +10M # Boyutu 10MB'dan büyük olan tüm dosyaları bul
  ```

### Ek İpuçları

* **Tab Tamamlama:** Komutları veya dosya adlarını yazarken `Tab` tuşuna basarak otomatik tamamlama yapabilirsiniz.
* **Tarih Komutları:** `history` ile geçmişte çalıştırdığınız komutları görebilirsiniz. `!sayı` ile belirli bir komutu tekrar çalıştırabilirsiniz.
* **Yıldızcık (*) Karakteri:** Glob desenlerinde tüm karakterleri temsil eder.
* **Soru İşareti (?) Karakteri:** Glob desenlerinde tek bir karakteri temsil eder.
* **Köşeli Parantezler ([ ]):** Glob desenlerinde bir karakter kümesini belirtir.

### Önemli Notlar

* **Kök Dizini:** Kök dizini, tüm dosya sisteminin başlangıç noktasıdır ve genellikle `/` ile gösterilir.
* **Göreceli ve Mutlak Yollar:** Göreceli yollar, mevcut konumunuza göre belirtilirken, mutlak yollar her zaman kök dizinden başlar.
* **Gizli Dosyalar:** `.` ile başlayan dosyalar gizli dosyalardır.
* **Erişim Hakları:** `chmod` komutu ile dosya ve dizinlerin erişim haklarını değiştirebilirsiniz.

Bu komutları ve örnekleri kullanarak dosya sisteminde daha rahat gezinebilir ve işlemler yapabilirsiniz. Daha fazla bilgi için komutların man sayfalarına (örneğin, `man mkdir`) bakabilirsiniz.

**Başka sorularınız olursa çekinmeden sorabilirsiniz.**

**Ek olarak, aşağıdaki konularla ilgili daha fazla bilgi edinmek isterseniz belirtin:**
* **Regular ifadeler:** Daha karmaşık dosya arama işlemleri için
* **Pipe ve yönlendirme:** Komutların çıktılarını birleştirme ve yönlendirme
* **Betik yazma:** Bash betikleri ile otomasyon
* **Versiyon kontrol sistemleri:** Git gibi sistemlerle dosya değişikliklerini takip etme

