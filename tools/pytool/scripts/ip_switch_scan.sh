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

# Cihaz türü tespiti
echo "  \"device_type\": {"
echo "    \"nmap_os\": \"$(sudo nmap -O $IP | grep "OS details:" | sed 's/OS details: //')\""
echo "  },"

# Tüm portların taranması
echo "  \"all_ports_scan\": {"
echo "    \"open_ports\": ["
nmap -p- $IP | grep ^[0-9] | awk '{print $1}' | tr '\n' ',' | sed 's/,$//'
echo
echo "    ]"
echo "  },"

# Kategorilendirilmiş port taramaları
echo "  \"network_device_ports\": {"

# Yönetim portları
echo "    \"management_ports\": {"
check_port 22 "SSH"
check_port 23 "Telnet"
check_port 80 "HTTP"
check_port 443 "HTTPS"
echo "    },"

# SNMP portları
echo "    \"snmp_ports\": {"
check_port 161 "SNMP"
check_port 162 "SNMP Trap"
echo "    },"

# Cisco özel portları
echo "    \"cisco_specific_ports\": {"
check_port 1741 "CiscoWorks"
check_port 2000 "Cisco SCCP"
check_port 2002 "Cisco ACS"
echo "    },"

# Routing protokol portları
echo "    \"routing_protocol_ports\": {"
check_port 179 "BGP"
check_port 520 "RIP"
check_port 1985 "HSRP"
echo "    },"

# VoIP portları
echo "    \"voip_ports\": {"
check_port 5060 "SIP"
check_port 5061 "SIP-TLS"
echo "    },"

# Diğer yaygın ağ cihazı portları
echo "    \"other_network_ports\": {"
check_port 69 "TFTP"
check_port 123 "NTP"
check_port 514 "Syslog"
check_port 1812 "RADIUS"
check_port 1813 "RADIUS Accounting"
echo "    }"

echo "  },"

# SNMP bilgi toplama
echo "  \"snmp_info\": {"
echo "    \"system_description\": \"$(snmpget -v2c -c public $IP 1.3.6.1.2.1.1.1.0 2>/dev/null | awk -F: '{print $4}' | sed 's/^[ \t]*//')\""
echo "  }"

echo "}"