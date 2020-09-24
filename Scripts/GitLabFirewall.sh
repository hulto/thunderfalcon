#!/usr/bin/env bash
# Configure Firewall Rules for GitLab Server
# Created by Russell Harvey
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
#
# Included is HTTP, HTTPS, SSH, and Git.
# Allowing HTTP
iptables -A INPUT -p tcp --sport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
# Allowing HTTPS
iptables -A INPUT -p tcp --sport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
# Allowing SSH 
iptables -A INPUT -p tcp --sport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
# Allowing Git
iptables -A INPUT -p tcp --dport 9418 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 9418 -j ACCEPT
# Allow LDAP for AD Authentication
iptables -A OUTPUT -p tcp --dport 389 -j ACCEPT
iptables -A INPUT -p tcp --sport 389 -j ACCEPT
iptables -A OUTPUT -p udp --dport 389 -j ACCEPT
iptables -A INPUT -p udp --sport 389 -j ACCEPT

# Prevent Connections

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# List the new rules
iptables -L -v