#!/bin/sh

## This is for BigSur

# disable otherusers account
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow showotherusers_managed false

# disable externalaccounts account, maybe the same like showotherusers
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow EnableExternalAccounts -bool false

# disable timemachine pop-up message when an external drive is plugged in
/usr/bin/defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# disbale creating .DS_Store files
/usr/bin/defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
/usr/bin/defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# minimize windows into the application in dock
/usr/bin/defaults write com.apple.dock minimize-to-application -bool true

# enable automatically quit printer app once print jobs is finished
/usr/bin/defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

exit 0		## Success
exit 1		## Failure
