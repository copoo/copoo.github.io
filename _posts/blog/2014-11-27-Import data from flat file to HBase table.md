---
layout: post
title: Import data from flat file to HBase table
description: 
category: blog
---



I recently worked a big data initiative using Apache Hadoop (CDH distribution).  One of the activities is to load NOAA Station data into Apache HBase. Here are the steps to load the data using Hadoop importtsv and bulk load tools.

1. Create an HBase table

	$ hbase shell
	hbase> create table 'noaastation', 'd'

This creates a table called “noaastation” with one column family “d”.


2. Create a temporary HDFS folder to hold the data for bulk load

	$ hdfs dfs –mkdir /user/john/hbase

3. Run importtsv to generate data in the temporary folder for bulk load

    $ hadoop jar /usr/lib/hbase/hbase.jar importtsv '-Dimporttsv.separator=|' -Dimporttsv.bulk.output=/user/john/hbase/tmp -Dimporttsv.columns=HBASE_ROW_KEY,d:c1,d:c2,d:c3,d:c4,d:c5,d:c6,d:c7,d:c8,d:c9,d:c10,d:c11,d:c12,d:c13,d:c14 noaastation /user/john/noaa/201212station.txt

NOAA station data in file 201212station.txt has 15 fields separated by “|”. The first field is station id, which will be the row key in HBase. The rest of fields will be added as HBase columns.

4. Change the temporary folder permission

	$ hdfs dfs -chmod -R +rwx /user/john/hbase

5. Run bulk load

	$ hadoop jar /usr/lib/hbase/hbase.jar completebulkload /user/john/hbase/tmp noaastation
Now that the data is loaded, run some HBase shell commands to query.

	hbase> scan ‘noaastation’
	hbase> get 'noaastation', '94994', {COLUMN => 'd:c7'}