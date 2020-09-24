#!/bin/sh

# Author: Abdul Azeez Omar
# Name: StacyFirewallVerify.sh
# Purpose: This script verifies firewall rules created to whitelist specific in/out traffic with iptables.

# Container for rules to check
declare -A egressRules
declare -A ingressRules

egressRules["MySQL"]=0
egressRules+=(["DNSClient"]=0)
egressRules+=(["ICMP"]=0)

ingressRules["MySQL"]=0
ingressRules+=(["DNSClient"]=0)
ingressRules+=(["ICMP"]=0)

# Checks each line of iptables rules to match on required rules
direction=1
while read -r line
do
	# Check which queue currently parsing
	if [[ $line == *"INPUT"* ]] 
	then
		let "direction = 1"
	elif [[ $line == *"FORWARD"* ]]
	then
		let "direction = 0"
	elif [[ $line == *"OUTPUT"* ]]
	then
		let "direction = 2"
	else
		let "direction = $direction"
	fi

	# Parse through each rule to verify
	if [[ $line == *"ACCEPT"* ]] && [[ $line == *"tcp"* ]] && [[ $line == *"dpt:3306"* ]] && [[ $direction == 1 ]]
	then
		ingressRules["MySQL"]=1
	elif [[ $line == *"ACCEPT"* ]] && [[ $line == *"udp"* ]] && [[ $line == *"spt:53"* ]] && [[ $direction == 1 ]]
	then
		ingressRules["DNSClient"]=1
	elif [[ $line == *"ACCEPT"* ]] && [[ $line == *"icmp"* ]] && [[ $direction == 1 ]]
	then
		ingressRules["ICMP"]=1
	elif [[ $line == *"ACCEPT"* ]] && [[ $line == *"tcp"* ]] && [[ $line == *"spt:3306"* ]] && [[ $direction == 2 ]]
	then
		egressRules["MySQL"]=1
	elif [[ $line == *"ACCEPT"* ]] && [[ $line == *"udp"* ]] && [[ $line == *"dpt:53"* ]] && [[ $direction == 2 ]]
	then
		egressRules["DNSClient"]=1
	elif [[ $line == *"ACCEPT"* ]] && [[ $line == *"icmp"* ]] && [[ $direction == 2 ]]
	then
		egressRules["ICMP"]=1
	fi
	
done < <(sudo iptables -L -n)

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