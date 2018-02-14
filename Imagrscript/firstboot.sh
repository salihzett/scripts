#!/bin/sh

echo "***** Checking for Software *****"
echo ""

/usr/sbin/softwareupdate -l
/usr/local/munki/managedsoftwareupdate 
/usr/local/munki/managedsoftwareupdate --installonly

echo "***** Configuring System *****"
echo ""

# Configure ARD
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users admin -privs -all -clientopts -setmenuextra -menuextra no -setreqperm -reqperm yes -restart -agent 

# activate SSH
/usr/sbin/systemsetup -setremotelogin on

# disable Local timemachine , dont need by using high sierra
# /usr/bin/tmutil disablelocal

# disable timemachine pop-up message when an external drive is plugged in
/usr/bin/defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# disable apple autoupdate
/usr/bin/defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool true

# Set the Open and Save options in Office 2016 apps to default to "On My Mac" instead of "Online Locations". (for all users)
/usr/bin/defaults write /Library/Preferences/com.microsoft.office DefaultsToLocalOpenSave -bool true

# set timezone and timeserver
/usr/sbin/systemsetup -settimezone Europe/Berlin
/usr/sbin/systemsetup -setnetworktimeserver time.euro.apple.com
/usr/sbin/systemsetup -setusingnetworktime on

# set user directory für cadmin, because createuserpkg dont do it
cd /Users/
mkdir cadmin
chown cadmin:wheel cadmin/
chmod 700 cadmin/
cd cadmin/
mkdir .ssh
chown cadmin:staff .ssh/
chmod 755 .ssh/
cd .ssh/
chown cadmin:staff authorized_keys

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# join Wifi
/usr/sbin/networksetup -setairportnetwork en0 >SSID< "PASSWD"

echo "***** FINISHED *****"
echo "***** LAST CHECK THEN REBOOT *****"
sleep 5
