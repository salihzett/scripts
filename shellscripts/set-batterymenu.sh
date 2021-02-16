#!/bin/sh

# set percentage for battery
/usr/bin/defaults write com.apple.menuextra.battery ShowPercent YES
/usr/bin/killall SystemUIServer

exit 0		## Success
exit 1		## Failure
