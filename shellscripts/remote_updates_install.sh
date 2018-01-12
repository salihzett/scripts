#!/bin/sh
echo "Which Hostname needs the file?"
read varhostname
echo "It is $varhostname, lets go"

echo "############"

ssh $varhostname 'sudo /usr/local/munki/managedsoftwareupdate'
ssh $varhostname 'sudo /usr/local/munki/managedsoftwareupdate --installonly'
ssh $varhostname 'sudo /usr/sbin/softwareupdate -l'
ssh $varhostname 'sudo /usr/sbin/softwareupdate -i -a'

echo "############"
echo "DONE"
echo "############"
