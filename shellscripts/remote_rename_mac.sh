#!/bin/sh
echo "Which IP needs a new name?"
read varip
echo "Give me the new name for the new mac, only firstname: (schema: Salihs-Pro)"
read varmac
echo "olala $varmac, lets go"

ssh $varip "sudo /usr/sbin/scutil --set ComputerName ${varmac}"
ssh $varip "sudo /usr/sbin/scutil --set LocalHostName ${varmac}"
ssh $varip "sudo /usr/sbin/scutil --set HostName ${varmac}.domain"


echo "=== new name ==="

ssh $varip "sudo /usr/sbin/scutil --get ComputerName"
ssh $varip "sudo /usr/sbin/scutil --get LocalHostName"
ssh $varip "sudo /usr/sbin/scutil --get HostName"

echo "============="
