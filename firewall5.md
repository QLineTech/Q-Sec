# UFW ve Port Güvenliği Quiz

## TEMEL SEVİYE

### 1. UFW'de varsayılan olarak gelen trafiği reddetmek için hangi komut kullanılır?
- a) ufw deny incoming
- b) ufw default deny incoming ✓
- c) ufw block incoming
- d) ufw incoming deny

### 2. SSH servisinin varsayılan portu hangisidir?
- a) 21
- b) 22 ✓
- c) 23
- d) 25

### 3. HTTP trafiği için hangi port kullanılır?
- a) 443
- b) 8080
- c) 80 ✓
- d) 8443

### 4. UFW'yi aktif hale getirmek için hangi komut kullanılır?
- a) ufw start
- b) ufw active
- c) ufw enable ✓
- d) ufw run

## INTERMEDIATE SEVİYE

### 5. Rate limiting uygulamak için hangi UFW parametresi kullanılır?
- a) rate
- b) limit ✓
- c) throttle
- d) speed

### 6. Aşağıdakilerden hangisi güvenli bir mail protokolü DEĞİLDİR?
- a) SMTPS (port 465)
- b) SMTP (port 25) ✓
- c) IMAPS (port 993)
- d) POP3S (port 995)

### 7. UFW'de belirli bir kuralı silmek için hangi komut kullanılır?
- a) ufw remove
- b) ufw delete ✓
- c) ufw erase
- d) ufw clear

### 8. MySQL veritabanının varsayılan portu hangisidir?
- a) 5432
- b) 1433
- c) 3306 ✓
- d) 27017

## ADVANCED SEVİYE

### 9. Aşağıdaki UFW komutlarından hangisi dakikada maksimum 30 SSH bağlantısına izin verir?
- a) ufw allow 22/tcp rate 30/minute
- b) ufw limit proto tcp to any port 22 rate 30/minute
- c) ufw route allow proto tcp from any to any port 22 limit in rate 30/minute ✓
- d) ufw allow ssh limit 30/minute

### 10. DNS servisi için hangi portlar açılmalıdır?
- a) Sadece TCP/53
- b) Sadece UDP/53
- c) TCP/53 ve UDP/53 ✓
- d) TCP/53 ve TCP/853

## EXPERT SEVİYE

### 11. OpenVPN için aşağıdaki yapılandırmalardan hangisi en güvenlidir?
- a) ufw allow 1194
- b) ufw allow 1194/udp
- c) ufw limit 1194/udp
- d) ufw route allow proto udp from trusted_subnet to any port 1194 limit in rate 10/minute ✓

### 12. Ping flood saldırılarına karşı en etkili UFW kuralı hangisidir?
- a) ufw deny icmp
- b) ufw limit proto icmp ✓
- c) ufw allow icmp
- d) ufw block icmp

### 13. Hangisi bir web sunucusu için en kapsamlı güvenlik yapılandırmasıdır?
- a) ufw allow 80,443/tcp
- b) ufw allow http; ufw allow https
- c) ufw route allow proto tcp to any port 80,443 limit in rate 60/minute ✓
- d) ufw allow from any to any port 80,443

### 14. Belirli bir IP aralığından gelen SSH bağlantılarını sınırlamak için en uygun komut hangisidir?
- a) ufw allow from 192.168.1.0/24 to any port 22
- b) ufw limit from 192.168.1.0/24 to any port 22
- c) ufw allow from 192.168.1.0/24 proto tcp to any port 22
- d) ufw route allow from 192.168.1.0/24 to any port 22 limit in rate 6/minute ✓

### 15. Redis cache sunucusu için en güvenli UFW yapılandırması hangisidir?
- a) ufw allow 6379/tcp
- b) ufw allow from app_server to any port 6379
- c) ufw route allow proto tcp from app_server to redis_server port 6379 limit in rate 1000/minute ✓
- d) ufw allow proto tcp to any port 6379

## MASTER SEVİYE

### 16. Aşağıdakilerden hangisi bir mail sunucusu için en kapsamlı güvenlik yapılandırmasıdır?
- a) ufw allow 25,110,143/tcp
- b) ufw allow smtp,pop3,imap
- c) ufw route allow proto tcp from internal_network to mail_server port 25,110,143 limit in rate 30/minute ✓
- d) ufw allow from any to mail_server port 25,110,143

### 17. FTP sunucusu için en güvenli yapılandırma hangisidir?
- a) ufw allow 21,20/tcp
- b) ufw allow ftp
- c) ufw route allow proto tcp from trusted_network to ftp_server port 21,20 limit in rate 20/minute ✓
- d) ufw allow from any to any port 21,20

### 18. Kubernetes cluster için en uygun UFW yapılandırması hangisidir?
- a) ufw allow 6443,10250/tcp
- b) ufw allow from cluster_network to any port 6443,10250
- c) ufw route allow proto tcp from cluster_network to master_node port 6443,10250 limit in rate 100/minute ✓
- d) ufw allow kubernetes

### 19. Elastic Stack için en kapsamlı güvenlik yapılandırması hangisidir?
- a) ufw allow 9200,5601/tcp
- b) ufw allow elasticsearch,kibana
- c) ufw route allow proto tcp from monitoring_network to elastic_nodes port 9200,5601 limit in rate 1000/minute ✓
- d) ufw allow from any to any port 9200,5601

### 20. DDoS koruması için en etkili UFW yapılandırması hangisidir?
- a) ufw limit all
- b) ufw deny suspicious_ip
- c) ufw rate limit all connections
- d) Bir kombinasyon: rate limiting + connection limiting + ICMP flood protection + service-specific limits ✓

## BOŞLUK DOLDURMA SORULARI

### Part.1
1. UFW'de SSH erişimini sınırlamak için **limit** parametresi kullanılır.
2. HTTP için varsayılan port **80**, HTTPS için varsayılan port **443**'dir.
3. Mail sunucularında SMTP-TLS için port **587** kullanılır.
4. Redis cache sunucusu varsayılan olarak port **6379** üzerinden çalışır.
5. DNS servisi hem **TCP** hem de **UDP** protokollerini kullanır.
6. PostgreSQL veritabanı varsayılan olarak port **5432** kullanır.
7. UFW'de belirli bir IP'den gelen tüm trafiği engellemek için "ufw deny from **IP_ADDRESS**" komutu kullanılır.
8. OpenVPN servisi varsayılan olarak **UDP** protokolü ve **1194** portunu kullanır.
9. MongoDB varsayılan olarak port **27017** üzerinden hizmet verir.
10. Elasticsearch varsayılan olarak port **9200** kullanır.

### Bosluk Doldurma
12. Kubernetes API server varsayılan olarak port **6443** kullanır.
13. SFTP güvenli dosya transferi için port **22** kullanır.
14. UFW'de connection tracking için "**state** new recent set" parametresi kullanılır.
15. Grafana varsayılan olarak port **3000** üzerinden çalışır.
16. Jenkins CI/CD servisi varsayılan olarak port **8080** kullanır.
17. RabbitMQ yönetim arayüzü varsayılan olarak port **15672** kullanır.
18. MQTT protokolü varsayılan olarak port **1883** kullanır.
19. Prometheus metrics endpoint'i varsayılan olarak port **9090** kullanır.
20. Git üzerinden SSH erişimi için port **22** kullanılır.

## Part.2

### 1. Protokol ve Port
| Protokol    | Port |
|-------------|------|
| HTTPS       | 443  |
| SSH         | 22   |
| MySQL       | 3306 |
| PostgreSQL  | 5432 |
| Redis       | 6379 |

### 2. Mail Protokolleri
| Protokol | Port |
|----------|------|
| SMTP     | 25   |
| POP3     | 110  |
| IMAP     | 143  |
| SMTPS    | 465  |
| IMAPS    | 993  |

### 3. Monitoring
| Servis        | Port |
|---------------|------|
| Prometheus    | 9090 |
| Grafana       | 3000 |
| Elasticsearch | 9200 |
| Kibana        | 5601 |
| Node Exporter | 9100 |

### 4. Web Servisleri
| Servis  | Port |
|---------|------|
| HTTP    | 80   |
| HTTPS   | 443  |
| Tomcat  | 8080 |
| Apache  | 80   |
| Nginx   | 80   |

### 5. Database Ports
| Database   | Port   |
|------------|--------|
| MongoDB    | 27017  |
| MySQL      | 3306   |
| PostgreSQL | 5432   |
| Redis      | 6379   |
| Cassandra  | 9042   |

### 6. Güvenlik Protokolleri
| Protokol  | Port   |
|-----------|--------|
| OpenVPN   | 1194   |
| IPsec     | 500    |
| L2TP      | 1701   |
| PPTP      | 1723   |
| WireGuard | 51820  |

### 7. Containerization
| Servis          | Port        |
|-----------------|-------------|
| Docker API      | 2375        |
| Kubernetes API  | 6443        |
| etcd            | 2379        |
| Kubelet         | 10250       |
| NodePort range  | 30000-32767 |

### 8. Message Queues
| Servis    | Port   |
|-----------|--------|
| RabbitMQ  | 5672   |
| Kafka     | 9092   |
| ActiveMQ  | 61616  |
| ZeroMQ    | 5555   |
| MQTT      | 1883   |

### 9. CI/CD Tools
| Tool        | Port |
|-------------|------|
| Jenkins     | 8080 |
| GitLab      | 80   |
| Nexus       | 8081 |
| SonarQube   | 9000 |
| Artifactory | 8081 |

### 10. UFW Komutları
| Komut   | Açıklama     |
|---------|--------------|
| allow   | İzin ver     |
| deny    | Reddet       |
| limit   | Sınırla      |
| route   | Yönlendir    |
| status  | Durum göster |
