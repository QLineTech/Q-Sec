# Güvenlik Duvarı Kavramları ve Yapılandırma Rehberi

## İçindekiler

1. [Giriş](#giriş)
2. [Durum Tabanlı Filtreleme](#durum-tabanlı-filtreleme)
3. [Durum Tablosu Yönetimi](#durum-tablosu-yönetimi)
4. [Kural ve Kural Setleri](#kural-ve-kural-setleri)
5. [Engelleme Stratejileri](#engelleme-stratejileri)
6. [Pratik Örnekler](#pratik-örnekler)
7. [En İyi Uygulamalar](#en-İyi-uygulamalar)

## Giriş

Bu rehber, pfSense tabanlı güvenlik duvarı sistemlerinin temel kavramlarını ve yapılandırma prensiplerini açıklamaktadır. Modern ağ güvenliğinin temel taşlarından biri olan güvenlik duvarı yönetimi, hem teorik bilgi hem de pratik deneyim gerektiren bir alandır. Bu dokümanda, temel kavramlardan başlayarak ileri seviye yapılandırmalara kadar detaylı bilgiler bulacaksınız.

## Durum Tabanlı Filtreleme

### Genel Bakış

pfSense, durum tabanlı (stateful) filtreleme yapan bir güvenlik duvarı sistemidir. Bu özellik, güvenlik duvarından geçen tüm bağlantıların durumunu aktif olarak takip eder ve yönetir.

### Durum Tablosunun İşleyişi

Durum tablosu, her bağlantı için aşağıdaki bilgileri saklar:

- Kaynak IP adresi ve portu
- Hedef IP adresi ve portu
- Protokol bilgisi (TCP, UDP, ICMP vb.)
- Bağlantı durumu
- Zaman damgaları

Örnek bir durum kaydı:
```
TCP STATE src=192.168.1.100:45678 dst=8.8.8.8:443 
ESTABLISHED age=120s
```

### Avantajları

Durum tabanlı filtrelemenin başlıca avantajları:

- Daha yüksek güvenlik seviyesi
- Daha iyi performans
- Otomatik yanıt trafiği yönetimi
- Karmaşık protokollerin daha iyi desteklenmesi

## Durum Tablosu Yönetimi

### Boyutlandırma

Durum tablosu boyutu şu faktörlere göre belirlenir:

1. **Donanım Kapasitesi:**
   - Her durum kaydı ≈ 1 KB RAM kullanır
   - Varsayılan boyut = Toplam RAM'in %10'u
   - Örnek: 1GB RAM = 100,000 durum kaydı

2. **Performans İhtiyaçları:**
   - Eşzamanlı bağlantı sayısı
   - Ortalama bağlantı süresi
   - Ağ trafiği yoğunluğu

### Yapılandırma Adımları

Durum tablosu boyutunu değiştirmek için:

1. System > Advanced menüsüne gidin
2. Firewall & NAT sekmesini seçin
3. Firewall Maximum States alanını düzenleyin
4. Save ile kaydedin

### İzleme ve Analiz

Performans izleme için:

1. Status > Monitoring bölümüne gidin
2. Sol eksen için System kategorisini seçin
3. States grafiğini görüntüleyin
4. Düzenli olarak kullanım istatistiklerini inceleyin

## Kural ve Kural Setleri

### Temel Kavramlar

**Kural (Rule):** Tek bir trafik kontrol birimidir. Örnek:

```
Tanım: Web erişimi kuralı
Kaynak: İç ağ (192.168.1.0/24)
Hedef: İnternet (any)
Port: 80, 443
Protokol: TCP
Eylem: İzin Ver
```

**Kural Seti (Ruleset):** Belirli bir amaca hizmet eden kurallar topluluğudur.

### Kural İşleme Mantığı

Kurallar yukarıdan aşağıya işlenir:

1. İlk eşleşen kural uygulanır
2. Sonraki kurallara bakılmaz
3. Varsayılan kural en sonda yer alır

### Örnek Kural Seti Hiyerarşisi

```
1. Acil Durum Erişim Kuralları
2. Güvenlik Politikası Kuralları
3. Servis Erişim Kuralları
4. Genel İnternet Erişim Kuralları
5. Varsayılan Ret Kuralı
```

## Engelleme Stratejileri

### Engelle vs. Reddet

**Engelle (Block):**
- Sessiz engelleme
- Yanıt yok
- Dış ağlarda tercih edilir

**Reddet (Reject):**
- Açık red yanıtı
- TCP RST veya ICMP mesajı
- İç ağlarda tercih edilir

### Uygulama Örnekleri

İç Ağ Kuralı:
```
Kaynak: LAN
Hedef: Yasaklı_Sunucu
Eylem: Reddet
Sonuç: Hızlı uygulama yanıtı
```

Dış Ağ Kuralı:
```
Kaynak: Internet
Hedef: WAN
Eylem: Engelle
Sonuç: Minimum bilgi sızıntısı
```

## Pratik Örnekler

### Örnek 1: Departman Bazlı Erişim Kontrolü

```
# Muhasebe Yazıcı Erişimi
Kural 1:
  Kaynak: Muhasebe_VLAN
  Hedef: Yazıcı_Sunucusu
  Port: 9100
  Eylem: İzin Ver

Kural 2:
  Kaynak: LAN
  Hedef: Yazıcı_Sunucusu
  Port: 9100
  Eylem: Reddet
```

### Örnek 2: DMZ Web Sunucusu Yapılandırması

```
# DMZ Web Sunucusu Erişimi
Kural 1:
  Kaynak: Internet
  Hedef: DMZ_Web
  Port: 80,443
  Eylem: İzin Ver

Kural 2:
  Kaynak: DMZ_Web
  Hedef: LAN
  Eylem: Engelle
```

## En İyi Uygulamalar

### Güvenlik Prensipleri

1. En kısıtlayıcı kuralları üste yazın
2. İç ağda "reddet" kullanın
3. Dış ağda "engelle" kullanın
4. Durum tablosunu optimize edin

### Performans İyileştirmeleri

1. Gereksiz kuralları temizleyin
2. Durum tablosu boyutunu izleyin
3. Kural sıralamasını optimize edin
4. Düzenli bakım yapın

### Bakım ve İzleme

1. Günlükleri düzenli kontrol edin
2. Performans metriklerini izleyin
3. Güvenlik politikalarını güncelleyin
4. Yedekleme planı oluşturun

Bu rehber, güvenlik duvarı yönetiminin temel taşlarını kapsamaktadır.


