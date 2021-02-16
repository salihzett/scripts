#!/bin/sh
echo "####### join Wifi #######"
/usr/sbin/networksetup networksetup -setairportnetwork en0 Wifi "passphrase"
echo "####### FINISHED #######"

exit 0 ## Success
exit 1 ## Failure
