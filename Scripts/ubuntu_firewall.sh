#!/usr/bin/env bash
# Configure Firewall Rules for GitLab Server, mySQL, SSH, SMBv1
# Created by Russell Harvey, edited by Spencer Mycek
# Information sourced from:
# https://docs.github.com/en/enterprise/2.19/admin/configuration/network-ports

# Flush current iptable rules

iptables -F

# Set Defaults to ACCEPT initially

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Allow Established/Establishing Connections to be Maintained

iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow Localhost for Testing

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow ICMP

iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type 8 -j ACCEPT

# ------------------
# Client/Server Ports
# ------------------
# These are the required ports in order to run a generic Git server.
# Also ports for MySQL and SMBv1
#
# Included is HTTP, HTTPS, SSH, and Git.
# Allowing HTTP, Uneeded: Commented out
#iptables -A INPUT -p tcp --sport 80 -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
# Allowing HTTPS, Uneeded: Commented out
#iptables -A INPUT -p tcp --sport 443 -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
# Allowing SSH 
iptables -A INPUT -p tcp --sport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
# Allowing Git, Uneeded: Commented out
#iptables -A INPUT -p tcp --dport 9418 -j ACCEPT
#iptables -A OUTPUT -p tcp --sport 9418 -j ACCEPT
# Allow LDAP for AD Authentication
iptables -A OUTPUT -p tcp --dport 389 -j ACCEPT
iptables -A INPUT -p tcp --sport 389 -j ACCEPT
iptables -A OUTPUT -p udp --dport 389 -j ACCEPT
iptables -A INPUT -p udp --sport 389 -j ACCEPT
# Allowing MySQL
iptables -A INPUT -p tcp --sport 3306 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 3306 -j ACCEPT
# Allowing SMBv1, **Only NETBIOS so we only need UDP 137 & 138 and TCP 139
iptables -A INPUT -p tcp --sport 139 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 139 -j ACCEPT
iptables -A INPUT -p udp --sport 138 -j ACCEPT
iptables -A OUTPUT -p udp --dport 138 -j ACCEPT
iptables -A INPUT -p udp --sport 137 -j ACCEPT
iptables -A OUTPUT -p udp --dport 137 -j ACCEPT

# Prevent Connections

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# List the new rules
iptables -L -v
