---
layout: post
title: HBase Data Store and Backup
description: 
category: blog
---


HBase 在磁盘中存储位置有2个：

+ write-ahead logs (WALs) ；
+ HFiles

前者：无格式，支持自动快速写入并定期更新到HBase
后者：