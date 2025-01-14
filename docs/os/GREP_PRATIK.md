Grep Alıştırma Ödevleri:

1. "Sistem üzerindeki tüm hatalı giriş denemelerini bulun ve kaç tane olduğunu sayın"
```bash
grep -r "Failed login" . | wc -l
```
Açıklama: Bu sorgu önce tüm dosyalarda (-r) "Failed login" ifadesini arar ve pipe (|) ile wc -l komutuna aktararak toplam sayıyı verir. Bu, güvenlik analizinde sık kullanılan bir tekniktir.

2. "Ağ üzerinde 192.168 ile başlayan tüm yerel IP adreslerini listeleyin"
```bash
grep -r -E "192\.168\.[0-9]{1,3}\.[0-9]{1,3}" .
```
Açıklama: Regular expression kullanarak 192.168 ile başlayan IP adreslerini filtreler. \. nokta karakterini escape eder, [0-9]{1,3} ise 1 ile 3 basamaklı sayıları temsil eder.

3. "500-599 arası HTTP hata kodlarını içeren log kayıtlarını bulun"
```bash
grep -r -E "HTTP/[0-9.]+ 5[0-9]{2}" .
```
Açıklama: HTTP yanıt kodlarından 5xx serisi sunucu hatalarını yakalar. Regular expression'da 5 ile başlayan üç basamaklı sayıları arar.

4. "Belirli bir formatta yazılmış tüm tarih kayıtlarını bulun (YYYY-MM-DD)"
```bash
grep -r -E "[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])" .
```
Açıklama: Tarih formatını doğrular. Ay için 01-12, gün için 01-31 aralığını kontrol eder.

5. "Geçerli bir MAC adresi formatına uyan tüm kayıtları listeleyin"
```bash
grep -r -E "([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})" .
```
Açıklama: MAC adresi formatını (XX:XX:XX:XX:XX:XX veya XX-XX-XX-XX-XX-XX) kontrol eder. Hexadecimal karakterleri kabul eder.

6. "Critical ve Error seviyesindeki log kayıtlarını sayın"
```bash
grep -r -E "(CRITICAL|ERROR)" . | wc -l
```
Açıklama: OR operatörü (|) kullanarak iki farklı log seviyesini aynı anda arar ve sayar.

7. "Tüm e-posta adreslerini bulun ve benzersiz olanları listeleyin"
```bash
grep -r -E "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" . | sort | uniq
```
Açıklama: E-posta formatına uyan metinleri bulur, sıralar ve tekrar edenleri eler.

8. "Belirli bir port numarasına yapılan bağlantı denemelerini bulun"
```bash
grep -r -E "port (443|3306|22)\b" .
```
Açıklama: Yaygın portlara (HTTPS, MySQL, SSH) yapılan bağlantıları arar. \b kelime sınırını belirtir.

9. "Başarılı SSH bağlantılarını içeren kayıtları bulun"
```bash
grep -r "Accepted publickey" .
```
Açıklama: SSH log kayıtlarında başarılı public key authentication'ları arar.

10. "HTTPS URL'lerini bulun"
```bash
grep -r -E "https://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" .
```
Açıklama: HTTPS protokolü ile başlayan ve geçerli domain formatına uyan URL'leri bulur.

11. "IPv6 adreslerini bulun"
```bash
grep -r -E "([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}" .
```
Açıklama: IPv6 formatındaki adresleri arar. Hexadecimal grupları ve : ayraçlarını kontrol eder.

12. "Belirli bir API key formatına uyan kayıtları bulun"
```bash
grep -r -E "api_key_[a-zA-Z0-9]{32}" .
```
Açıklama: api_key_ öneki ve 32 karakterlik alfanumerik bir dizi içeren API key'leri arar.

13. "Tüm JSON Web Token'ları (JWT) bulun"
```bash
grep -r -E "eyJ[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*" .
```
Açıklama: JWT'nin üç bölümlü yapısını (header.payload.signature) ve Base64URL kodlamasını kontrol eder.

14. "Belirli bir hash formatına uyan değerleri bulun (MD5)"
```bash
grep -r -E "\b[a-fA-F0-9]{32}\b" .
```
Açıklama: 32 karakterlik hexadecimal değerleri (MD5 hash'leri) arar. \b ile kelime sınırlarını kontrol eder.

15. "Tüm database bağlantı stringlerini bulun ve hassas bilgileri maskeleyin"
```bash
grep -r -E "(mongodb|postgresql|mysql)://[^@]+@[^/]+" . | sed 's/:[^@]*@/:*****@/g'
```
Açıklama: Database URL'lerini bulur ve sed ile şifre kısmını maskeler. Güvenlik açısından önemli bir uygulama.
