# ModSecurity Kurulum ve Konfigürasyon Rehberi

## İçindekiler
1. ModSecurity Nedir?
2. Kurulum
3. Temel Konfigürasyon
4. SQL Enjeksiyon Koruması
5. Test ve Doğrulama

## 1. ModSecurity Nedir?

ModSecurity, açık kaynaklı bir Web Application Firewall (WAF) çözümüdür. Apache, Nginx ve IIS web sunucuları ile uyumlu çalışır ve web uygulamalarını çeşitli saldırılara karşı korur.

## 2. Kurulum

### Ubuntu/Debian Sistemlerde:

```bash
# Apache için ModSecurity kurulumu
sudo apt-get update
sudo apt-get install libapache2-mod-security2

# ModSecurity'yi aktif etme
sudo a2enmod security2
sudo systemctl restart apache2
```

### CentOS/RHEL Sistemlerde:

```bash
# ModSecurity kurulumu
sudo yum install mod_security
sudo systemctl restart httpd
```

## 3. Temel Konfigürasyon

1. Örnek konfigürasyon dosyasını kopyalayın:
```bash
sudo cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
```

2. Temel ayarları düzenleyin:
```apache
# /etc/modsecurity/modsecurity.conf

# ModSecurity'yi aktif etme
SecRuleEngine On

# Loglama ayarları
SecAuditEngine RelevantOnly
SecAuditLog /var/log/apache2/modsec_audit.log

# Varsayılan karakter seti
SecArgumentsLimit 1000
SecRequestBodyLimit 13107200
```

## 4. SQL Enjeksiyon Koruması

### 4.1 Temel SQL Enjeksiyon Kuralları

ModSecurity'de SQL enjeksiyon koruması için kuralları `/etc/modsecurity/rules/` dizini altına ekleyin:

```apache
# sql-injection.conf

# SQL anahtar kelimelerini engelleme
SecRule REQUEST_COOKIES|REQUEST_COOKIES_NAMES|REQUEST_FILENAME|REQUEST_HEADERS|REQUEST_HEADERS_NAMES|REQUEST_METHOD|REQUEST_PROTOCOL|REQUEST_URI|REQUEST_URI_RAW|ARGS|ARGS_NAMES|REQUEST_LINE "@detectSQLi" \
    "id:942100,\
    phase:2,\
    block,\
    capture,\
    t:none,t:urlDecodeUni,t:sqlDecodeChar,\
    msg:'SQL Injection Attack Detected',\
    logdata:'Matched Data: %{TX.0} found within %{MATCHED_VAR_NAME}: %{MATCHED_VAR}',\
    tag:'application-multi',\
    tag:'language-multi',\
    tag:'platform-multi',\
    tag:'attack-sqli',\
    severity:'CRITICAL',\
    setvar:'tx.sql_injection_score=+%{tx.critical_anomaly_score}',\
    setvar:'tx.anomaly_score=+%{tx.critical_anomaly_score}'"

# SQL özel karakterleri engelleme
SecRule REQUEST_COOKIES|REQUEST_COOKIES_NAMES|REQUEST_FILENAME|REQUEST_HEADERS|REQUEST_HEADERS_NAMES|REQUEST_METHOD|REQUEST_PROTOCOL|REQUEST_URI|REQUEST_URI_RAW|ARGS|ARGS_NAMES|REQUEST_LINE "@rx (?i:(?:\b(?:(?:s(?:elect\b(?:.{1,100}?\b(?:(?:(?:length|count|top)\b.{1,100})?from|.*?\b(?:union|join)\b)|ys\.(?:master|objects|syscolumns)\b)|p_(?:(?:addextendedpr|sqlexe)c|(?:oa)?create|prepare)(?:[\s'"]+|/\*[^*/]*\*/)|(?:open)?query)|insert(?:[\s'"]+|/\*[^*/]*\*/)+(?:into|exec)|update(?:[\s'"]+|/\*[^*/]*\*/)+[\w\"']+\bset|delete(?:[\s'"]+|/\*[^*/]*\*/)+from(?: [\w\"']+)?)|alter\b|drop\b|truncate\b|union\b|create\b|rename\b)))" \
    "id:942200,\
    phase:2,\
    block,\
    capture,\
    t:none,t:urlDecodeUni,\
    msg:'SQL Injection Attack: SQL Keyword Detected',\
    logdata:'Matched Data: %{TX.0} found within %{MATCHED_VAR_NAME}: %{MATCHED_VAR}',\
    tag:'application-multi',\
    tag:'language-multi',\
    tag:'platform-multi',\
    tag:'attack-sqli',\
    severity:'CRITICAL'"
```

### 4.2 OWASP CRS Kurallarını Ekleme

OWASP Core Rule Set (CRS), ModSecurity için hazır güvenlik kuralları sağlar:

```bash
# CRS kurallarını indirme
cd /etc/modsecurity
git clone https://github.com/coreruleset/coreruleset.git
mv coreruleset/crs-setup.conf.example coreruleset/crs-setup.conf
```

Apache konfigürasyonuna CRS kurallarını ekleyin:

```apache
# /etc/apache2/mods-enabled/security2.conf

IncludeOptional /etc/modsecurity/coreruleset/crs-setup.conf
IncludeOptional /etc/modsecurity/coreruleset/rules/*.conf
```

## 5. Test ve Doğrulama

SQL enjeksiyon korumasını test etmek için:

```bash
# Test URL'si
curl "http://your-website.com/page.php?id=1' OR '1'='1"

# Log kontrolü
tail -f /var/log/apache2/modsec_audit.log
```

### Örnek SQL Enjeksiyon Saldırısı Tespiti

ModSecurity aşağıdaki gibi saldırıları tespit edip engelleyecektir:

- `parameter=1 OR 1=1`
- `username=' OR '1'='1`
- `id=1; DROP TABLE users`

### Hata Ayıklama

Eğer ModSecurity gerçek trafiği engelliyor ise:

1. Debug modunu aktifleştirin:
```apache
SecDebugLog /var/log/apache2/modsec_debug.log
SecDebugLogLevel 3
```

2. False positive durumunda kural istisnası ekleyin:
```apache
SecRuleRemoveById 942100
# veya
SecRuleUpdateTargetById 942100 "!REQUEST_COOKIES:/^JSESSIONID$/"
```
