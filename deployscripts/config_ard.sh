#!/bin/sh
#access for admin and set request
echo "Config ARD"
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users admin -privs -all -clientopts -setmenuextra -menuextra no -setreqperm -reqperm yes -restart -agent 
