#!/bin/sh
echo "#####################################################"
sudo defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL "http://xxx/munki_repo"
sudo defaults write /Library/Preferences/ManagedInstalls ClientIdentifier "eleven_all"
sudo /bin/bash -c "$(curl -s http://elevencharacters.com/xxx/index.php?/install)"
sudo defaults write /Library/Preferences/MunkiReport Passphrase 'xxx-xxx-xxx-xxx-xxx'
sudo defaults write /Library/Preferences/ManagedInstalls.plist InstallAppleSoftwareUpdates -bool TRUE
sudo /usr/local/munki/managedsoftwareupdate
echo "#####################################################"
