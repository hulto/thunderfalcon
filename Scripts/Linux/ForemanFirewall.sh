#!/bin/sh

# Author: Abdul Azeez Omar
# Name: ForemanFirewall.sh
# Purpose: This script whitelists specific traffic for Stacy PC in/out traffic with iptables.

# Set default action of iptables to drop traffic
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP

# DNS - Allows DNS client connects
sudo iptables -A OUTPUT -p udp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p udp --sport 53 -m state --state ESTABLISHED -j ACCEPT

# ICMP - Allows ICMP communication between devices
sudo iptables -A OUTPUT -p icmp -j ACCEPT
sudo iptables -A INPUT -p icmp -j ACCEPT

# SSH - Allows SSH login to computer
sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

# Save iptables rules and make then persistent
sudo iptables-save