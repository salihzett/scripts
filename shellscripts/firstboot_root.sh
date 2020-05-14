#!/bin/sh

# wait for 60 seconds because of maybe system configuration is not full done after DEP process, IDK just to be sure:)
sleep 60

#echo "***** Configuring System *****"
# join wifi for the office (Its managed with *.mobileconfig)
#/usr/sbin/networksetup -setairportnetwork en0 SSID PASSWORD

# disable SSH
/usr/sbin/systemsetup -setremotelogin off

# login message (Its managed with *.mobileconfig)
#/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Company | Street | Melbourne, VIC"

# disable otherusers account
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow showotherusers_managed false

# disable externalaccounts account, maybe the same like showotherusers
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow EnableExternalAccounts -bool false

# disable timemachine pop-up message when an external drive is plugged in
/usr/bin/defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# enable apple autoupdate
/usr/bin/defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool true

# download and install available apple updates
/usr/bin/defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# disbale creating .DS_Store files
/usr/bin/defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
/usr/bin/defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# minimize windows into the application in dock
/usr/bin/defaults write com.apple.dock minimize-to-application -bool true

# disable the warning when changing a file extension
/usr/bin/defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# set time config (-listtimezones for setting timezone)
/usr/sbin/systemsetup -settimezone Australia/Melbourne
/usr/sbin/systemsetup -setnetworktimeserver time.apple.com
/usr/sbin/systemsetup -setusingnetworktime on

# automatically open finder windows when a new volume is mounted
/usr/bin/defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
/usr/bin/defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
/usr/bin/defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# enable automatically quit printer app once print jobs is finished
/usr/bin/defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# disable “are you sure you want to open this application?” dialog
/usr/bin/defaults write com.apple.LaunchServices LSQuarantine -bool false

# disable by default to save to iCloud, so not save in iCloud
/usr/bin/defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# enable open and save options in office apps to local instead of OneDrive.
#/usr/bin/defaults write /Library/Preferences/com.microsoft.office DefaultsToLocalOpenSave -bool true

# remove duplicates in “open with” menu (freeze the OS for around 20 seconds)
#/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# save screenshots in PNG format (others: BMP, GIF, JPG, PDF, TIFF)
#/usr/bin/defaults write com.apple.screencapture type -string "png"

# disable shadow in screenshots
#/usr/bin/defaults write com.apple.screencapture disable-shadow -bool true

#Remove Icons For Hard Drives, Servers, And Removable Media On The Desktop.
#/usr/bin/defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
#/usr/bin/defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
#/usr/bin/defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
#/usr/bin/defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false



# Following from https://github.com/rtrouton/rtrouton_scripts

# Set whether you want to send diagnostic info back to
# Apple and/or third party app developers. If you want
# to send diagonostic data to Apple, set the following 
# value for the SUBMIT_DIAGNOSTIC_DATA_TO_APPLE value:
#
# SUBMIT_DIAGNOSTIC_DATA_TO_APPLE=TRUE
# 
# If you want to send data to third party app developers,
# set the following value for the
# SUBMIT_DIAGNOSTIC_DATA_TO_APP_DEVELOPERS value:
#
# SUBMIT_DIAGNOSTIC_DATA_TO_APP_DEVELOPERS=TRUE
# 
# By default, the values in this script are set to 
# send no diagnostic data: 

SUBMIT_DIAGNOSTIC_DATA_TO_APPLE=FALSE
SUBMIT_DIAGNOSTIC_DATA_TO_APP_DEVELOPERS=FALSE

# Checks first to see if the Mac is running 10.10.0 or higher. 
# If so, the desired diagnostic submission settings are applied.

if [[ ${osvers} -ge 10 ]]; then

  CRASHREPORTER_SUPPORT="/Library/Application Support/CrashReporter"
 
  if [ ! -d "${CRASHREPORTER_SUPPORT}" ]; then
    /bin/mkdir "${CRASHREPORTER_SUPPORT}"
    /bin/chmod 775 "${CRASHREPORTER_SUPPORT}"
    /usr/sbin/chown root:admin "${CRASHREPORTER_SUPPORT}"
  fi

 /usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory AutoSubmit -boolean ${SUBMIT_DIAGNOSTIC_DATA_TO_APPLE}
 /usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory AutoSubmitVersion -int ${VERSIONNUMBER}
 /usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory ThirdPartyDataSubmit -boolean ${SUBMIT_DIAGNOSTIC_DATA_TO_APP_DEVELOPERS}
 /usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory ThirdPartyDataSubmitVersion -int ${VERSIONNUMBER}
 /bin/chmod a+r "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory.plist
 /usr/sbin/chown root:admin "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory.plist

fi
