#!/bin/bash

# Kullanım kontrolü
if [ $# -eq 0 ]; then
    echo "Kullanım: $0 <IP adresi>"
    exit 1
fi

IP=$1

# Fonksiyon: Port kontrolü ve sonuç üretme
check_port() {
    local port=$1
    local service=$2
    local result=$(nmap -p$port -sV $IP | grep "$port/tcp")
    if [[ $result == *"open"* ]]; then
        echo "      \"$service\": \"Açık - ${result##*:}\""
    else
        echo "      \"$service\": \"Kapalı\""
    fi
}

# JSON çıktısının başlangıcı
echo "{"
echo "  \"ip_address\": \"$IP\","

# İşletim sistemi tespiti
echo "  \"os_detection\": {"
echo "    \"nmap_os\": \"$(sudo nmap -O $IP | grep "OS details:" | sed 's/OS details: //')\""
echo "  },"

# Tüm portların taranması
# echo "  \"all_ports_scan\": {"
# echo "    \"open_ports\": ["
# nmap -p- $IP | grep ^[0-9] | awk '{print $1}' | tr '\n' ',' | sed 's/,$//'
# echo
# echo "    ]"
# echo "  },"

# Kategorilendirilmiş port taramaları
echo "  \"categorized_port_scan\": {"

# Unix/Linux portları
echo "    \"unix_linux\": {"
check_port 22 "SSH"
check_port 111 "RPC"
check_port 2049 "NFS"
echo "    },"

# Web sunucu portları
echo "    \"web_server\": {"
check_port 80 "HTTP"
check_port 443 "HTTPS"
echo "    },"

# FTP portları
echo "    \"ftp\": {"
check_port 21 "FTP"
check_port 22 "SFTP"
echo "    },"

# Windows portları
echo "    \"windows\": {"
check_port 3389 "RDP"
check_port 445 "SMB"
check_port 135 "RPC"
echo "    },"

# Veritabanı portları
echo "    \"database\": {"
check_port 3306 "MySQL"
check_port 1433 "SQL Server"
check_port 5432 "PostgreSQL"
check_port 27017 "MongoDB"
check_port 9042 "Cassandra"
check_port 16000 "HBase"
check_port 1521 "Oracle"
check_port 3050 "InterBase"
echo "    },"

# Android portları
echo "    \"android\": {"
check_port 5555 "ADB"
echo "    },"

# iOS portları
echo "    \"ios\": {"
check_port 62078 "Apple Mobile Device"
echo "    },"

# macOS portları
echo "    \"macos\": {"
check_port 548 "AFP"
check_port 5900 "VNC"
echo "    },"

# Yazıcı portları
echo "    \"printer\": {"
check_port 631 "IPP"
check_port 515 "LPD"
check_port 9100 "Raw Print"
echo "    },"

# Diğer işletim sistemi portları
echo "    \"other_os\": {"
check_port 137 "NetBIOS"
check_port 139 "NetBIOS"
check_port 161 "SNMP"
check_port 389 "LDAP"
check_port 636 "LDAPS"
echo "    },"

# E-posta portları
echo "    \"email\": {"
check_port 25 "SMTP"
check_port 587 "SMTP (Submission)"
check_port 465 "SMTPS"
check_port 110 "POP3"
check_port 995 "POP3S"
check_port 143 "IMAP"
check_port 993 "IMAPS"
echo "    }"

echo "  }"
echo "}"