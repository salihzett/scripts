#!/bin/bash
user=$(id -F | awk '{print $1;}')
#user="Salih Zett"
model=$(system_profiler SPHardwareDataType | grep "Model Name" | awk '{print $4}')
domain="xxx"
echo "============="
echo "Your username is ${user}"
sudo scutil --set ComputerName ${user}s-${model}
sudo scutil --set LocalHostName ${user}s-${model}
sudo scutil --set HostName ${user}s-${model}.${domain}
sleep .5
echo "============="
echo "Computername:	  $(scutil --get ComputerName)"
echo "Local Hostname:	$(scutil --get LocalHostName)"
echo "Hostname:			  $(scutil --get HostName)"
echo "============="
