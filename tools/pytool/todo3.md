# Kali Linux Web Penetrasyon Test Araçları ve Örnek Komutlar (Devam)

## 11. skipfish

1. `skipfish -o output_dir http://example.com` - Temel tarama yap ve sonuçları kaydet
2. `skipfish -o output_dir -S complete.wl http://example.com` - Tam kelime listesi kullanarak tara
3. `skipfish -o output_dir -m 5 http://example.com` - Maksimum derinliği 5 olarak ayarla
4. `skipfish -o output_dir -u "admin:password" http://example.com` - Kimlik doğrulama kullan
5. `skipfish -o output_dir -X /admin http://example.com` - /admin dizinini hariç tut
6. `skipfish -o output_dir -I include_only.txt http://example.com` - Sadece belirli URL'leri tara
7. `skipfish -o output_dir -b high http://example.com` - Yüksek bant genişliği kullan
8. `skipfish -o output_dir -M http://example.com` - Form otomatik doldurma özelliğini devre dışı bırak
9. `skipfish -o output_dir -K http://example.com` - Akıllı 404 algılamayı devre dışı bırak
10. `skipfish -o output_dir -T 30 http://example.com` - İstek zaman aşımını 30 saniye olarak ayarla
11. `skipfish -o output_dir -W /path/to/wordlist.txt http://example.com` - Özel kelime listesi kullan
12. `skipfish -o output_dir -N http://example.com` - Pasif tarama modu kullan
13. `skipfish -o output_dir -Y http://example.com` - Fuzzing özelliğini devre dışı bırak
14. `skipfish -o output_dir -g http://example.com` - Google-friendly crawling kullan
15. `skipfish -o output_dir -B "PHPSESSID=1234567890abcdef" http://example.com` - Özel cookie kullan
16. `skipfish -o output_dir -H "User-Agent: MyCustomAgent" http://example.com` - Özel HTTP başlığı ekle
17. `skipfish -o output_dir -Q http://example.com` - Duplicate URL kontrolünü devre dışı bırak
18. `skipfish -o output_dir -k 100 http://example.com` - Maksimum 100 URL tara
19. `skipfish -o output_dir -i info.txt http://example.com` - Ek bilgi dosyası kullan
20. `skipfish -o output_dir -P http://proxy:8080 http://example.com` - Proxy kullan

## 12. arachni

1. `arachni http://example.com` - Temel tarama yap
2. `arachni --output-verbose --scope-page-limit 10 http://example.com` - Ayrıntılı çıktı ile 10 sayfa tara
3. `arachni --check=xss*,sql_injection* http://example.com` - Sadece XSS ve SQL enjeksiyon kontrolleri yap
4. `arachni --report-save-path=output.afr http://example.com` - Sonuçları .afr formatında kaydet
5. `arachni --plugin=autologin:url=http://example.com/login,parameters='username=admin&password=pass' http://example.com` - Otomatik giriş yap
6. `arachni --scope-exclude-pattern=logout http://example.com` - Çıkış sayfalarını hariç tut
7. `arachni --scope-directory-depth-limit=3 http://example.com` - Dizin derinliğini sınırla
8. `arachni --http-proxy=127.0.0.1:8080 http://example.com` - Proxy kullan
9. `arachni --checks-list` - Mevcut kontrolleri listele
10. `arachni --plugin=proxy --plugin-proxy-port=8080 http://example.com` - Proxy eklentisini kullan
11. `arachni --audit-links --audit-forms --audit-cookies http://example.com` - Linkleri, formları ve cookie'leri denetle
12. `arachni --spawn-browser http://example.com` - Tarayıcı başlat ve JavaScript'i işle
13. `arachni --login-check-pattern="Logout" http://example.com` - Giriş başarısını kontrol et
14. `arachni --timeout=01:30:00 http://example.com` - Zaman aşımını 1 saat 30 dakika olarak ayarla
15. `arachni --http-authentication-username=admin --http-authentication-password=pass http://example.com` - HTTP kimlik doğrulama kullan
16. `arachni --custom-header="X-Custom: Value" http://example.com` - Özel HTTP başlığı ekle
17. `arachni --report-save-path=report.html --plugin=html_report http://example.com` - HTML raporu oluştur
18. `arachni --scope-include-subdomains http://example.com` - Alt alan adlarını dahil et
19. `arachni --browser-cluster-pool-size=10 http://example.com` - 10 tarayıcı örneği kullan
20. `arachni --snapshot-save-path=snapshot.afs http://example.com` - Anlık görüntü kaydet

## 13. wpscan

1. `wpscan --url http://example.com` - Temel WordPress taraması yap
2. `wpscan --url http://example.com --enumerate u` - Kullanıcı adlarını enumere et
3. `wpscan --url http://example.com --enumerate p` - Eklentileri enumere et
4. `wpscan --url http://example.com --enumerate t` - Temaları enumere et
5. `wpscan --url http://example.com --enumerate v` - Güvenlik açığı bulunan eklentileri/temaları enumere et
6. `wpscan --url http://example.com --passwords /path/to/wordlist.txt` - Brute force saldırısı yap
7. `wpscan --url http://example.com --username admin` - Belirli bir kullanıcı adı için brute force yap
8. `wpscan --url http://example.com --disable-tls-checks` - TLS doğrulamasını devre dışı bırak
9. `wpscan --url http://example.com --random-user-agent` - Rastgele user agent kullan
10. `wpscan --url http://example.com --stealthy` - Gizli mod kullan
11. `wpscan --url http://example.com --force` - Agresif tarama yap
12. `wpscan --url http://example.com --wp-content-dir custom-content` - Özel wp-content dizini belirt
13. `wpscan --url http://example.com --enumerate cb` - Config backups'ları enumere et
14. `wpscan --url http://example.com --enumerate dbe` - Veritabanı dökümlerini enumere et
15. `wpscan --url http://example.com --api-token YOUR_TOKEN` - WPVulnDB API token'ı kullan
16. `wpscan --url http://example.com --rua` - Gerçek bir tarayıcının user agent'ını kullan
17. `wpscan --url http://example.com --detection-mode mixed` - Karma algılama modu kullan
18. `wpscan --url http://example.com --plugins-detection aggressive` - Agresif eklenti algılama kullan
19. `wpscan --url http://example.com --exclude-content-based "Not Found"` - "Not Found" içeren sonuçları hariç tut
20. `wpscan --url http://example.com --http-auth username:password` - HTTP kimlik doğrulama kullan

## 14. owasp-zap

Not: OWASP ZAP genellikle GUI ile kullanılır, ancak komut satırından da kullanılabilir. İşte bazı örnekler:

1. `zap.sh -cmd -quickurl http://example.com` - Hızlı tarama yap
2. `zap.sh -cmd -spider http://example.com` - Sadece örümcek taraması yap
3. `zap.sh -cmd -active http://example.com` - Aktif tarama yap
4. `zap.sh -daemon -config api.key=12345 -port 8080` - Daemon modunda başlat
5. `zap.sh -cmd -autorun zap.session` - Otomatik çalıştırma dosyası kullan
6. `zap.sh -cmd -quickout report.html http://example.com` - Hızlı tarama yapıp HTML raporu oluştur
7. `zap.sh -cmd -addoninstall sqliplugin` - SQL enjeksiyon eklentisini yükle
8. `zap.sh -cmd -addonuninstall sqliplugin` - SQL enjeksiyon eklentisini kaldır
9. `zap.sh -cmd -script script.js` - JavaScript dosyası çalıştır
10. `zap.sh -cmd -newsession session_name` - Yeni oturum oluştur
11. `zap.sh -cmd -session existing_session` - Var olan oturumu yükle
12. `zap.sh -cmd -context context_name` - Belirli bir bağlamı kullan
13. `zap.sh -cmd -user user_name` - Belirli bir kullanıcıyı kullan
14. `zap.sh -silent -config connection.timeoutInSecs=60` - Sessiz modda çalıştır ve zaman aşımını ayarla
15. `zap.sh -cmd -ajax http://example.com` - AJAX örümcek taraması yap
16. `zap.sh -cmd -scan -scanpolicy custom_policy` - Özel tarama politikası kullan
17. `zap.sh -cmd -quickprogress` - Hızlı ilerleme göster
18. `zap.sh -cmd -auth "http://example.com/login" -authusername user -authpassword pass` - Kimlik doğrulama kullan
19. `zap.sh -cmd -saveconfig config.xml` - Yapılandırmayı kaydet
20. `zap.sh -cmd -loadconfig config.xml` - Yapılandırmayı yükle

## 15. XSSer

1. `xsser -u "http://example.com/page?param=XSS"` - Temel XSS taraması yap
2. `xsser -u "http://example.com/page?param=XSS" --auto` - Otomatik mod kullan
3. `xsser -u "http://example.com/page?param=XSS" --Fp` - Tüm payload'ları kullan
4. `xsser -u "http://example.com/page?param=XSS" --reverse-check` - Ters kontrol yap
5. `xsser -u "http://example.com/page?param=XSS" --Exp` - Exploit modu kullan
6. `xsser -u "http://example.com/page?param=XSS" --cookie="PHPSESSID=1234abcd"` - Cookie kullan
7. `xsser -u "http://example.com/page?param=XSS" --proxy "http://127.0.0.1:8080"` - Proxy kullan
8. `xsser -u "http://example.com/page?param=XSS" --threads 10` - 10 thread kullan
9. `xsser -u "http://example.com/page?param=XSS" --timeout 30` - Zaman aşımını 30 saniye olarak ayarla
10. `xsser -u "http://example.com/page?param=XSS" --Cw` - Anti-XSS filtreleri atlatmaya çalış
11. `xsser -u "http://example.com/page?param=XSS" --save xss_report.txt` - Raporu kaydet
12. `xsser -u "http://example.com/page?param=XSS" --user-agent "Mozilla/5.0"` - Özel user agent kullan
13. `xsser -u "http://example.com/page?param=XSS" --referer "http://google.com"` - Özel referer kullan
14. `xsser -u "http://example.com/page?param=XSS" --auth-type basic --auth-cred "admin:password"` - HTTP kimlik doğrulama kullan
15. `xsser -u "http://example.com/page?param=XSS" --statistics` - İstatistikleri göster
16. `xsser -u "http://example.com/page?param=XSS" --followred` - Yönlendirmeleri takip et
17. `xsser -u "http://example.com/page?param=XSS" --ignore-proxy` - Sistem proxy ayarlarını yoksay
18. `xsser -u "http://example.com/page?param=XSS" --imx` - XSS payload'larını interaktif olarak seç
19. `xsser -u "http://example.com/page?param=XSS" --Check` - Sadece kontrol et, exploit etme
20. `xsser -u "http://example.com/page?param=XSS" --Hex` - Hexadecimal kodlama kullan