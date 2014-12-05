---
layout: post
title: Daily Note
description: 
category: blog
---

 #pointvalue file pre-handle

	cat  ../yhb/wtg10m2013.csv  |awk -F, '{$1="";$2="";$3="";OFS=",";gsub(" ","",$5);gsub("-","",$5);gsub(":","",$5);printf("%s",$5$4);for(i=4;i<84;i++){printf(",%s",$i)};printf("\n");}' >point10m.csv 