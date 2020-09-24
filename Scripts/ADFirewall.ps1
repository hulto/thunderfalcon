# Windows AD Firewall Rules
# Written by Russell Harvey
# Ports and protocols found here: 
# https://support.microsoft.com/en-us/help/179442/how-to-configure-a-firewall-for-domains-and-trusts


# Allow ports for services egressing via TCP
New-NetFirewallRule -DisplayName "Allow Essential AD Ports Out TCP" -Direction Inbound -LocalPort 1723, 135, 464, 636, 3268, 3269, 88, 445, 49152-65535 -Protocol TCP -Action Allow
# Allow ports for services ingressing via TCP
New-NetFirewallRule -DisplayName "Allow Essential AD Ports In TCP" -Direction Outbound -RemotePort 1024-65535 -Protocol TCP -Action Allow
# Allow ports for services egressing via UDP
New-NetFirewallRule -DisplayName "Allow Essential AD Ports Out UDP" -Direction Inbound -LocalPort 123, 464, 88 -Protocol UDP -Action Allow
# Allow ports for services ingressing via UDP
New-NetFirewallRule -DisplayName "Allow Essential AD Ports In UDP" -Direction Outbound -RemotePort 1024-65535 -Protocol UDP -Action Allow

# ICMP
New-NetFirewallRule -DisplayName "Allow ICMPv4 Out - 8" -Direction Outbound -Protocol ICMPv4 -IcmpType 8 -Action Allow
New-NetFirewallRule -DisplayName "Allow ICMPv4 In - 0" -Direction Inbound -Protocol ICMPv4 -IcmpType 0 -Action Allow
New-NetFirewallRule -DisplayName "Allow ICMPv4 Out - 0" -Direction Outbound -Protocol ICMPv4 -IcmpType 0 -Action Allow
New-NetFirewallRule -DisplayName "Allow ICMPv4 In - 8" -Direction Inbound -Protocol ICMPv4 -IcmpType 8 -Action Allow
# HTTP/HTTPS
New-NetFirewallRule -DisplayName "Allow WebTraffic In" -Direction Inbound -LocalPort 80, 443 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow WebTraffic Out" -Direction Outbound -RemotePort 80, 443 -Protocol TCP -Action Allow
# DNS Outbound/Inbound
New-NetFirewallRule -DisplayName "Allow DNS In TCP" -Direction Inbound -LocalPort 53 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow DNS In UDP" -Direction Inbound -LocalPort 53 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow DNS Out TCP" -Direction Outbound -RemotePort 53 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow DNS Out UDP" -Direction Outbound -RemotePort 53 -Protocol UDP -Action Allow
# LDAP Outbound/Inbound
New-NetFirewallRule -DisplayName "Allow LDAP In TCP" -Direction Inbound -LocalPort 389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow LDAP In UDP" -Direction Inbound -LocalPort 389 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow LDAP Out TCP" -Direction Outbound -RemotePort 389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow LDAP Out UDP" -Direction Outbound -RemotePort 389 -Protocol UDP -Action Allow