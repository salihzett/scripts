#!/bin/sh
echo "***** Checking for Software... and install them *****"
echo ""

/usr/sbin/softwareupdate -l
/usr/sbin/softwareupdate -i -a
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
/usr/bin/defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool false

# Set the save options in office 2016
/usr/bin/defaults write /Library/Preferences/com.microsoft.office DefaultsToLocalOpenSave -bool true

# set time config
/usr/sbin/systemsetup -settimezone Europe/Berlin
/usr/sbin/systemsetup -setnetworktimeserver time.euro.apple.com
/usr/sbin/systemsetup -setusingnetworktime on

echo "***** Configuring User Folder *****"
# set user directory für cadmin, because createuserpkg dont do it
cd /Users/
sudo mkdir cadmin
sudo chown cadmin:wheel cadmin/
sudo chmod 700 cadmin/
cd cadmin/
sudo mkdir .ssh
sudo chown cadmin:staff .ssh/
sudo chmod 755 .ssh/
cd .ssh/

echo "***** Install Brew *****"
# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "***** Configuring Wifi *****"
# join Wifi
/usr/sbin/networksetup -setairportnetwork en0 SSID "KEY"

echo "***** Configuring Loginwindow *****"
# Login Message
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "AAABBBCCC"

echo "***** Configuring id_rsa *****"
# add id_rsa.pub
echo "ssh-rsa..........." >> /Users/cadmin/.ssh/authorized_keys 

echo "***** Download XXXYYY Files to user Desktop *****"
localUsers=$( dscl . list /Users UniqueID | awk '$2 >= 501 {print $1}' | grep -v admin )
cd /tmp
curl -O http://192.168.1.49/stuff/XXX.pdf
curl -O http://192.168.1.49/stuff/YYY.pdf

for userName in "$localUsers"; do
    cp /tmp/XXX.pdf /Users/$userName/Desktop
    cp /tmp/YYY.pdf /Users/$userName/Desktop
done


echo "***** Rename Mac *****"
localUsers=$( dscl . list /Users UniqueID | awk '$2 >= 501 {print $1}' | grep -v admin )
model=$(system_profiler SPHardwareDataType | grep "Model Name" | awk '{print $4}')

for userName in "$localUsers"; do
   sudo /usr/sbin/scutil --set ComputerName ${userName}s-${model}
   sudo /usr/sbin/scutil --set HostName ${userName}s-${model}.hp
done

echo "***** FINISHED *****"
echo "***** LAST CHECK THEN REBOOT *****"
sleep 5
