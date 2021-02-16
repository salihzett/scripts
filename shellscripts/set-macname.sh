#!/bin/sh
localUsers=$( dscl . list /Users UniqueID | awk '$2 >= 501 {print $1}' | grep -v admin )
for userName in "$localUsers"; do
	userName2=${userName//./}
	model=$(system_profiler SPHardwareDataType | awk '/Identifier/ {print $3}')
	model2=${model//,/}
	/usr/sbin/scutil --set ComputerName ${model}_${userName}
	/usr/sbin/scutil --set HostName ${model2}-${userName2}
	/usr/sbin/scutil --set LocalHostName ${model2}-${userName2}
done
