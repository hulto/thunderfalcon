#!/bin/sh

# Author: Abdul Azeez Omar
# Name: BoydFirewallVerify.sh
# Purpose: This script verifies firewall rules created to whitelist specific in/out traffic with iptables.

# Container for rules to check
declare -A egressRules
declare -A ingressRules

egressRules["MySQL"]=0
egressRules+=(["HTTP"]=0)
egressRules+=(["HTTPS"]=0)
egressRules+=(["DNSClient"]=0)
egressRules+=(["ICMP"]=0)

ingressRules["MySQL"]=0
ingressRules+=(["HTTP"]=0)
ingressRules+=(["HTTPS"]=0)
ingressRules+=(["DNSClient"]=0)
ingressRules+=(["ICMP"]=0)

# Checks each line of iptables rules to match on required rules
while read -r line
do
	# Parse through each rule to verify
	if [[ $line == *"accept"* ]] && [[ $line == *"tcp"* ]] && [[ $line == *"to me 3306"* ]] && [[ $line == *"in"* ]]
	then
		ingressRules["MySQL"]=1
	elif [[ $line == *"accept"* ]] && [[ $line == *"tcp"* ]] && [[ $line == *"to me 80"* ]] && [[ $line == *"in"* ]]
	then
		ingressRules["HTTP"]=1
	elif [[ $line == *"accept"* ]] && [[ $line == *"tcp"* ]] && [[ $line == *"to me 443"* ]] && [[ $line == *"in"* ]]
	then
		ingressRules["HTTPS"]=1
	elif [[ $line == *"accept"* ]] && [[ $line == *"udp"* ]] && [[ $line == *"from any 53"* ]] && [[ $line == *"in"* ]]
	then
		ingressRules["DNSClient"]=1
	elif [[ $line == *"accept"* ]] && [[ $line == *"icmp"* ]] && [[ $line == *"in"* ]]
	then
		ingressRules["ICMP"]=1
	elif [[ $line == *"accept"* ]] && [[ $line == *"tcp"* ]] && [[ $line == *"from me 3306"* ]] && [[ $line == *"out"* ]]
	then
		egressRules["MySQL"]=1
	elif [[ $line == *"accept"* ]] && [[ $line == *"tcp"* ]] && [[ $line == *"from me 80"* ]] && [[ $line == *"out"* ]]
	then
		egressRules["HTTP"]=1
	elif [[ $line == *"accept"* ]] && [[ $line == *"tcp"* ]] && [[ $line == *"from me 443"* ]] && [[ $line == *"out"* ]]
	then
		egressRules["HTTPS"]=1
	elif [[ $line == *"accept"* ]] && [[ $line == *"udp"* ]] && [[ $line == *"to any 53"* ]] && [[ $line == *"out"* ]]
	then
		egressRules["DNSClient"]=1
	elif [[ $line == *"accept"* ]] && [[ $line == *"icmp"* ]] && [[ $line == *"out"* ]]
	then
		egressRules["ICMP"]=1
	fi
	
done < <(sudo ipfw list)

for key in ${!ingressRules[@]}
do
	if [[ ${ingressRules[${key}]} == 0 ]]
	then
		echo "Ingress firewall failed for " ${key}
	else
		echo "Ingress firewall working for " ${key}
	fi
done

for key in ${!egressRules[@]}
do
	if [[ ${egressRules[${key}]} == 0 ]]
	then
		echo "Egress firewall failed for " ${key}
	else
		echo "Egress firewall working for " ${key}
	fi
done