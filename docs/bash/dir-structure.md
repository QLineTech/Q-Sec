
![Linux Dizin Yapısı](https://q-e.io/git-assets/dirPath.webp)


```markdown
# Unix ve Linux Dizin Yapısı

Unix ve Linux işletim sistemlerinde, dosya sistemi hiyerarşik bir yapıya sahiptir. İşte temel dizinler ve kullanım amaçları:

## / (Kök Dizin)
- Tüm dosya sisteminin başlangıç noktası

## /bin
- Temel sistem komutlarını içerir (ls, cp, mv gibi)
- Sistem açılışı ve onarımı için gerekli komutlar burada bulunur

## /boot
- Önyükleme dosyalarını içerir
- Kernel imajı ve önyükleyici konfigürasyonu burada yer alır

## /dev
- Cihaz dosyalarını içerir
- Donanım aygıtları burada dosya olarak temsil edilir

## /etc
- Sistem konfigürasyon dosyalarını içerir
- Ağ ayarları, kullanıcı bilgileri gibi yapılandırmalar burada bulunur

## /home
- Kullanıcıların kişisel dizinlerini içerir
- Her kullanıcının kendi dosyaları ve ayarları burada saklanır

## /lib
- Sistem kütüphanelerini içerir
- Kernel modülleri ve paylaşılan kütüphaneler burada bulunur

## /media
- Çıkarılabilir medya için bağlama noktası
- USB sürücüler, CD-ROM'lar gibi aygıtlar buraya bağlanır

## /mnt
- Geçici olarak bağlanan dosya sistemleri için kullanılır

## /opt
- Üçüncü parti yazılımların kurulum dizini

## /proc
- Sanal dosya sistemi
- Çalışan işlemler ve sistem bilgileri hakkında bilgi sağlar

## /root
- Root kullanıcısının ev dizini

## /sbin
- Sistem yönetimi için gerekli komutları içerir
- Genellikle sadece root kullanıcısı tarafından kullanılır

## /srv
- Sistem tarafından sağlanan servislerin verilerini içerir

## /tmp
- Geçici dosyalar için kullanılır

## /usr
- Kullanıcı programları ve verileri için kullanılır
- İkincil hiyerarşi olarak düşünülebilir

## /var
- Değişken veriler için kullanılır
- Loglar, e-postalar, print kuyruğu gibi veriler burada saklanır
```

Bu açıklama, Unix ve Linux sistemlerindeki temel dizin yapısını ve her bir dizinin ana kullanım amacını özetlemektedir. Bu yapı, sistem yönetimini ve organizasyonunu kolaylaştırır ve farklı Linux dağıtımları arasında tutarlılık sağlar.