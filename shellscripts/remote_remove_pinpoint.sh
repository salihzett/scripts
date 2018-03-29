#!/bin/sh
echo "Which Host or IP?"
read varhostname
echo "It is $varhostname, lets go"
echo "############"
ssh $varhostname 'sudo rm -rf /Library/Application\ Support/pinpoint'
echo "############"
