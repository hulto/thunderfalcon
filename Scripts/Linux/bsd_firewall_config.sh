#!/bin/sh
# A script for setting up BAMP firewall rules with PF in FreeBSD
# Author: Spencer Mycek
#

# Enable PF
sysrc pf_enable=yes
# Enable PF logging
sysrc pflog_enable=yes
# Configure log location
echo pflog_logfile=\"/var/log/pflog\" >> /etc/rc.conf

# Rules for PF
## Service macros
echo tcp_services = \"{ ssh, domain, mysql }\" > /etc/pf.conf
echo web_ports = \"{ http, https }\" >> /etc/pf.conf
echo udp_services = \"{ domain }\" >> /etc/pf.conf

## Set Public Interface #### Must Change! ## ifconfig -a I think
echo ext_if=\"interface\" >> /etc/pf.conf

## Skip PF processing on Loopback
echo set skip on lo >> /etc/pf.conf

## Sets Default policy
echo block return in log all >> /etc/pf.conf
echo block out all >> /etc/pf.conf

## Deal with attacks based on incorrect handling of packet fragments
echo scrub in all >> /etc/pf.conf

## Blocking spoofed packets
echo antispoof quick for \$ext_if >> /etc/pf.conf

## SSH
echo pass in inet proto tcp to \$ext_if port ssh >> /etc/pf.conf

## ICMP
echo pass inet proto icmp icmp-type echoreq >> /etc/pf.conf

## Apache Webports
echo pass proto tcp from any to \$ext_if port \$web_ports >> /etc/pf.conf
## MySQL
echo pass proto tcp from any to \$ext_if port mysql >> /etc/pf.conf

## Allow needed outgoing traffic
echo pass out quick on \$ext_if proto tcp to any port \$tcp_services >> /etc/pf.conf
echo pass out quick on \$ext_if proto udp to any port \$udp_services >> /etc/pf.conf

# Start logging and PF
service pf start
service pflog start
## To see pflogs: tcpdump -n -e -ttt -i pflog0

