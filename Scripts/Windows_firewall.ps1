# CDT Competition 1 Firewall Rules for Windows Boxes


#Allowing ICMP
New-NetFirewallRule -DisplayName "Allow ICMPv4 Out - 8" -Direction Outbound -Protocol ICMPv4 -IcmpType 8 -Action Allow
New-NetFirewallRule -DisplayName "Allow ICMPv4 In - 0" -Direction Inbound -Protocol ICMPv4 -IcmpType 0 -Action Allow
New-NetFirewallRule -DisplayName "Allow ICMPv4 Out - 0" -Direction Outbound -Protocol ICMPv4 -IcmpType 0 -Action Allow
New-NetFirewallRule -DisplayName "Allow ICMPv4 In - 8" -Direction Inbound -Protocol ICMPv4 -IcmpType 8 -Action Allow

#SMBv1
New-NetFirewallRule -DisplayName "Allow SMBv1 Out" -Direction Outbound -LocalPort 445 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow SMBv1 In" -Direction Inbound -LocalPort 445 -Protocol TCP -Action Allow

#WinRM
New-NetFirewallRule -DisplayName "Allow WinRM Out" -Direction Outbound -LocalPort 5985,5986 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow WinRM In" -Direction Inbound -LocalPort 5985,5986 -Protocol TCP -Action Allow

#RDP
New-NetFirewallRule -DisplayName "Allow RDP Out" -Direction Outbound -LocalPort 3389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow RDP Out" -Direction Outbound -LocalPort 3389 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow RDP In" -Direction Inbound -LocalPort 3389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow RDP In" -Direction Inbound -LocalPort 3389 -Protocol UDP -Action Allow

#DHCP
New-NetFirewallRule -DisplayName "Allow DHCP Out" -Direction Outbound -LocalPort 67 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow DHCP In" -Direction Inbound -LocalPort 68 -Protocol UDP -Action Allow

#DNS
New-NetFirewallRule -DisplayName "Allow DNS Out" -Direction Outbound -LocalPort 53 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow DNS Out" -Direction Outbound -LocalPort 53 -Protocol TCP-Action Allow
New-NetFirewallRule -DisplayName "Allow DNS In" -Direction Inbound -LocalPort 53 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Allow DNS In" -Direction Inbound -LocalPort 53 -Protocol TCP -Action Allow

