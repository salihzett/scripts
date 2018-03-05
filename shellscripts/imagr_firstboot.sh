#!/bin/sh
echo "***** Checking and Install for Software *****"

/usr/sbin/softwareupdate -l
/usr/sbin/softwareupdate -i -a
/usr/local/munki/managedsoftwareupdate 
/usr/local/munki/managedsoftwareupdate --installonly

echo "***** Configuring System *****"

# Configure ARD
#/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users cadmin -privs -all -clientopts -setmenuextra -menuextra no -setreqperm -reqperm yes -restart -agent 
# disable because there are in the bonjour list, need a way to make them invisible

# activate SSH
/usr/sbin/systemsetup -setremotelogin on

# disable Local timemachine , dont need by using high sierra
# /usr/bin/tmutil disablelocal

# disable timemachine pop-up message when an external drive is plugged in
/usr/bin/defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# disable apple autoupdate
/usr/bin/defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool false

# Set the Open and Save options in Office 2016 apps to default to "On My Mac" instead of "Online Locations".
# This setting will apply to all users on this Mac.
/usr/bin/defaults write /Library/Preferences/com.microsoft.office DefaultsToLocalOpenSave -bool true

# Login Message
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "text"

# set time config
/usr/sbin/systemsetup -settimezone Europe/Berlin
/usr/sbin/systemsetup -setnetworktimeserver time.euro.apple.com
/usr/sbin/systemsetup -setusingnetworktime on

# join Wifi
/usr/sbin/networksetup -setairportnetwork en0 SSID "KEY"


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

echo "ssh-rsa x == x@elevencharacters.com" >> /Users/cadmin/.ssh/authorized_keys

sleep 15

echo "***** Download Files to user Desktop *****"
localUsers=$( dscl . list /Users UniqueID | awk '$2 >= 501 {print $1}' | grep -v admin )
model=$(system_profiler SPHardwareDataType | awk '/Identifier/ {print $3}')
model2=${model//,/}
cd /tmp
curl -O http://192.168.1.X/stuff/AAA.pdf
curl -O http://192.168.1.X/stuff/BBB.pdf
curl -O http://192.168.1.X/stuff/CCC.pdf
curl -O http://192.168.1.X/stuff/dockutil
chmod 777 dockutil

for userName in "$localUsers"; do
    cp /tmp/AAA.pdf /Users/$userName/Desktop
    cp /tmp/BBB.pdf /Users/$userName/Desktop
    cp /tmp/CCC.pdf /Users/$userName/Desktop
    sleep 15

    #echo "***** Install Brew *****"
    # install brew
	# sudo -u $userName /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	# disable because RETURN is not possible to simulate, actually

    echo "***** Rename Mac *****"
    userName2=${userName//./}
	/usr/sbin/scutil --set ComputerName ${model}_${userName}
	/usr/sbin/scutil --set HostName ${model2}-${userName2}.local
	/usr/sbin/scutil --set LocalHostName ${model2}-${userName2}

	echo "=== new name ==="
	/usr/sbin/scutil --get ComputerName
	/usr/sbin/scutil --get HostName
	/usr/sbin/scutil --get LocalHostName
	echo "============="

	echo "***** set Dock *****"
	sudo -u $userName /tmp/dockutil --remove 'Siri' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'Launchpad' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'Reminders' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'Maps' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'Photos' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'Messages' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'FaceTime' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'iTunes' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'iBooks' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'App Store' --no-restart
	sudo -u $userName /tmp/dockutil --remove 'System Preferences' --no-restart
	sudo -u $userName /tmp/dockutil --add /Applications/Google\ Chrome.app --position 1 --no-restart
	sudo -u $userName /tmp/dockutil --add /Applications/Managed\ Software\ Center.app --no-restart
	sudo -u $userName /tmp/dockutil --add afp://192.168.1.X --label 'XXX XXX' --after Downloads
	killall Dock

	echo "***** new Password Required for current user *****"
	pwpolicy -u $userName -setpolicy "newPasswordRequired=1"
	/usr/local/munki/managedsoftwareupdate 
done

echo "***** set Background *****"
cd /Users/Shared
curl -O http://192.168.1.49/stuff/xxx.jpg
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/Shared/xxx.jpg"'

echo "***** FINISHED *****"
echo "***** LAST CHECK THEN REBOOT *****"
sleep 5
