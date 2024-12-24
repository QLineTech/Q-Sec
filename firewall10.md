# Aliases (Takma Adlar)

Aliases, pfSense'de sık kullanılan IP adresleri, portlar veya ağları gruplamak için kullanılan önemli bir özelliktir. Düşünün ki bir ofisteki tüm yazıcıların IP adreslerini tek bir isim altında toplamak istiyorsunuz. Aliases sayesinde "Yazicilar" adında bir grup oluşturup, firewall kurallarında tek tek IP adresleri yazmak yerine bu grubu kullanabilirsiniz.

Örnek kullanım senaryosu: Diyelim ki şirketinizde 5 farklı yazıcı var:
192.168.1.10
192.168.1.11
192.168.1.12
192.168.1.13
192.168.1.14

Bu IP'leri "Yazicilar" adında bir alias altında toplayabilir ve firewall kurallarında "Yazicilar" ismini kullanarak hepsini tek seferde yönetebilirsiniz.

# NAT (Network Address Translation)

NAT, iç ağdaki cihazların internet ile haberleşmesini sağlayan temel bir mekanizmadır. İki ana tür NAT vardır:

1. Port Forwarding (Port Yönlendirme): Dış dünyadan gelen belirli port isteklerini iç ağdaki sunuculara yönlendirmek için kullanılır. Örneğin, dışarıdan gelen 80 portundaki web trafiğini iç ağdaki web sunucunuza yönlendirmek istediğinizde NAT kuralı oluşturursunuz.

2. Outbound NAT: İç ağdaki cihazların internet erişimini sağlar. Örneğin, 192.168.1.100 IP'li bir bilgisayar internete erişmek istediğinde, NAT bu isteği WAN IP'niz üzerinden gerçekleştirir.

# Rules (Kurallar)

Rules, ağ trafiğini kontrol etmenizi sağlayan güvenlik duvarı kurallarıdır. Her kural şu temel mantıkla çalışır: "Nereden gelip nereye giden hangi tür trafiğe izin verilsin veya engellensin?"

Örnek bir kural senaryosu:
- Kaynak: LAN ağı (192.168.1.0/24)
- Hedef: İnternet (any)
- Port: HTTPS (443)
- Eylem: İzin ver (Pass)

Bu kural, iç ağdaki tüm cihazların güvenli web sitelerine erişmesine izin verir.

# Schedules (Zamanlamalar)

Schedules, firewall kurallarının belirli zaman dilimlerinde aktif olmasını sağlar. Örneğin:
- Mesai saatlerinde (09:00-18:00) sosyal medya sitelerine erişimi engellemek
- Gece yarısından sonra (00:00-06:00) belirli servisleri kapatmak
- Hafta sonları farklı güvenlik politikaları uygulamak

# Traffic Shaper (Trafik Şekillendirici)

Traffic Shaper, ağ trafiğini önceliklendirmenizi ve bant genişliğini yönetmenizi sağlar. Örneğin:
- Video konferans trafiğine yüksek öncelik vermek
- Dosya indirme hızını sınırlamak
- VoIP trafiğine minimum garantili bant genişliği sağlamak

Gerçek hayattan bir örnek: Bir ofiste 100 Mbps internet bağlantınız var ve VoIP görüşmelerin kesintisiz olmasını istiyorsunuz. Traffic Shaper ile VoIP trafiğine minimum 10 Mbps ayırabilir, dosya indirme işlemlerini ise maksimum 50 Mbps ile sınırlayabilirsiniz.

# Virtual IPs (Sanal IP'ler)

Virtual IP'ler, tek bir fiziksel ağ arabiriminde birden fazla IP adresi kullanmanızı sağlar. Kullanım amaçları:

1. Yük Dengeleme: Aynı servisi farklı IP'ler üzerinden sunmak
2. Yedeklilik: Failover senaryolarında yedek IP adresleri kullanmak
3. Çoklu SSL Sertifikaları: Farklı web siteleri için farklı IP adresleri kullanmak

Örnek senaryo: Bir web hosting firmasınız ve tek bir fiziksel sunucuda birden fazla müşteriye hizmet vermek istiyorsunuz. Her müşteri için ayrı bir sanal IP kullanarak, her birinin kendine özel SSL sertifikası olmasını sağlayabilirsiniz.
