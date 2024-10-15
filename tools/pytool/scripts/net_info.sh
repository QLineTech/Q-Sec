#!/bin/bash

# Function to get public IP
get_public_ip() {
    curl -s https://api.ipify.org
}

# Function to get local IP
get_local_ip() {
    ip route get 1 | awk '{print $7; exit}'
}

# Function to scan local network
scan_network() {
    local_ip=$(get_local_ip)
    subnet=$(echo $local_ip | cut -d. -f1-3)
    
    echo "Scanning local network. This may take a while..."
    nmap -sn $subnet.0/24 | grep "Nmap scan report for" | cut -d " " -f5-
}

# Main script
echo "MY PUBLIC IP:"
get_public_ip
echo

echo "MY LOCAL IP:"
get_local_ip
echo

echo "HOSTS ONLINE IN LOCAL NETWORK:"
scan_network