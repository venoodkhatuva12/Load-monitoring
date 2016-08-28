########### START ###############


#!/bin/bash

CUR_TIME=`date +"%A %b %e %r"`
HOSTNAME=`hostname`


Load_AVG=`uptime | cut -d'l' -f2 | awk '{print $3}' | cut -d. -f1`
LOAD_CUR=`uptime | cut -d'l' -f2 | awk '{print $3 " " $4 " " $5}' | sed 's/,//'`


#Set the following value according to your requirement.
LIMIT=1

if [ $Load_AVG -gt $LIMIT ]

then

/bin/ps -auxf >> /root/process_out

echo "Current Time :: $CUR_TIME" >> /tmp/load.txt

echo "Current Load Average :: $LOAD_CUR" >> /tmp/load.txt
echo "The list of current running processes..." >> /tmp/load.txt

echo "Kindly login to your server and check"  >> /tmp/load.txt

/usr/bin/mutt -s "ALERT!!! High 1 minute load on '$HOSTNAME'" -a /root/process_out putyouremailaddresshere < /tmp/load.txt

fi

/bin/rm -f /tmp/load.txt
/bin/rm -f /root/process_out
