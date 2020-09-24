#!/bin/sh

# Author: Abdul Azeez Omar
# Name: BoydFirewall.sh
# Purpose: This script whitelists specific traffic for Boyd PC in/out traffic with IPFW.

# Flush out the rule set
sudo ipfw -q -f flush

# Set variable for rule add beginning
cmd="ipfw -q add"

# DNS Client - Allow connection to DNS servers
$cmd 00001 accept udp from any 53 to me in
$cmd 00002 accept udp from me to any 53 out

# ICMP - Allow ping between machines
$cmd 00003 accept icmp from any to me in
$cmd 00004 accept icmp from me to any out

# MySQL - Allow connections to local MySQL database
$cmd 00005 accept tcp from any to me 3306 in
$cmd 00006 accept tcp from me 3306 to any out

# Apache HTTP - Allow connections to local HTTP server
$cmd 00007 accept tcp from any to me 80 in
$cmd 00008 accept tcp from me 80 to any out

# Apache HTTPS - Allow connections to local HTTPS server
$cmd 00009 accept tcp from any to me 443 in
$cmd 00010 accept tcp from me 443 to any out

# Deny all other connections not allowed above
$cmd 65534 drop all from any to any
