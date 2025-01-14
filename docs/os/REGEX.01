Düzenli İfadelerin (Regex) Temel Kavramları ve Örnekleri:

1. Basit Karakterler ve Metinler
```
En temel regex, doğrudan aradığımız metindir.
Örnek: "error" kelimesini aramak için sadece "error" yazarız.

Güvenlik Örneği 1:
Regex: admin
Açıklama: Log dosyalarında "admin" kelimesini arar
Kullanım: grep "admin" auth.log

Yazılım Örneği 1:
Regex: Exception
Açıklama: Java hata kayıtlarında "Exception" kelimesini arar
Kullanım: grep "Exception" application.log

Web Örneği 1:
Regex: 404
Açıklama: Web sunucu loglarında 404 hatalarını arar
Kullanım: grep "404" access.log
```

2. Karakter Sınıfları []
```
Köşeli parantezler içinde belirtilen karakterlerden herhangi birini arar.

Güvenlik Örneği 2:
Regex: [Ee][Rr][Rr][Oo][Rr]
Açıklama: Büyük/küçük harf duyarlı olmadan "error" kelimesini arar
Kullanım: grep -E "[Ee][Rr][Rr][Oo][Rr]" system.log

Yazılım Örneği 2:
Regex: [0-9]{3}
Açıklama: Üç basamaklı sayıları arar
Kullanım: grep -E "[0-9]{3}" version.txt

Network Örneği 2:
Regex: [A-Fa-f0-9]{2}
Açıklama: MAC adresinin bir segmentini arar (hexadecimal)
Kullanım: grep -E "[A-Fa-f0-9]{2}" network.log
```

3. Tekrar Belirteçleri (*, +, ?, {n})
```
* : 0 veya daha fazla tekrar
+ : 1 veya daha fazla tekrar
? : 0 veya 1 tekrar
{n} : Tam n kere tekrar

Güvenlik Örneği 3:
Regex: \b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b
Açıklama: IPv4 adreslerini arar
Kullanım: grep -E "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" access.log

API Örneği 3:
Regex: api_key_[A-Za-z0-9]{32}
Açıklama: 32 karakterlik API anahtarlarını arar
Kullanım: grep -E "api_key_[A-Za-z0-9]{32}" config.json

Hash Örneği 3:
Regex: [a-f0-9]{64}
Açıklama: SHA-256 hash değerlerini arar
Kullanım: grep -E "[a-f0-9]{64}" hashes.txt
```

4. Özel Karakterler (., \w, \d, \s)
```
. : Herhangi bir karakter
\w : Harf, rakam veya alt çizgi
\d : Rakam
\s : Boşluk karakteri

Güvenlik Örneği 4:
Regex: \b\w+@\w+\.\w+\b
Açıklama: Basit e-posta adreslerini arar
Kullanım: grep -E "\b\w+@\w+\.\w+\b" users.txt

Log Örneği 4:
Regex: \d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}
Açıklama: Tarih ve saat formatını arar
Kullanım: grep -E "\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}" app.log

JWT Örneği 4:
Regex: eyJ\w+\.\w+\.\w+
Açıklama: JWT token formatını arar
Kullanım: grep -E "eyJ\w+\.\w+\.\w+" auth.log
```

5. Gruplar ve Alternatifler ((), |)
```
(abc) : Grup oluşturur
a|b : a veya b'yi arar

Güvenlik Örneği 5:
Regex: (CRITICAL|ERROR|WARNING)
Açıklama: Farklı log seviyelerini arar
Kullanım: grep -E "(CRITICAL|ERROR|WARNING)" syslog

Protocol Örneği 5:
Regex: (http|https|ftp)://
Açıklama: Farklı protokolleri arar
Kullanım: grep -E "(http|https|ftp)://" urls.txt

Database Örneği 5:
Regex: (mysql|postgresql|mongodb)://\w+:\w+@
Açıklama: Database bağlantı stringlerini arar
Kullanım: grep -E "(mysql|postgresql|mongodb)://\w+:\w+@" config.yml
```

6. İleri Seviye Yapılar (Lookbehind, Lookahead)
```
(?=...) : Positive lookahead
(?!...) : Negative lookahead
(?<=...) : Positive lookbehind
(?<!...) : Negative lookbehind

Password Validation Örneği:
Regex: ^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$
Açıklama: Karmaşık şifre kurallarını kontrol eder
Kullanım: grep -P "^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" passwords.txt

URL Parsing Örneği:
Regex: (?<=href=")[^"]*
Açıklama: HTML href attribute değerlerini çıkarır
Kullanım: grep -P "(?<=href=\")[^\"]*" webpage.html

Log Analysis Örneği:
Regex: \b\w+(?=\s+failed)\b
Açıklama: "failed" kelimesinden önce gelen kelimeleri bulur
Kullanım: grep -P "\b\w+(?=\s+failed)\b" error.log
```

7. En Gelişmiş Örnekler
```
IP ve Port Validation:
Regex: ^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?::\d{1,5})?$
Açıklama: IP adresi ve opsiyonel port numarasını doğrular

SSL Certificate Analysis:
Regex: -----BEGIN\s+[^-]+-----[^-]*-----END\s+[^-]+-----
Açıklama: SSL sertifika içeriğini çıkarır

Advanced Log Pattern:
Regex: ^(?<timestamp>\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2},\d{3})\s+\[(?<thread>[^\]]+)\]\s+(?<level>\w+)\s+(?<logger>[^\s]+)\s+-\s+(?<message>.*)$
Açıklama: Yapılandırılmış log satırlarını parçalara ayırır
```

Bu örnekleri test etmek ve anlamak için:
1. https://regex101.com gibi online araçları kullanabilirsiniz
2. grep komutunun -E (extended regex) ve -P (perl regex) flaglerini öğrenin
3. Her örneği gerçek log dosyalarında test edin
4. Önce basit patternlerle başlayıp, karmaşıklığı yavaş yavaş artırın
