#!/bin/sh
datetime=`date '+%y-%m-%d %H:%M'`
echo -e "Time,\t\t\tus,\tsy,\tni,\tid,\twa" >>CPU_$datetime.csv
while true; do
   TOP=`top -b -n 2 | grep Cpu |tail -2`
   echo -e "`date '+%y-%m-%d %H:%M:%S'`,\t"\
	"`echo $TOP| awk  '{print $11}'|sed s/us,//`,\t"\
	"`echo $TOP| awk  '{print $12}'|sed s/sy,//`,\t"\
	"`echo $TOP| awk  '{print $13}'|sed s/ni,//`,\t"\
	"`echo $TOP| awk  '{print $14}'|sed s/id,//`,\t"\
	"`echo $TOP| awk  '{print $15}'|sed s/wa,//`" >> CPU_$datetime.csv
     #sleep 1
done

