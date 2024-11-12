

## Unix Klasör Yapısı

### Kök Dizin (/)
Unix/Linux sistemlerinde tüm dosya sistemi "/" (kök) dizininden başlar. Bu, Windows'taki C:\ sürücüsüne benzer bir konsepttir. Her şey bu dizinin altında hiyerarşik olarak organize edilmiştir.

### Temel Dizinler ve Detaylı Açıklamaları

#### /bin (Binary)
- Temel sistem komutlarını içerir
- Sistem açılışı için gerekli komutlar burada bulunur
- Örnek komutlar: ls, cp, mv, rm, cat
- Tüm kullanıcılar tarafından kullanılabilir

#### /boot
- Sistem başlangıcı için gerekli dosyalar
- Linux çekirdeği (kernel) burada bulunur
- GRUB önyükleyici dosyaları
- initrd/initramfs dosyaları

#### /dev (Devices)
- Donanım aygıtları için özel dosyalar
- Örnek: 
  - /dev/sda (birinci sabit disk)
  - /dev/tty (terminal aygıtları)
  - /dev/null (boşluk aygıtı)

#### /etc (Etcetera)
- Sistem yapılandırma dosyaları
- Önemli dosyalar:
  - /etc/passwd (kullanıcı bilgileri)
  - /etc/shadow (şifre bilgileri)
  - /etc/hosts (host tanımlamaları)
  - /etc/network/ (ağ yapılandırması)

#### /home
- Her kullanıcının kişisel dizini
- Örnek: /home/ahmet, /home/ayse
- Kullanıcı dosyaları ve ayarları burada saklanır
- ~ işareti ile kısayol olarak gösterilir

#### /lib (Library)
- Sistem kütüphaneleri ve modülleri
- Kernel modülleri (/lib/modules/)
- Paylaşılan kütüphane dosyaları (.so uzantılı)

#### Diğer Önemli Dizinler
- **/media**: USB bellek gibi çıkarılabilir aygıtlar
- **/mnt**: Geçici disk bağlama noktası
- **/opt**: Üçüncü parti yazılımlar (Oracle, Google Chrome vb.)
- **/proc**: Sistem ve süreç bilgileri (sanal dosya sistemi)
- **/root**: Süper kullanıcı (root) ev dizini
- **/sbin**: Sistem yönetimi komutları (reboot, fdisk vb.)
- **/tmp**: Geçici dosyalar (sistem yeniden başlatıldığında temizlenir)
- **/usr**: İkincil hiyerarşi (kullanıcı programları ve veriler)
- **/var**: Değişken veriler (log dosyaları, mail kutuları)

### Alt Dizin Detayları

#### /usr dizini altında:
- **/usr/bin**: Genel kullanıcı komutları
- **/usr/lib**: Kütüphaneler
- **/usr/local**: Yerel kurulumlar için
- **/usr/share**: Paylaşılan veriler
- **/usr/src**: Kaynak kodları

#### /var dizini altında:
- **/var/log**: Sistem günlükleri
- **/var/mail**: E-posta kutuları
- **/var/spool**: Print kuyruğu, mail kuyruğu
- **/var/www**: Web sunucusu dosyaları

### Önemli Notlar
1. Her dizinin belirli bir amacı vardır
2. Dizin yapısı standartlaştırılmıştır (FHS - Filesystem Hierarchy Standard)
3. Root kullanıcısı tüm dizinlere erişebilir
4. Normal kullanıcılar sınırlı erişime sahiptir

### Örnek Senaryolar

1. Web Geliştirici için:
```bash
/var/www/html/     # Web dosyaları
/etc/apache2/      # Apache yapılandırması
/var/log/apache2/  # Apache günlükleri
```

2. Sistem Yöneticisi için:
```bash
/etc/              # Yapılandırmalar
/var/log/          # Günlükler
/backup/           # Yedekler (özel dizin)
```


[← Ana Sayfa](Q00_index.tr.md)

[← Önceki](Q00_index.tr.md)
[→ Sonraki](Q00_index.tr.md)


Not: Bu belge sürekli güncellenecek ve genişletilecektir. Katkıda bulunmak için iletişime geçebilirsiniz.
