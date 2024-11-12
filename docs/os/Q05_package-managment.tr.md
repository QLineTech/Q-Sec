# Unix/Linux Paket Yönetimi Rehberi

[← Ana Sayfaya Dön](Q00_index.tr.md)

[← Önceki: Süreç Yönetimi](Q04_process_management.tr.md) | [Sonraki: Servis Yönetimi →](Q06_service_management.tr.md)

## İçindekiler
1. [APT Paket Yönetimi](#apt-paket-yönetimi)
2. [DEB Paketleri](#deb-paketleri)
3. [Kaynak Kod Derleme](#kaynak-kod-derleme)
4. [Snap Paketleri](#snap-paketleri)
5. [Flatpak Paketleri](#flatpak-paketleri)
6. [Paket Depoları](#paket-depoları)
7. [Ödevler](#ödevler)
8. [Kaynaklar](#kaynaklar)

## APT Paket Yönetimi

### Temel APT Komutları
```bash
# Paket Listesi Güncelleme
sudo apt update

# Sistem Güncelleme
sudo apt upgrade                 # Sadece paketleri güncelle
sudo apt full-upgrade           # Tam sistem güncellemesi
sudo apt dist-upgrade           # Dağıtım güncellemesi

# Paket Kurulum
sudo apt install paket-adi      # Tek paket
sudo apt install paket1 paket2  # Çoklu paket
sudo apt install paket=1.2.3    # Belirli sürüm

# Paket Kaldırma
sudo apt remove paket-adi       # Paketi kaldır
sudo apt purge paket-adi        # Paketi ve ayarları kaldır
sudo apt autoremove            # Gereksiz paketleri kaldır

# Paket Arama
apt search kelime              # Paket ara
apt show paket-adi            # Paket bilgisi
apt list --installed          # Kurulu paketler
```

### APT Cache Yönetimi
```bash
# Cache Temizleme
sudo apt clean                # Tüm cache'i temizle
sudo apt autoclean           # Eski sürümleri temizle

# Cache Bilgisi
apt-cache policy paket-adi   # Paket politikası
apt-cache depends paket-adi  # Bağımlılıklar
apt-cache stats             # Cache istatistikleri
```

## DEB Paketleri

### DEB Kurulum ve Yönetimi
```bash
# DEB Kurulum
sudo dpkg -i paket.deb       # DEB paketi kur
sudo dpkg -r paket-adi       # Paketi kaldır
sudo dpkg -P paket-adi       # Paketi ve ayarları kaldır

# DEB Bilgi
dpkg -l                      # Kurulu paketler
dpkg -L paket-adi           # Paket dosyaları
dpkg -s paket-adi           # Paket durumu
dpkg --contents paket.deb    # DEB içeriği

# Bağımlılık Sorunları
sudo apt install -f          # Eksik bağımlılıkları çöz
```

## Kaynak Kod Derleme

### TAR Arşivleri
```bash
# tar.gz (gzip)
tar xzf dosya.tar.gz        # Aç
tar czf arsiv.tar.gz klasor # Oluştur

# tar.bz2 (bzip2)
tar xjf dosya.tar.bz2       # Aç
tar cjf arsiv.tar.bz2 klasor # Oluştur

# tar.xz (xz)
tar xJf dosya.tar.xz        # Aç
tar cJf arsiv.tar.xz klasor # Oluştur
```

### Kaynak Kod Derleme
```bash
# Gerekli Araçlar
sudo apt install build-essential

# Tipik Derleme Süreci
./configure                  # Yapılandır
make                        # Derle
sudo make install           # Kur
sudo make uninstall         # Kaldır

# Derleme Öncesi Bağımlılıklar
sudo apt build-dep paket-adi
```

## Snap Paketleri

### Snap Temel Komutları
```bash
# Snap Kurulum
sudo apt install snapd      # Snap desteği kur

# Paket İşlemleri
snap find paket-adi        # Paket ara
snap info paket-adi        # Paket bilgisi
sudo snap install paket    # Paket kur
sudo snap remove paket     # Paketi kaldır
snap list                  # Kurulu paketler
snap refresh              # Tüm paketleri güncelle
snap refresh paket        # Tek paket güncelle
```

### Snap Kanal ve Sürümler
```bash
# Kanal Seçimi
sudo snap install paket --channel=edge
sudo snap install paket --channel=beta
sudo snap install paket --channel=candidate
sudo snap install paket --channel=stable

# Sürüm Değiştirme
snap revert paket         # Önceki sürüme dön
```

## Flatpak Paketleri

### Flatpak Temel Komutları
```bash
# Flatpak Kurulum
sudo apt install flatpak

# Paket İşlemleri
flatpak search paket      # Paket ara
flatpak install paket     # Paket kur
flatpak uninstall paket   # Paket kaldır
flatpak list              # Kurulu paketler
flatpak update           # Güncelle
```

## Paket Depoları

### APT Depo Yönetimi
```bash
# Depo Ekleme
sudo add-apt-repository ppa:kullanici/depo
sudo add-apt-repository 'deb http://adres.com/ubuntu distro main'

# Depo Kaldırma
sudo add-apt-repository --remove ppa:kullanici/depo

# Depo Listesi
cat /etc/apt/sources.list
ls /etc/apt/sources.list.d/
```

## Ödevler

### Başlangıç Seviyesi
1. Sistem güncellemesi:
   ```bash
   sudo apt update
   sudo apt upgrade
   sudo apt autoremove
   ```

2. Temel paket işlemleri:
   ```bash
   # htop ve neofetch kurulumu
   sudo apt install htop neofetch
   
   # Paket bilgilerini kontrol
   apt show htop
   dpkg -L neofetch
   
   # Paketleri kaldır
   sudo apt remove htop neofetch
   ```

### Orta Seviye
1. DEB paketi yönetimi:
   ```bash
   # .deb dosyası indir ve kur
   wget https://example.com/paket.deb
   sudo dpkg -i paket.deb
   sudo apt install -f
   ```

2. Kaynak koddan derleme:
   ```bash
   # Örnek projeyi derle
   tar xzf proje.tar.gz
   cd proje
   ./configure
   make
   sudo make install
   ```

### İleri Seviye
1. Özel paket deposu oluştur:
   ```bash
   # Depo oluştur ve paket ekle
   ```

2. Otomatik güncelleme scripti yaz:
   ```bash
   # Sistem güncelleme scripti
   ```

## Kaynaklar

### Man Sayfaları
```bash
man apt
man dpkg
man snap
man flatpak
```

### Çevrimiçi Kaynaklar
1. [Ubuntu Paket Rehberi](https://help.ubuntu.com/community/Repositories)
2. [Debian Paket Yönetimi](https://www.debian.org/doc/manuals/debian-reference/ch02.en.html)
3. [Snap Store](https://snapcraft.io/store)
4. [Flatpak](https://flatpak.org/)

### Hızlı Başvuru Tablosu

| Komut | APT | DEB | Snap | Flatpak |
|-------|-----|-----|------|----------|
| Kur | apt install | dpkg -i | snap install | flatpak install |
| Kaldır | apt remove | dpkg -r | snap remove | flatpak uninstall |
| Güncelle | apt upgrade | - | snap refresh | flatpak update |
| Ara | apt search | - | snap find | flatpak search |
| Liste | apt list | dpkg -l | snap list | flatpak list |

### Arşiv Formatları Tablosu

| Format | Aç | Oluştur | Açıklama |
|--------|-----|----------|-----------|
| .tar.gz | tar xzf | tar czf | Gzip sıkıştırma |
| .tar.bz2 | tar xjf | tar cjf | Bzip2 sıkıştırma |
| .tar.xz | tar xJf | tar cJf | XZ sıkıştırma |
| .deb | dpkg -x | - | Debian paketi |

[← Önceki: Süreç Yönetimi](Q04_process_management.tr.md) | [Sonraki: Servis Yönetimi →](Q06_service_management.tr.md)

[← Ana Sayfaya Dön](Q00_index.tr.md)
