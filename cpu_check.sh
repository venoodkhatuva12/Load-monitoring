#!/bin/bash
#Script made for CPU Check
#Author: Vinod.N K
#Distro : Linux -Centos, Rhel, and any fedora
#Check whether root user is running the script

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

SUBJECT="AIEP server load is High"
TO=user@domain.com
uptime > /tmp/load
if [ `uptime | awk '{ print$10 }' | cut -d. -f1` -gt 8 ];
then
echo "============================================" >> /tmp/load
`ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10 >> /tmp/load `
mail -s "$SUBJECT" $TO -c "moofwdhelp@gmail.com"< /tmp/load
exit
fi
