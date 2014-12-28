---
layout: post
title: Daily Note
description: 
category: blog
---

 #pointvalue file pre-handle

	cat  ../yhb/wtg10m2013.csv  |awk -F, '{$1="";$2="";$3="";OFS=",";gsub(" ","",$5);gsub("-","",$5);gsub(":","",$5);printf("%s",$5$4);for(i=4;i<84;i++){printf(",%s",$i)};printf("\n");}' >point10m.csv 


amazon S3

**以Bucket形式存入数据**

其中这个Buckets名字是全局唯一的，所有使用s3服务的人都桶名都不能有重名，而且命名根据url命名，因为毕竟这桶名会是url的一部分，一个用户顶多能创建100个桶。

+ 支持web上传文件/目录
+ 设置文件的属性

	+ Link:这个就是文件的url了，可以通过地址反问，前提就是你设置了浏览权限。

	+ Storage:这个是要怎么存储数据，例如Standard会把你的数据放在很多个地方备份，而Reduced Redundancy（少冗余） 则不会放在很多地方。地方放越多越可靠，价格嘛，前者贵点。

	+ Server Side Encryption: 这个应该是加密选项，在网络传输时要不要对数据加密，从他link的连接可以看到，是支持加密传输的。

	+ 后面还有Permissions选项卡，设置权限的，什么人可以看，什么人可以改都在那里设置。

+ 支持api 上传下载文件（
Login to Amazon account and click here to get Access Credentials.）

**Hbase Rowkey设计**

   因为一直在做hbase的应用层面的开发，所以体会的比较深的一点是hbase的表结构设计会对系统的性能以及开销上造成很大的区别，本篇文章先按照hbase表中的rowkey、columnfamily、column、timestamp几个方面进行一些分析。最后结合分析如何设计一种适合应用的高效表结构。

      1、表的属性

      (1)最大版本数：通常是3，如果对于更新比较频繁的应用完全可以设置为1，能够快速的淘汰无用数据，对于节省存储空间和提高查询速度有效果。不过这类需求在海量数据领域比较小众。

      (2)压缩算法：可以尝试一下最新出炉的snappy算法，相对lzo来说，压缩率接近，压缩效率稍高，解压效率高很多。

      (3)inmemory：表在内存中存放，一直会被忽略的属性。如果完全将数据存放在内存中，那么hbase和现在流行的内存数据库memorycached和redis性能差距有多少，尚待实测。

      (4)bloomfilter：根据应用来定，看需要精确到rowkey还是column。不过这里需要理解一下原理，bloomfilter的作用是对一个region下查找记录所在的hfile有用。即如果一个region下的hfile数量很多，bloomfilter的作用越明显。`适合那种compaction赶不上flush速度的应用`。

      2、rowkey

       rowkey是hbase的key-value存储中的key，通常使用用户要查询的字段作为rowkey，查询结果作为value。可以通过设计满足几种不同的查询需求。

      (1)数字rowkey的从大到小排序：原生hbase只支持从小到大的排序，这样就对于排行榜一类的查询需求很尴尬。那么采用rowkey = Integer.MAX_VALUE-rowkey的方式将rowkey进行转换，最大的变最小，最小的变最大。在应用层再转回来即可完成排序需求。

      (2)rowkey的散列原则：如果rowkey是类似时间戳的方式递增的生成，建议不要使用正序直接写入rowkey，而是采用reverse的方式反转rowkey，使得rowkey大致均衡分布，这样设计有个好处是能将regionserver的负载均衡，否则容易产生所有新数据都在一个regionserver上堆积的现象，这一点还可以结合table的预切分一起设计。

      3、columnfamily

      columnfamily尽量少，原因是过多的columnfamily之间会互相影响。

      4、column

      对于column需要扩展的应用，column可以按普通的方式设计，但是对于列相对固定的应用，最好采用将一行记录封装到一个column中的方式，这样能够节省存储空间。封装的方式推荐protocolbuffer。

     

     以下会分场景介绍一些特殊的表结构设计方法，只是一些摸索，欢迎讨论：

      value数目过多场景下的表结构设计：

       目前我碰到了一种key-value的数据结构，某一个key下面包含的column很多，以致于客户端查询的时候oom，bulkload写入的时候oom，regionsplit的时候失败这三种后果。通常来讲，hbase的column数目不要超过百万这个数量级。在官方的说明和我实际的测试中都验证了这一点。

       有两种思路可以参考，第一种是单独处理这些特殊的rowkey，第二种如下：

      可以考虑将column设计到rowkey的方法解决。例如原来的rowkey是uid1,，column是uid2，uid3...。重新设计之后rowkey为<uid1>~<uid2>，<uid1>~<uid3>...当然大家会有疑问，这种方式如何查询，如果要查询uid1下面的所有uid怎么办。这里说明一下hbase并不是只有get一种随机读取的方法。而是含有scan(startkey,endkey)的扫描方法，而这种方法和get的效率相当。需要取得uid1下的记录只需要new Scan("uid1~","uid1~~")即可。

       这里的设计灵感来自于hadoop world大会上的一篇文章，这篇文章本身也很棒，推荐大家看一下http://www.cloudera.com/resource/hadoop-world-2011-presentation-slides-advanced-hbase-schema-design/


1年1000台风机数据->1年10000台风机,数据量28G，4000w数据 

	cat point10m.csv |awk -F, '{printf("%s,%s,%s,%s,",$1,$2,$3,$4+10000);for(i=5;i<NF+1;i++)printf(",%s",$i);printf("\n")}'  >wtg10m2013_10000.csv
	

	cat dt.csv |awk -F, '{printf("%s",$1+10000);for(i=2;i<NF+1;i++)printf(",%s",$i);printf("\n")}'  >dt_10000.csv


	cat pc.csv |awk -F, '{printf("%s",$1+10000);for(i=2;i<NF+1;i++)printf(",%s",$i);printf("\n")}' > pc_10000.csv


	cat wtg.csv |awk -F, '{printf("%s,%s,%s,%s\n",$1+10000,$2,$3+10000,$4+10000)}' > wtg_10000.csv



删除某区间范围的数据：
	使用利勇的程序7




数据转换	
-

	2009/11/25 14:00:00,.3,0,.3,.3,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4,0,0,0,0,0,0,0,0,-86.4,0,-86.4,-86.4,73,11.4,88.1,64.8,,,,,13.3,0,13.4,13.2,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4
**head -1 rawdata.txt | awk -v a='' -F, '{OFS=",";a=$1;gsub(":","",$1);gsub("/","",$1);gsub(" ","",$1);$1="qkptesta"$1;$2=a;print $0}'**

转化为:POINT+YYYYMMDDHH24MISS

	qkptesta20091125140000,2009/11/25 14:00:00,0,.3,.3,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4,0,0,0,0,0,0,0,0,-86.4,0,-86.4,-86.4,73,11.4,88.1,64.8,,,,,13.3,0,13.4,13.2,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4


** head -1 rawdata.txt | awk -v a='' -F, '{OFS=",";a=$1;gsub(":","",$1);gsub("/","",$1);gsub(" ","",$1);$1=substr($1,1,6)substr($1,8,1)"qkptestb"substr($1,7,6);$2=a;print $0}'**

转化为:YYYYMMD+POINT+DDHH24MI
	
	2009115qkptestb251400,2009/11/25 14:00:00,0,.3,.3,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4,0,0,0,0,0,0,0,0,-86.4,0,-86.4,-86.4,73,11.4,88.1,64.8,,,,,13.3,0,13.4,13.2,.4,0,.4,.4,.4,0,.4,.4,.4,0,.4,.4


HBase数据Rowkey范围
-
**2年1个测风塔数据，连续分布：**

STARTROW => 'qkptesta20091125000000'
STOPROW=>'qkptesta20111031235959'


		·
扫描区间范围

	
	scan 'data_ocean_clytest',{LIMIT =>2000, STARTROW => 'qkptesta20091125000000', STOPROW=>'qkptesta20111031235959'}
 

 

**2年1个测风塔数据，120片分布：**

STARTROW => '2009115qkptestb250000'
STOPROW=>'2011101qkptestb312359'

扫描区间范围

	scan 'data_ocean_clytest',{LIMIT =>2000, STARTROW => '2009115qkptestb250000', STOPROW=>'2011101qkptestb312359'}


**1年33个测风塔数据，120片分布：**

STARTROW => '2009115qkptesta250000'
STOPROW=>'2011101qkptestzj312359'

扫描区间范围

	scan 'data_ocean_clytest',{LIMIT =>2000, STARTROW => '2009115qkptesta250000', STOPROW=>'2011101qkptestzj312359'}

1年33 测风塔的数据 

	 cat b |awk -F, '{OFS=",";gsub("testb","testa",$1);print $0}' > pa
	 cat b |awk -F, '{OFS=",";gsub("testb","testb",$1);print $0}' > pb
	 cat b |awk -F, '{OFS=",";gsub("testb","testc",$1);print $0}' > pc
	 cat b |awk -F, '{OFS=",";gsub("testb","testd",$1);print $0}' > pd
	 cat b |awk -F, '{OFS=",";gsub("testb","teste",$1);print $0}' > pe
	 cat b |awk -F, '{OFS=",";gsub("testb","testf",$1);print $0}' > pf
	 cat b |awk -F, '{OFS=",";gsub("testb","testg",$1);print $0}' > pg
	 cat b |awk -F, '{OFS=",";gsub("testb","testh",$1);print $0}' > ph
	 cat b |awk -F, '{OFS=",";gsub("testb","testi",$1);print $0}' > pi
	 cat b |awk -F, '{OFS=",";gsub("testb","testj",$1);print $0}' > pj
	 cat b |awk -F, '{OFS=",";gsub("testb","testk",$1);print $0}' > pk
	 cat b |awk -F, '{OFS=",";gsub("testb","testl",$1);print $0}' > pl
	 cat b |awk -F, '{OFS=",";gsub("testb","testm",$1);print $0}' > pm
	 cat b |awk -F, '{OFS=",";gsub("testb","testn",$1);print $0}' > pn
	 cat b |awk -F, '{OFS=",";gsub("testb","testo",$1);print $0}' > po
	 cat b |awk -F, '{OFS=",";gsub("testb","testp",$1);print $0}' > pp
	 cat b |awk -F, '{OFS=",";gsub("testb","testq",$1);print $0}' > pq
	 cat b |awk -F, '{OFS=",";gsub("testb","testr",$1);print $0}' > pr
	 cat b |awk -F, '{OFS=",";gsub("testb","tests",$1);print $0}' > ps
	 cat b |awk -F, '{OFS=",";gsub("testb","testt",$1);print $0}' > pt
	 cat b |awk -F, '{OFS=",";gsub("testb","testu",$1);print $0}' > pu
	 cat b |awk -F, '{OFS=",";gsub("testb","testv",$1);print $0}' > pv
	 cat b |awk -F, '{OFS=",";gsub("testb","testw",$1);print $0}' > pw
	 cat b |awk -F, '{OFS=",";gsub("testb","testx",$1);print $0}' > px
	 cat b |awk -F, '{OFS=",";gsub("testb","testy",$1);print $0}' > py
	 cat b |awk -F, '{OFS=",";gsub("testb","testz",$1);print $0}' > pz
	 cat b |awk -F, '{OFS=",";gsub("testb","testza",$1);print $0}' > pza
	 cat b |awk -F, '{OFS=",";gsub("testb","testzb",$1);print $0}' > pzb
	 cat b |awk -F, '{OFS=",";gsub("testb","testzc",$1);print $0}' > pzc
	 cat b |awk -F, '{OFS=",";gsub("testb","testzd",$1);print $0}' > pzd
	 cat b |awk -F, '{OFS=",";gsub("testb","testze",$1);print $0}' > pze
	 cat b |awk -F, '{OFS=",";gsub("testb","testzf",$1);print $0}' > pzf
	 cat b |awk -F, '{OFS=",";gsub("testb","testzg",$1);print $0}' > pzg
	 cat b |awk -F, '{OFS=",";gsub("testb","testzh",$1);print $0}' > pzh
	 cat b |awk -F, '{OFS=",";gsub("testb","testzi",$1);print $0}' > pzi
	 cat b |awk -F, '{OFS=",";gsub("testb","testzj",$1);print $0}' > pzj
 

Monitor HBase with Ganglia
-

+ open source 
+ distributed system designed to monitor clusters


