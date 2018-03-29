#!/bin/sh
echo "####### join elevenWifi #######"
/usr/sbin/networksetup networksetup -setairportnetwork en0 elevenWifi "passphrase"
echo "####### FINISHED #######"
