#!/bin/bash

echo -n | tee /tmp/du1 /tmp/du2 /tmp/du3 /tmp/du4 /tmp/du5 /tmp/du6 /tmp/du7

clear
echo "Generating Disk Usage Report"

/usr/bin/du --exclude=/proc -hs /* | grep 'G' | sort -hr | sed 's/\t/ /g' >> /tmp/du1

count=1

while [ $count -lt 6 ]
do

infile=`echo /tmp/du$count`
IFS=''
cat $infile |
while read line
do
	cat /dev/null > /tmp/scratch
	slashcount=`echo $line | grep -o '/' | wc -l`
	parent_dir=`echo $line | awk {'print $2'}`
	outputfile=`echo "/tmp/du$[$count+1]"`
	echo $line >> $outputfile
	if [ -d $parent_dir ] && [ $slashcount -eq $count ]
	then 
		dircount=`find $parent_dir -maxdepth 1 | wc -l`
                dircount=$[dircount-1]
                find $parent_dir -maxdepth 1 | tail -$dircount >> /tmp/scratch
		if [ $count -eq 1 ]
                then
                        cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/G$/' | awk {'print "  ",$1,$2'} >> $outputfile
                        cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/M$/' | awk {'print "  ",$1,$2'} >> $outputfile
		elif [ $count -eq 2 ]
		then
			cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/G$/' | awk {'print "    ",$1,$2'} >> $outputfile
                	cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/M$/' | awk {'print "    ",$1,$2'} >> $outputfile
		elif [ $count -eq 3 ]
		then
			cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/G$/' | awk {'print "      ",$1,$2'} >> $outputfile
                        cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/M$/' | awk {'print "      ",$1,$2'} >> $outputfile
                elif [ $count -eq 4 ]
                then
                        cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/G$/' | awk {'print "        ",$1,$2'} >> $outputfile
                        cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/M$/' | awk {'print "        ",$1,$2'} >> $outputfile
                elif [ $count -eq 5 ]
                then
                        cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/G$/' | awk {'print "          ",$1,$2'} >> $outputfile
                        cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/M$/' | awk {'print "          ",$1,$2'} >> $outputfile
		fi
	fi
done

count=$[$count+1]
done

infile=`echo /tmp/du$count`
IFS=''
cat $infile |
while read line
do
	cat /dev/null > /tmp/scratch
        slashcount=`echo $line | grep -o '/' | wc -l`
        parent_dir=`echo $line | awk {'print $2'}`
	outputfile=`echo "/tmp/du$[$count+1]"`
        if [ -d $parent_dir ] && [ $count -eq 1 ]
        then
                echo -e '\n\n\n' >> $outputfile
        fi
        echo $line >> $outputfile
        if [ -d $parent_dir ] && [ $slashcount -eq $count ]
        then
		dircount=`find $parent_dir -maxdepth 1 | wc -l`
                dircount=$[dircount-1]
                find $parent_dir -maxdepth 1 | tail -$dircount >> /tmp/scratch
		cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/G$/' | awk {'print "            ",$1,$2'} >> $outputfile
		cat /tmp/scratch | while read foldername; do du -hs $foldername; done | sort -hr | awk '$1~/M$/' | awk {'print "            ",$1,$2'} >> $outputfile
        fi
done

echo -e '\n\n\n' >> $outputfile
clear

cat $outputfile

exit 0
