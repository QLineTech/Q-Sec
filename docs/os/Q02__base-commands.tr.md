# Unix/Linux Temel Komutlar Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Unix Dosya Sistemi](Q08_folder-structure.tr.md) | [Sonraki: İzinler →](Q10_permissions.tr.md)

## İçindekiler
1. [Temel Kavramlar](#temel-kavramlar)
2. [Gezinme Komutları](#gezinme-komutları)
3. [Dosya İşlemleri](#dosya-işlemleri)
4. [Metin Editörleri](#metin-editörleri)
5. [Dosya İçerik Komutları](#dosya-içerik-komutları)
6. [Sıkıştırma ve Arşivleme](#sıkıştırma-ve-arşivleme)
7. [Sistem Bilgisi](#sistem-bilgisi)
8. [Yardım Komutları](#yardım-komutları)
9. [Ödevler](#ödevler)
10. [Kaynaklar](#kaynaklar)

## Temel Kavramlar

### Terminal Nedir?
Terminal, Unix/Linux sistemlerinde komut satırı arayüzüdür. Grafik arayüzü olmadan sistem üzerinde işlem yapmanızı sağlar.

### Komut Yapısı
```bash
komut [seçenekler] [parametreler]
```

Örnek:
```bash
ls -l /home
# komut: ls
# seçenek: -l
# parametre: /home
```

## Gezinme Komutları

### pwd (Print Working Directory)
Mevcut çalışma dizinini gösterir.

```bash
pwd
# Çıktı: /home/kullanici

pwd -P  # Sembolik linkleri çözümleyerek göster
pwd -L  # Sembolik linkleri çözümlemeden göster
```

### cd (Change Directory)
Dizinler arası geçiş yapar.

```bash
cd /home/kullanici    # Belirtilen dizine git
cd ~                  # Ev dizinine git
cd ..                 # Üst dizine git
cd -                  # Önceki dizine git
cd .                  # Mevcut dizinde kal
cd ../dizin           # Üst dizindeki 'dizin'e git
```

### ls (List)
Dizin içeriğini listeler.

```bash
ls                  # Temel listeleme
ls -l               # Uzun format
ls -a               # Gizli dosyaları göster
ls -h               # İnsan okunabilir boyutlar
ls -R               # Alt dizinleri de listele
ls -ltr             # Zamana göre sırala (eskiden yeniye)
ls -S               # Boyuta göre sırala
ls -i               # inode numaralarını göster
ls --color=auto     # Renkli çıktı
```

## Dosya İşlemleri

### touch
Dosya oluşturur veya zaman damgasını günceller.

```bash
touch dosya.txt              # Yeni dosya oluştur
touch -a dosya.txt          # Erişim zamanını güncelle
touch -m dosya.txt          # Değişiklik zamanını güncelle
touch -t 202401012359.59    # Belirli bir zaman damgası ile oluştur
```

### mkdir (Make Directory)
Dizin oluşturur.

```bash
mkdir dizin                # Tek dizin oluştur
mkdir -p a/b/c            # İç içe dizinler oluştur
mkdir -m 755 dizin        # İzinlerle birlikte oluştur
mkdir {dizin1,dizin2}     # Çoklu dizin oluştur
```

### cp (Copy)
Dosya ve dizinleri kopyalar.

```bash
cp kaynak hedef           # Dosya kopyala
cp -r dizin1 dizin2      # Dizin kopyala
cp -i dosya1 dosya2      # Üzerine yazmadan önce sor
cp -p dosya1 dosya2      # İzinleri koruyarak kopyala
cp *.txt /hedef/         # Joker karakterle kopyala
```

### mv (Move)
Dosya ve dizinleri taşır veya yeniden adlandırır.

```bash
mv eski.txt yeni.txt     # Yeniden adlandır
mv dosya /hedef/         # Taşı
mv -i dosya1 dosya2      # Üzerine yazmadan önce sor
mv -u dosya1 dosya2      # Sadece daha yeni ise taşı
```

## Metin Editörleri

### nano
Basit ve kullanıcı dostu metin editörü.

```bash
nano dosya.txt           # Dosya aç/oluştur
```

Temel Nano Kısayolları:
- `Ctrl + O`: Kaydet
- `Ctrl + X`: Çık
- `Ctrl + W`: Ara
- `Ctrl + K`: Satır kes
- `Ctrl + U`: Satır yapıştır
- `Ctrl + G`: Yardım

### vim
Gelişmiş metin editörü.

```bash
vim dosya.txt            # Dosya aç/oluştur
```

Temel Vim Modları:
- `i`: Düzenleme modu
- `Esc`: Normal mod
- `:w`: Kaydet
- `:q`: Çık
- `:wq`: Kaydet ve çık
- `:q!`: Kaydetmeden çık

## Dosya İçerik Komutları

### cat (Concatenate)
Dosya içeriğini görüntüler.

```bash
cat dosya.txt            # Dosya içeriğini göster
cat -n dosya.txt        # Satır numaralarıyla göster
cat dosya1 dosya2       # Birden fazla dosyayı birleştir
cat > dosya.txt         # Yeni dosya oluştur ve yaz
```

### less
Büyük dosyaları sayfa sayfa görüntüler.

```bash
less dosya.txt          # Dosyayı görüntüle
```

Temel Less Komutları:
- `Space`: Sonraki sayfa
- `b`: Önceki sayfa
- `/kelime`: Ara
- `q`: Çık

### head ve tail
Dosyanın başını veya sonunu görüntüler.

```bash
head dosya.txt          # İlk 10 satır
head -n 5 dosya.txt    # İlk 5 satır
tail dosya.txt         # Son 10 satır
tail -f dosya.txt      # Canlı takip
```

## Sıkıştırma ve Arşivleme

### tar
Dosyaları arşivler.

```bash
tar -cvf arsiv.tar dosyalar/    # Arşiv oluştur
tar -xvf arsiv.tar              # Arşivi aç
tar -czvf arsiv.tar.gz dosyalar/# Sıkıştırarak arşivle
```

### gzip
Dosyaları sıkıştırır.

```bash
gzip dosya.txt          # Sıkıştır
gunzip dosya.txt.gz     # Aç
```

## Sistem Bilgisi

### uname
Sistem bilgisini gösterir.

```bash
uname -a               # Tüm sistem bilgisi
uname -r              # Kernel sürümü
uname -n              # Host adı
```

### df ve du
Disk kullanımını gösterir.

```bash
df -h                 # Disk kullanımı
du -sh *             # Dizin boyutları
```

## Yardım Komutları

### man (Manual)
Komutların kılavuz sayfalarını gösterir.

```bash
man ls                # ls komutunun kılavuzu
man -k anahtar       # Anahtar kelimeyle ara
```

### whatis
Komutların kısa açıklamalarını gösterir.

```bash
whatis ls            # ls komutunun açıklaması
```

### apropos
Komutları anahtar kelimeyle arar.

```bash
apropos copy         # Kopyalamayla ilgili komutlar
```

## Ödevler

### Başlangıç Seviyesi
1. Aşağıdaki dizin yapısını oluşturun:
```
~/Projeler/
├── web/
│   ├── index.html
│   └── style.css
├── docs/
│   └── readme.txt
└── scripts/
    └── test.sh
```

2. Her dosyaya farklı içerik ekleyin
3. Dosyaları taşıma ve kopyalama işlemleri yapın

### Orta Seviye
1. Bir log dosyası oluşturup tail ile takip edin
2. Dosyaları sıkıştırma ve arşivleme işlemleri yapın
3. Sistem bilgilerini bir dosyaya kaydedin

## Kaynaklar

### Man Sayfaları
```bash
man bash
man intro
man hier
```

### Online Kaynaklar
1. [Linux Documentation Project](https://tldp.org/)
2. [GNU Coreutils](https://www.gnu.org/software/coreutils/manual/)
3. [Linux Command Library](https://linuxcommandlibrary.com/)

### Türkçe Kaynaklar
1. Linux Dersleri - https://linux-dersleri.github.io/
2. Belgeler.org - https://belgeler.org/
3. Ubuntu Türkiye - https://ubuntu-tr.net/

## Hızlı Başvuru Tablosu

| Komut | Temel Kullanım | Açıklama |
|-------|----------------|-----------|
| pwd | pwd | Mevcut dizin |
| cd | cd dizin | Dizin değiştir |
| ls | ls -l | Dizin listele |
| cp | cp kaynak hedef | Kopyala |
| mv | mv eski yeni | Taşı/Yeniden adlandır |
| rm | rm dosya | Sil |
| mkdir | mkdir dizin | Dizin oluştur |
| touch | touch dosya | Dosya oluştur |
| cat | cat dosya | Dosya görüntüle |
| less | less dosya | Sayfa sayfa görüntüle |
| man | man komut | Yardım göster |

[← Önceki: Unix Dosya Sistemi](Q01_folder-structure.tr.md) | [Sonraki: İzinler →](Q03_permissions.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
