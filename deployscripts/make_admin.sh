#!/bin/sh
# Insert networkgroup staff to local group admin
dseditgroup -o edit -a "staff" -t group admin
