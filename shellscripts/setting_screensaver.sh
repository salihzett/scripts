#!/bin/sh
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`
sudo su -l $loggedInUser -c "defaults -currentHost write com.apple.screensaver idleTime 300"
sudo su -l $loggedInUser -c "defaults -currentHost write com.apple.screensaver askForPassword -int 1"
sudo su -l $loggedInUser -c "defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName foo path /Library/Screen\ Savers/foo.saver"
sudo su -l $loggedInUser -c "defaults -currentHost write com.apple.screensaver showClock 1"
