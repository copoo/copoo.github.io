---
layout: post
title: 初见hadoop
description: 第一次接触大数据处理工具时，发现很多hadoop项目都是以"H"或"S"打头...
category: blog
---

#初见Hive#
##Hive中的数据导入##
有两种主要的方式：


###加载文件到表中###
 
Hive在加载数据到表中的时候并不作任何的转换。现在的加载操作只是纯的复制/移动操作，将数据文件移动到对应的hive表的位置。
 
    LOAD DATA [local] INPATH 'filepath' [OVERWRITE] INTO TABLE tablename [PARTITION (parcol1=val1, partcol2=val2 ...)];
 
现在的加载操作只是纯的复制/移动操作，将数据文件移动到对应的hive表的位置。

**注意点：**

1. filepath

	+ filepath可以使相对路径,比如：project/data1;
	+ 绝对路径， 比如：/user/hive/project/data1;
	+ 一个URI，比如：hdfs://namenode:9000/user/hive/project/data1;
	+ filepath可以使一个文件（将这个文件移动到表中）也可以是一个目录（将这个目录的所有的文件移动到表中）。两种情况都是文件集合的地址;
2. local：
 
	+ 如果指明了local,load命令将在本地文件系统中寻找filepath。如果一个相对路径指明-它将被解释成用户的当前目录。用户也可以指定一个ie文件的统一资源定位符，如file:///user/hive/project/data1;
	+ load命令将试filepath指明的地址下的所有的文件复制到目标文件系统。目标文件系统是通过查找表的位置属性来判断的。然后被复制的数据就被移动到表中了;
3. 此外： 
	+ 如果local没有被指定，但指明了filepath， hive将使用filepath的全URI。否则遵循下面的规则：
		+ schema或者authority没有指定，hive将使用hadoop设置的变量fs.default.name指定的名字节点URI。
		+ 路径不是绝对的-然后hive将解释它成/user/<username>,Hive将移动filepath指定的文件到表或者分区中。
	+ 如果overwrite指定，目标表的内容将被删除，被filepath下的文件内容代替。否则,新的文件内容将附加在表中。

PS:如果目标表或者分区已经有文件和filepath下的任何文件冲突-已经存在的文件将被新的文件代替。


###创建外部表###
####方式1####
    CREATE EXTERNAL TABLE table_ext
	(c1 INT,c2 DECIMAL(22,6))
	COMMENT 'table test'
	ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
	STORED AS TEXTFILE;

	LOAD DATA LOCAL INPATH '/tmp/testdata.csv' INTO TABLE table_ext;
 
用这种方式加载数据，文件会加载到hdfs文件系统中，访问

    http://localhost:50070/explorer.html#/user/hive/warehouse
或

    hadoop fs -ls /user/hive/warehouse
即可看到文件存放位置

###从查询中插入数据到表中###

 
**查询结果插入到表中**
 
	INSERT OVERWRITE TABLE tablename [PARTITION (par=val1, par2=val2 ...)] select_statement1 FROM from_statement;
 
Hive扩展：
 
	 FROM from_statement
	 INSERT OVERWRITE TABLE tablename1 [PARTITION (...)] select_statement1
	[INSERT OVERWRITE TABLE tablename2 [partition (...)] select_statement2]...

 


**查询结果写到文件**
 


	INSERT OVERWRITE [LOCAL] DIRECTORY directory1 SELECT ... FROM ...
 


Hive扩展：
 
	 FROM from_statement
	 INSERT OVERWRITE [LOCAL] DIRECTORY directory1 select_statement1
	[INSERT OVERWRITE [LOCAL] DIRECTORY directory2 select_statement2] ...




[Andy阿离]:    http://copoo.github.io  "Andy阿离"
