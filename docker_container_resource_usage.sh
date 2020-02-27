#!/bin/bash
#
# Author: Matt Marich
# Date: 5-20-15
#
# Since docker stats are unreliable this script checks docker uuids on system to see if those containers are running, if they are it exports the container name, cpu usage percentage and memory usage percentage
#

cat /dev/null > /tmp/dockerids
for i in `ls /var/lib/docker/containers/`; do hostname=`cat /var/lib/docker/containers/$i/hostname`;echo $i:$hostname>>/tmp/dockerids;done

for d in `cat /tmp/dockerids`; do

        count1=0
        count2=0
        dockerid=`echo $d | cut -d ':' -f 1`
        dockername=`echo $d | cut -d ':' -f 2`

        if test -f "/sys/fs/cgroup/cpu/docker/$dockerid/cgroup.procs"; then
                cat /sys/fs/cgroup/cpu/docker/$dockerid/cgroup.procs > /tmp/$dockerid.procs

                for i in `cat /tmp/$dockerid.procs`; do cpu_perc[$count1]=`ps aux | grep " $i " | grep -v grep | awk {'print $3'}`;count1=$(($count1 + 1));done
                cpu_sum=$( IFS="+"; bc <<< "${cpu_perc[*]}" )
#                cpu_sum=`echo "$cpu_sum * .01" | bc -l`

                for i in `cat /tmp/$dockerid.procs`; do mem_perc[$count2]=`ps aux | grep " $i " | grep -v grep | awk {'print $4'}`;count2=$(($count2 + 1));done
                mem_sum=$( IFS="+"; bc <<< "${mem_perc[*]}" )
#                mem_sum=`echo "$mem_sum * .01" | bc -l`

                echo -e "Container: "$dockername"\tCPU: "$cpu_sum"\tRAM: "$mem_sum
                unset cpu_perc mem_perc
        fi
done

exit 0
