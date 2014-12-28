#!/bin/sh
datetime=`date '+%y-%m-%d %H:%M'`
echo -e "Time,\t\t\ttotal,\tused,\tfree,\tcache" >>SWAP_$datetime.csv
while true; do
    TOP=`top -b -n 2|grep Swap |tail -2`
    echo -e  "`date '+%y-%m-%d %H:%M:%S'`,\t"\
	 "`echo $TOP| awk  '{print $11}'`,\t"\
    	 "`echo $TOP| awk  '{print $13}'`,\t"\
    	 "`echo $TOP| awk  '{print $15}'`,\t"\
    	 "`echo $TOP| awk  '{print $17}'`" >> SWAP_$datetime.csv
done

