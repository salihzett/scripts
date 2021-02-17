#!/bin/sh

CPR=$(sysctl -n machdep.cpu.brand_string)
PM1="Intel"
PITL="Apple"


if [[ "$CPR" == *"$PM1"* ]]; then
	  echo $CPR
  else
	  echo $CPR
	  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
fi

exit 0		## Success
exit 1		## Failure
