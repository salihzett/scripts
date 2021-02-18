#!/bin/sh

/usr/sbin/softwareupdate -l
wait 300
/usr/sbin/softwareupdate -i -a 

exit 0		## Success
exit 1		## Failure
