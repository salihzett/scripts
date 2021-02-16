#!/bin/sh

echo "***** Removing Mackeeper... *****"

rm -rf /Applications/MacKeeper.app
rm -rf /Library/Preferences/.3FAD0F65-FC6E-4889-B975-B96CBF807B78
rm -rf /private/var/folders/mh/yprf0vxs3mx_n2lg3tjgqddm0000gn/T/MacKeeper*
rm -rf /private/tmp/MacKeeper*

~/Library/LaunchDaemons/com.mackeeper.MacKeeper.plugin.AntiTheft.daemon.plist

cuser=$( who | awk '/console/{ print $1 }' )
rm -rf /Users/$cuser/Library/Application\ Support/MacKeeper\ Helper
rm -rf /Users/$cuser/Library/Launch\ Agents/com.zeobit.MacKeeper.Helper.plist
rm -rf /Users/$cuser/Library/Logs/MacKeeper.log
rm -rf /Users/$cuser/Library/Logs/MacKeeper.log.signed
rm -rf /Users/$cuser/Library/Logs/SparkleUpdateLog.log
rm -rf /Users/$cuser/Library/Preferences/.3246584E-0CF8-4153-835D-C7D952862F9D
rm -rf /Users/$cuser/Library/Preferences/com.zeobit.MacKeeper.Helper.plist
rm -rf /Users/$cuser/Library/Preferences/com.zeobit.MacKeeper.plist
rm -rf /Users/$cuser/Library/Saved\ Application\ State/com.zeobit.MacKeeper.savedState
rm -rf /Users/$cuser/Library/Caches/com.mackeeper.MacKeeper
rm -rf /Users/$cuser/Library/Caches/com.mackeeper.MacKeeper.Helper
rm -rf /Users/$cuser/Library/LaunchAgents/com.mackeeper.MacKeeper.Helper.plist
rm -rf /Users/$cuser/Library/LaunchAgents/com.zeobit.MacKeeper.Helper.plist
rm -rf /Users/$cuser/Library/LaunchAgents/com.zeobit.MacKeeper.plugin.Backup.agentrm -rf /Users/$cuser/Library/LaunchAgents/com.zeobit.MacKeeper.plugin.Backup.agent
rm -rf /Users/$cuser/Library/LaunchDaemons/com.mackeeper.MacKeeper.plugin.AntiTheft.daemon.plist

launchctl unload /Users/$currUser/Library/LaunchAgents/com.mackeeper.MacKeeper.Helper.plist 
sleep 2
killall "MacKeeper Helper"
killall MKCleanService
killall MacKeeper

echo "***** CLEAN *****"

exit 0 ## Success
exit 1 ## Failure
