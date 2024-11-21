
1) UFW'de varsayılan olarak gelen trafiği reddetmek için hangi komut kullanılır?
a) ufw deny incoming
b) ufw default deny incoming
c) ufw block incoming
d) ufw incoming deny

Cevap: b) ufw default deny incoming

2) SSH servisinin varsayılan portu hangisidir?
a) 21
b) 22
c) 23
d) 25

Cevap: b) 22

3) HTTP trafiği için hangi port kullanılır?
a) 443
b) 8080
c) 80
d) 8443

Cevap: c) 80

4) UFW'yi aktif hale getirmek için hangi komut kullanılır?
a) ufw start
b) ufw active
c) ufw enable
d) ufw run

Cevap: c) ufw enable

INTERMEDIATE SEVİYE:

5) Rate limiting uygulamak için hangi UFW parametresi kullanılır?
a) rate
b) limit
c) throttle
d) speed

Cevap: b) limit

6) Aşağıdakilerden hangisi güvenli bir mail protokolü DEĞİLDİR?
a) SMTPS (port 465)
b) SMTP (port 25)
c) IMAPS (port 993)
d) POP3S (port 995)

Cevap: b) SMTP (port 25)

7) UFW'de belirli bir kuralı silmek için hangi komut kullanılır?
a) ufw remove
b) ufw delete
c) ufw erase
d) ufw clear

Cevap: b) ufw delete

8) MySQL veritabanının varsayılan portu hangisidir?
a) 5432
b) 1433
c) 3306
d) 27017

Cevap: c) 3306

ADVANCED SEVİYE:

9) Aşağıdaki UFW komutlarından hangisi dakikada maksimum 30 SSH bağlantısına izin verir?
a) ufw allow 22/tcp rate 30/minute
b) ufw limit proto tcp to any port 22 rate 30/minute
c) ufw route allow proto tcp from any to any port 22 limit in rate 30/minute
d) ufw allow ssh limit 30/minute

Cevap: c) ufw route allow proto tcp from any to any port 22 limit in rate 30/minute

10) DNS servisi için hangi portlar açılmalıdır?
a) Sadece TCP/53
b) Sadece UDP/53
c) TCP/53 ve UDP/53
d) TCP/53 ve TCP/853

Cevap: c) TCP/53 ve UDP/53

EXPERT SEVİYE:

11) OpenVPN için aşağıdaki yapılandırmalardan hangisi en güvenlidir?
a) ufw allow 1194
b) ufw allow 1194/udp
c) ufw limit 1194/udp
d) ufw route allow proto udp from trusted_subnet to any port 1194 limit in rate 10/minute

Cevap: d) ufw route allow proto udp from trusted_subnet to any port 1194 limit in rate 10/minute

12) Ping flood saldırılarına karşı en etkili UFW kuralı hangisidir?
a) ufw deny icmp
b) ufw limit proto icmp
c) ufw allow icmp
d) ufw block icmp

Cevap: b) ufw limit proto icmp

13) Hangisi bir web sunucusu için en kapsamlı güvenlik yapılandırmasıdır?
a) ufw allow 80,443/tcp
b) ufw allow http; ufw allow https
c) ufw route allow proto tcp to any port 80,443 limit in rate 60/minute
d) ufw allow from any to any port 80,443

Cevap: c) ufw route allow proto tcp to any port 80,443 limit in rate 60/minute

14) Belirli bir IP aralığından gelen SSH bağlantılarını sınırlamak için en uygun komut hangisidir?
a) ufw allow from 192.168.1.0/24 to any port 22
b) ufw limit from 192.168.1.0/24 to any port 22
c) ufw allow from 192.168.1.0/24 proto tcp to any port 22
d) ufw route allow from 192.168.1.0/24 to any port 22 limit in rate 6/minute

Cevap: d) ufw route allow from 192.168.1.0/24 to any port 22 limit in rate 6/minute

15) Redis cache sunucusu için en güvenli UFW yapılandırması hangisidir?
a) ufw allow 6379/tcp
b) ufw allow from app_server to any port 6379
c) ufw route allow proto tcp from app_server to redis_server port 6379 limit in rate 1000/minute
d) ufw allow proto tcp to any port 6379

Cevap: c) ufw route allow proto tcp from app_server to redis_server port 6379 limit in rate 1000/minute

MASTER SEVİYE:

16) Aşağıdakilerden hangisi bir mail sunucusu için en kapsamlı güvenlik yapılandırmasıdır?
a) ufw allow 25,110,143/tcp
b) ufw allow smtp,pop3,imap
c) ufw route allow proto tcp from internal_network to mail_server port 25,110,143 limit in rate 30/minute
d) ufw allow from any to mail_server port 25,110,143

Cevap: c) ufw route allow proto tcp from internal_network to mail_server port 25,110,143 limit in rate 30/minute

17) FTP sunucusu için en güvenli yapılandırma hangisidir?
a) ufw allow 21,20/tcp
b) ufw allow ftp
c) ufw route allow proto tcp from trusted_network to ftp_server port 21,20 limit in rate 20/minute
d) ufw allow from any to any port 21,20

Cevap: c) ufw route allow proto tcp from trusted_network to ftp_server port 21,20 limit in rate 20/minute

18) Kubernetes cluster için en uygun UFW yapılandırması hangisidir?
a) ufw allow 6443,10250/tcp
b) ufw allow from cluster_network to any port 6443,10250
c) ufw route allow proto tcp from cluster_network to master_node port 6443,10250 limit in rate 100/minute
d) ufw allow kubernetes

Cevap: c) ufw route allow proto tcp from cluster_network to master_node port 6443,10250 limit in rate 100/minute

19) Elastic Stack için en kapsamlı güvenlik yapılandırması hangisidir?
a) ufw allow 9200,5601/tcp
b) ufw allow elasticsearch,kibana
c) ufw route allow proto tcp from monitoring_network to elastic_nodes port 9200,5601 limit in rate 1000/minute
d) ufw allow from any to any port 9200,5601

Cevap: c) ufw route allow proto tcp from monitoring_network to elastic_nodes port 9200,5601 limit in rate 1000/minute

20) DDoS koruması için en etkili UFW yapılandırması hangisidir?
a) ufw limit all
b) ufw deny suspicious_ip
c) ufw rate limit all connections
d) Bir kombinasyon: rate limiting + connection limiting + ICMP flood protection + service-specific limits

Cevap: d) Bir kombinasyon: rate limiting + connection limiting + ICMP flood protection + service-specific limits


İşte UFW ve port güvenliği konusunda boşluk doldurma ve eşleştirme soruları:

BOŞLUK DOLDURMA (ORTA VE ZOR SEVİYE):

Orta Seviye:
1. UFW'de SSH erişimini sınırlamak için _______ parametresi kullanılır.
(Cevap: limit)

2. HTTP için varsayılan port _____, HTTPS için varsayılan port _____ 'dir.
(Cevap: 80, 443)

3. Mail sunucularında SMTP-TLS için port _____ kullanılır.
(Cevap: 587)

4. Redis cache sunucusu varsayılan olarak port _____ üzerinden çalışır.
(Cevap: 6379)

5. DNS servisi hem _____ hem de _____ protokollerini kullanır.
(Cevap: TCP, UDP)

6. PostgreSQL veritabanı varsayılan olarak port _____ kullanır.
(Cevap: 5432)

7. UFW'de belirli bir IP'den gelen tüm trafiği engellemek için "ufw deny from _____" komutu kullanılır.
(Cevap: IP_ADDRESS)

8. OpenVPN servisi varsayılan olarak _____ protokolü ve _____ portunu kullanır.
(Cevap: UDP, 1194)

9. MongoDB varsayılan olarak port _____ üzerinden hizmet verir.
(Cevap: 27017)

10. Elasticsearch varsayılan olarak port _____ kullanır.
(Cevap: 9200)

Zor Seviye:
11. UFW'de rate limiting uygulamak için "limit in rate _____/minute" söz dizimi kullanılır.
(Cevap: NUMBER)

12. Kubernetes API server varsayılan olarak port _____ kullanır.
(Cevap: 6443)

13. SFTP güvenli dosya transferi için port _____ kullanır.
(Cevap: 22)

14. UFW'de connection tracking için "_____ new recent set" parametresi kullanılır.
(Cevap: state)

15. Grafana varsayılan olarak port _____ üzerinden çalışır.
(Cevap: 3000)

16. Jenkins CI/CD servisi varsayılan olarak port _____ kullanır.
(Cevap: 8080)

17. RabbitMQ yönetim arayüzü varsayılan olarak port _____ kullanır.
(Cevap: 15672)

18. MQTT protokolü varsayılan olarak port _____ kullanır.
(Cevap: 1883)

19. Prometheus metrics endpoint'i varsayılan olarak port _____ kullanır.
(Cevap: 9090)

20. Git üzerinden SSH erişimi için port _____ kullanılır.
(Cevap: 22)

EŞLEŞTIRME SORULARI :

1. Eşleştirme Grubu: Protokol ve Port

A. HTTPS          1. 22
B. SSH            2. 443
C. MySQL          3. 3306
D. PostgreSQL     4. 5432
E. Redis          5. 6379

2. Eşleştirme Grubu: Mail Protokolleri

A. SMTP           1. 110
B. POP3           2. 25
C. IMAP           3. 143
D. SMTPS          4. 465
E. IMAPS          5. 993

3. Eşleştirme Grubu: Monitoring

A. Prometheus     1. 3000
B. Grafana        2. 9090
C. Elasticsearch  3. 9200
D. Kibana         4. 5601
E. Node Exporter  5. 9100

4. Eşleştirme Grubu: Web Servisleri

A. HTTP           1. 80
B. HTTPS          2. 443
C. Tomcat         3. 8080
D. Apache         4. 80
E. Nginx          5. 80

5. Eşleştirme Grubu: Database Ports

A. MongoDB        1. 27017
B. MySQL          2. 3306
C. PostgreSQL     3. 5432
D. Redis          4. 6379
E. Cassandra      5. 9042

Zor Seviye:
6. Eşleştirme Grubu: Güvenlik Protokolleri

A. OpenVPN        1. 1194
B. IPsec          2. 500
C. L2TP           3. 1701
D. PPTP           4. 1723
E. WireGuard      5. 51820

7. Eşleştirme Grubu: Containerization

A. Docker API     1. 2375
B. Kubernetes API 2. 6443
C. etcd           3. 2379
D. Kubelet        4. 10250
E. NodePort range 5. 30000-32767

8. Eşleştirme Grubu: Message Queues

A. RabbitMQ       1. 5672
B. Kafka          2. 9092
C. ActiveMQ       3. 61616
D. ZeroMQ         4. 5555
E. MQTT           5. 1883

9. Eşleştirme Grubu: CI/CD Tools

A. Jenkins        1. 8080
B. GitLab         2. 80
C. Nexus          3. 8081
D. SonarQube      4. 9000
E. Artifactory    5. 8081

10. Eşleştirme Grubu: UFW Komutları

A. allow          1. İzin ver
B. deny           2. Reddet
C. limit          3. Sınırla
D. route          4. Yönlendir
E. status         5. Durum göster

Her bir eşleştirme grubunda soldaki harflerle (A,B,C,D,E) sağdaki sayıları (1,2,3,4,5) eşleştirmeniz gerekmektedir.

