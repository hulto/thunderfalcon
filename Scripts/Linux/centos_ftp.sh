#!/bin/bash
# A script that sets up FTP and SSH for CentOS Firewalld
#
# 

# Permanent is used to make changes persist through reboot
# Zones may need to be changed, list zones with: firewall-cmd --get-active-zones

# Open public facing ftp ports
firewall-cmd --permanent --zone=public --add-service=ftp
# Open public facing ssh ports (Check Zones first)
firewall-cmd --permanent --zone=public --add-service=ssh

# Check all services/ports open
firewall-cmd --list-all
# Remove unwanted services with: firewall-cmd --permanent --zone=public --remove-service=<service>

