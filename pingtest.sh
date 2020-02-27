#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin
hostname=<local_system_name_or_ip>
remotesystem=<remote_system_fqdn_or_ip>
emailaddress=<some_email_address_here>
packetloss=`ping -i .1 $remotesystem -c 200 | grep loss | awk {'print $6'} | cut -d '%' -f 1`

if [ ! -f "/var/run/pingtest.pid" ]; then
        if [ "$packetloss" -ge "3" ]; then
                cat /dev/null > /tmp/mtrreports_temp
                reporttime=`date +"%Y-%m-%d-%H-%M-%S"`
                cat $reporttime > /var/run/pingtest.pid
                filename="/root/mtrreports/$reporttime.txt"
                echo $filename
                echo "$packetloss% packet loss has been detected from $hostname to $remotesystem." >> $filename
                echo "Please review the following MTR results:" >> $filename
                echo "" >> $filename
                /usr/bin/script -c "/usr/bin/mtr --report -c 20 $remotesystem" /tmp/mtrreports_temp
                sleep 30s
                /bin/cat /tmp/mtrreports_temp >> $filename
                (echo To: $emailaddress ; echo From: root ; echo Subject: Packetloss detected between $hostname and $remotesystem ; echo "" ; /bin/cat $filename ) | /usr/sbin/sendmail -t
                rm -f /var/run/pingtest.pid
        fi
fi

exit 0
