# Kali Linux Web Penetrasyon Test Araçları ve Örnek Komutlar

## 1. nmap

1. `nmap 192.168.1.1` - Belirtilen IP adresini tara
2. `nmap -p- 192.168.1.1` - Tüm portları tara
3. `nmap -sV 192.168.1.1` - Servis/versiyon bilgisi topla
4. `nmap -O 192.168.1.1` - İşletim sistemi tespiti yap
5. `nmap -sU -p123,161,500 192.168.1.1` - Belirli UDP portlarını tara
6. `nmap -sS 192.168.1.0/24` - Stealth SYN taraması yap
7. `nmap -sA 192.168.1.1` - ACK taraması yap
8. `nmap -sC 192.168.1.1` - Varsayılan script taraması yap
9. `nmap -sV --script vuln 192.168.1.1` - Güvenlik açığı taraması yap
10. `nmap -p80 --script http-enum 192.168.1.1` - HTTP enumeration yap
11. `nmap -sn 192.168.1.0/24` - Ping taraması yap
12. `nmap -f 192.168.1.1` - Parçalanmış paketler kullan
13. `nmap -D RND:10 192.168.1.1` - Rastgele 10 IP ile aldatma yap
14. `nmap --spoof-mac 0 192.168.1.1` - Rastgele MAC adresi kullan
15. `nmap -sV --version-intensity 9 192.168.1.1` - Agresif versiyon taraması yap
16. `nmap -sI zombie_host 192.168.1.1` - Idle scan yap
17. `nmap --script ssl-enum-ciphers -p 443 192.168.1.1` - SSL/TLS cipherları enumere et
18. `nmap --script dns-brute domain.com` - DNS brute force yap
19. `nmap -sV --script=banner 192.168.1.1` - Banner grabbing yap
20. `nmap -p- -sV -sC -oA full_scan 192.168.1.1` - Kapsamlı tarama yapıp sonuçları kaydet

## 2. nikto

1. `nikto -h http://192.168.1.1` - Temel tarama yap
2. `nikto -h http://192.168.1.1 -ssl` - SSL üzerinden tara
3. `nikto -h http://192.168.1.1 -port 8080` - Belirli bir portu tara
4. `nikto -h http://192.168.1.1 -Tuning 1234` - Belirli testleri çalıştır
5. `nikto -h http://192.168.1.1 -output rapor.html` - Sonuçları HTML formatında kaydet
6. `nikto -h http://192.168.1.1 -dbcheck` - Veritabanı güncellemelerini kontrol et
7. `nikto -h http://192.168.1.1 -evasion 1` - IDS/IPS atlatma tekniği kullan
8. `nikto -h http://192.168.1.1 -useragent "Mozilla/5.0"` - Özel user agent kullan
9. `nikto -h http://192.168.1.1 -mutate 1` - Parametre mutasyonları yap
10. `nikto -h http://192.168.1.1 -timeout 10` - Zaman aşımı süresini ayarla
11. `nikto -h http://192.168.1.1 -plugins "apacheusers(;"` - Belirli eklentileri çalıştır
12. `nikto -h http://192.168.1.1 -nolookup` - DNS çözümlemesi yapma
13. `nikto -h http://192.168.1.1 -ask` - Her test için onay iste
14. `nikto -h http://192.168.1.1 -config /path/to/config` - Özel yapılandırma dosyası kullan
15. `nikto -h http://192.168.1.1 -Format csv` - Sonuçları CSV formatında kaydet
16. `nikto -h http://192.168.1.1 -id admin:password` - Kimlik doğrulama bilgilerini kullan
17. `nikto -h http://192.168.1.1 -nokeepalive` - Keep-alive bağlantıları kullanma
18. `nikto -h http://192.168.1.1 -no404` - 404 kontrollerini devre dışı bırak
19. `nikto -h http://192.168.1.1 -maxtime 1h` - Maksimum çalışma süresini belirle
20. `nikto -h http://192.168.1.1 -root /admin/` - Belirli bir dizinden başla

## 3. dirb

1. `dirb http://192.168.1.1` - Temel dizin taraması yap
2. `dirb http://192.168.1.1 /usr/share/dirb/wordlists/big.txt` - Özel wordlist kullan
3. `dirb http://192.168.1.1 -X .php,.html` - Belirli uzantıları tara
4. `dirb http://192.168.1.1 -o output.txt` - Sonuçları dosyaya kaydet
5. `dirb http://192.168.1.1 -r` - Recursive olmayan tarama yap
6. `dirb http://192.168.1.1 -w` - Bulunan URL'leri gösterme
7. `dirb http://192.168.1.1 -N 404` - 404 sayfalarını yoksay
8. `dirb http://192.168.1.1 -z 1000` - Milisaniye cinsinden gecikme ekle
9. `dirb http://192.168.1.1 -a "Mozilla/5.0"` - Özel user agent kullan
10. `dirb http://192.168.1.1 -p proxy.server:port` - Proxy kullan
11. `dirb http://192.168.1.1 -c "cookie1=value1; cookie2=value2"` - Cookie kullan
12. `dirb http://192.168.1.1 -u admin:password` - Kimlik doğrulama bilgilerini kullan
13. `dirb http://192.168.1.1 -R` - Interactive rehberi kullanarak tara
14. `dirb http://192.168.1.1 -S` - Sessiz mod kullan, sadece bulunan URL'leri göster
15. `dirb http://192.168.1.1 -x extensionsfile.txt` - Uzantıları dosyadan oku
16. `dirb http://192.168.1.1 -H "Referer: http://example.com"` - Özel HTTP başlığı ekle
17. `dirb http://192.168.1.1 -f` - Ayrıntılı çıktı göster
18. `dirb http://192.168.1.1 -t 20` - Thread sayısını ayarla
19. `dirb https://192.168.1.1 -k` - SSL sertifika doğrulamasını atla
20. `dirb http://192.168.1.1 -l` - URL'lerin sonuna eğik çizgi ekle

## 4. gobuster

1. `gobuster dir -u http://192.168.1.1 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt` - Dizin taraması yap
2. `gobuster dns -d example.com -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt` - DNS alt alan adı taraması yap
3. `gobuster vhost -u http://example.com -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt` - Sanal host taraması yap
4. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -t 50` - 50 thread ile tarama yap
5. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -s "200,204,301,302,307,401,403"` - Belirli durum kodlarını ara
6. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -x php,txt,html` - Belirli uzantıları tara
7. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -o output.txt` - Sonuçları dosyaya kaydet
8. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -U admin -P password` - Kimlik doğrulama kullan
9. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -k` - SSL sertifika doğrulamasını atla
10. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -a "Mozilla/5.0"` - Özel user agent kullan
11. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -r` - Yönlendirmeleri takip et
12. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -c "PHPSESSID=1234567890abcdef"` - Cookie kullan
13. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -f` - URL sonuna / ekle
14. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -n` - Durum kodlarını gösterme
15. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -e` - Genişletilmiş çıktı göster
16. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -q` - Sessiz mod kullan
17. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -p http://proxy:port` - Proxy kullan
18. `gobuster dir -u http://192.168.1.1 -w wordlist.txt --wildcard` - Wildcard yanıtlarını zorla
19. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -b "403,404"` - Belirli durum kodlarını yoksay
20. `gobuster dir -u http://192.168.1.1 -w wordlist.txt -H "X-Custom-Header: Value"` - Özel HTTP başlığı ekle

## 5. wfuzz

1. `wfuzz -c -z file,wordlist.txt http://192.168.1.1/FUZZ` - Temel fuzzing yap
2. `wfuzz -c -z file,users.txt -z file,pass.txt http://192.168.1.1/login.php?user=FUZZ&pass=FUZ2Z` - Çoklu parametre fuzzing
3. `wfuzz -c -z range,1-100 http://192.168.1.1/page.php?id=FUZZ` - Sayısal değer fuzzing
4. `wfuzz -c -z file,wordlist.txt --hc 404 http://192.168.1.1/FUZZ` - 404 yanıtlarını gizle
5. `wfuzz -c -z file,wordlist.txt --hl 20 http://192.168.1.1/FUZZ` - Belirli uzunluktaki yanıtları gizle
6. `wfuzz -c -z file,wordlist.txt --hh 4000 http://192.168.1.1/FUZZ` - Belirli boyuttaki yanıtları gizle
7. `wfuzz -c -z file,wordlist.txt -R 3 http://192.168.1.1/FUZZ` - Recursive fuzzing yap
8. `wfuzz -c -z file,wordlist.txt -p 127.0.0.1:8080 http://192.168.1.1/FUZZ` - Proxy kullan
9. `wfuzz -c -z file,wordlist.txt -b cookie=value http://192.168.1.1/FUZZ` - Cookie kullan
10. `wfuzz -c -z file,wordlist.txt -H "User-Agent: MyCustomUserAgent" http://192.168.1.1/FUZZ` - Özel HTTP başlığı ekle
11. `wfuzz -c -z file,wordlist.txt -d "username=FUZZ&password=test" http://192.168.1.1/login.php` - POST isteği gönder
12. `wfuzz -c -z file,wordlist.txt -X PUT http://192.168.1.1/FUZZ` - PUT isteği gönder
13. `wfuzz -c -z file,wordlist.txt --basic admin:password http://192.168.1.1/FUZZ` - Basic auth kullan
14. `wfuzz -c -z file,wordlist.txt --script=robots http://192.168.1.1/FUZZ` - Belirli bir script çalıştır
15. `wfuzz -c -z file,wordlist.txt -o html http://192.168.1.1/FUZZ` - Sonuçları HTML formatında kaydet
16. `wfuzz -c -z file,wordlist.txt -t 20 http://192.168.1.1/FUZZ` - Thread sayısını ayarla
17. `wfuzz -c -z file,wordlist.txt --ss "Login successful" http://192.168.1.1/FUZZ` - Belirli bir string içeren yanıtları göster
18. `wfuzz -c -z file,wordlist.txt --filter "c=200 and l>100" http://192.168.1.1/FUZZ` - Özel filtre kullan
19. `wfuzz -c -z file,wordlist.txt --follow http://192.168.1.1/FUZZ` - Yönlendirmeleri takip et
20. `wfuzz -c -z file,wordlist.txt