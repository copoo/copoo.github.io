---
layout: post
title: Hfile查看工具
description: 
category: blog
---


**查看HFile是HBase本身自带的一个很实用的工具 **

使用也很简单： 

$ ${HBASE_HOME}/bin/hbase org.apache.hadoop.hbase.io.hfile.HFile  

usage: HFile  [-a] [-b] [-e] [-f <arg>] [-k] [-m] [-p] [-r <arg>] [-v] 

 + -a,--checkfamily    Enable family check 
 +　-b,--printblocks    Print block index meta data 
 +　-e,--printkey       Print keys 
 +　-f,--file <arg>     File to scan. Pass full-path; e.g. 
                     hdfs://a:9000/hbase/.META./12/34 
 +　-k,--checkrow       Enable row order check; looks for out-of-order keys 
 +　-m,--printmeta      Print meta data of file 
 +　-p,--printkv        Print key/value pairs 
 +　-r,--region <arg>   Region to scan. Pass region name; e.g. '.META.,,1' 
 +　-v,--verbose        Verbose output; emits file and meta data delimiters 


工作中用到过该工具的几个场景： 

1. 测试或应用中，发现数据正确性有误，可以使用该工具，看看HFile中的真实数据 
2. 业务反映scan某表没反应，直到超时，服务端日志中无任何异常，后来直接分析HFile，发现用户设置了TTL，所有数据都已经过期了，所以scan变成了全表扫描了，orz。。。 