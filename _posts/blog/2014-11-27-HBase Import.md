---
layout: post
title: Hbase 数据导入
description: 第一次接触大数据处理工具时，发现很多hadoop项目都是以"H"或"S"打头，点解？
category: blog
---



 
 
 	awk -F , '{gsub(" ","",$5);gsub("-","",$5);gsub(":","",$5);print $5$4}' test


	hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=, -Dimporttsv.bulk.output=csvfile/h_point10m -Dimporttsv.columns=HBASE_ROW_KEY,a:a,a:b,a:c,a:d,a:e,a:f,a:g,a:h,a:i,a:j,a:k,a:l,a:m,a:n,a:o,a:p,a:q,a:r,a:s,a:t,a:u,a:v,a:w,a:x,a:z,a:aa,a:ab,a:ac,a:ad,a:ae,a:af,a:ag,a:ah,a:ai,a:aj,a:ak,a:al,a:am,a:an,a:ao,a:ap,a:aq,a:ar,a:as,a:at,a:au,a:av,a:aw,a:ax,a:ay,a:az,a:ba,a:bb,a:bc,a:bd,a:be,a:bf,a:bg,a:bh,a:bi,a:bj,a:bk,a:bl,a:bm,a:bn,a:bo,a:bp,a:bq,a:br,a:bs,a:bt,a:bu,a:bv,a:bw,a:bx,a:by,a:bz,a:ca,a:cb,a:cc,a:cd,a:ce,a:cf im_test csvfile/point10m.csv 
	

	
	hadoop fs -chmod -R 777 csvfile/h_point10m
	hbase org.apache.hadoop.hbase.mapreduce.LoadIncrementalHFiles csvfile/h_point10m im_test


	hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=, -Dimporttsv.bulk.output=csvfile/h_point10m_unload -Dimporttsv.columns=HBASE_ROW_KEY,a:a,a:b,a:c,a:d,a:e,a:f,a:g,a:h,a:i,a:j,a:k,a:l,a:m,a:n,a:o,a:p,a:q,a:r,a:s,a:t,a:u,a:v,a:w,a:x,a:z,a:aa,a:ab,a:ac,a:ad,a:ae,a:af,a:ag,a:ah,a:ai,a:aj,a:ak,a:al,a:am,a:an,a:ao,a:ap,a:aq,a:ar,a:as,a:at,a:au,a:av,a:aw,a:ax,a:ay,a:az,a:ba,a:bb,a:bc,a:bd,a:be,a:bf,a:bg,a:bh,a:bi,a:bj,a:bk,a:bl,a:bm,a:bn,a:bo,a:bp,a:bq,a:br,a:bs,a:bt,a:bu,a:bv,a:bw,a:bx,a:by,a:bz,a:ca,a:cb,a:cc,a:cd,a:ce,a:cf im_test csvfile/point10m.csv 
	
	
	hadoop fs -chmod -R 777 csvfile/h_point10m
	hbase org.apache.hadoop.hbase.mapreduce.LoadIncrementalHFiles csvfile/h_point10m im_test

	
	hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=, -Dimporttsv.bulk.output=csvfile/h_testMSdata2 -Dimporttsv.columns=HBASE_ROW_KEY,a:a,a:b,a:c,a:d,a:e,a:f,a:g data_ocean_clytest csvfile/testMSdata2
	hadoop fs -chmod -R 777 csvfile/h_testMSdata2
	hbase org.apache.hadoop.hbase.mapreduce.LoadIncrementalHFiles csvfile/h_testMSdata2 data_ocean_clytest