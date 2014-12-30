---
layout: post
title: What is .hiverc file?
description: 存在感对于每个人的生活有多么的重要，可能平时并不是太关注，其实他就是生活的全部
category: blog
---

**What is .hiverc file?**
 
It is a file that is executed when you launch the hive shell - making it an ideal place for adding any hive configuration/customization you want set, on start of the hive shell. This could be:

- Setting column headers to be visible in query results
- Making the current database name part of the hive prompt
- Adding any jars or files
- Registering UDFs

**hiverc file location**

The file is loaded from the hive conf directory.
I have the CDH4.2 distribution and the location is: /etc/hive/conf.cloudera.hive1
If the file does not exist, you can create it.
It needs to be deployed to every node from where you might launch the Hive shell.
[Note: I had to create the file;  The distribution did not come with it.]

**Sample .hiverc**

add jar /home/airawat/hadoop-lib/hive-contrib-0.10.0-cdh4.2.0.jar;
set hive.exec.mode.local.auto=true;
set hive.cli.print.header=true;
set hive.cli.print.current.db=true;
set hive.auto.convert.join=true;
set hive.mapjoin.smalltable.filesize=30000000;


 