#!/bin/sh
datetime=`date '+%y-%m-%d %H:%M'`
echo -e "Time,\t\t\ttotal,\tused,\tbuffer" >>MEM_$datetime.csv
while true; do
    TOP=`top -b -n 2|grep Mem |tail -2`
    echo -e  "`date '+%y-%m-%d %H:%M:%S'`,\t"\
	 "`echo $TOP| awk  '{print $11}'`,\t"\
    	 "`echo $TOP| awk  '{print $13}'`,\t"\
    	 "`echo $TOP| awk  '{print $15}'`" >> MEM_$datetime.csv
done

