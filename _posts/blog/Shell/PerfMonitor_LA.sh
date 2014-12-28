#!/bin/sh
datetime=`date '+%y-%m-%d %H:%M'`
echo -e "Time,\t\t\t1min,\t5min,\t15min" >>LA_$datetime.csv
while true; do
   TOP=`top -b -n 2 | grep "top -"|tail -2`
   echo -e "`date '+%y-%m-%d %H:%M:%S'`,\t"\
	"`echo $TOP| awk  '{print $12}'`\t"\
	"`echo $TOP| awk  '{print $13}'`\t"\
	"`echo $TOP| awk  '{print $14}'`"\ >> LA_$datetime.csv
done

