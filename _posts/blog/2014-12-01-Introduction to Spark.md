---
layout: post
title: Spark简介
description: 
category: blog
---



**简单总结一下Spark的特性：**

+ fast: Spark引入了一种叫做RDD的概念（下一篇详细介绍），官方宣称性能比MapReduce高100倍
+ fault-tolerant: Spark的RDD采用lineage（血统）来保存其生成轨迹，一旦节点挂掉，可重新生成来保证Job的自动容错
+ scalable: Spark跟MapReduce一样，采用Master-Worker架构，可通过增加Worker来自动扩容
+ compatible: Spark的存储接口兼容Hadoop，采用inputformat/outputformat来读取HDFS/HBase/Cassandra/S3 etc上的数据
+ conciseness: Spark采用Scala语言编写，充分利用了Scala语法的简洁性，以及functional编程的便利，整个Spark项目的代码才2W行。当然Spark不仅仅提供了Scala的API，还提供了Java和Python的API。

**Spark的定位（适合的场景）：**

MapReduce框架在分布式处理领域取得了巨大的成功，但是MapReduce的优势在于处理大规模无环数据流(acyclic data flows )，适合于批处理作业，但在以下两种场景下，MapReduce并不高效：

+ Iterative jobs（迭代计算型作业）: 许多机器学习算法（比如KMeans/Logistic Regression等）会针对同一数据集进行多轮迭代运算，每次迭代，仅仅是函数参数的变化，数据集的变化不大。用MapReduce实现这样的算法（比如mahout），每次迭代将是一个MapReduce Job，而每个MapReduce Job都会重新load数据，然后计算，最后持久化到HDFS，这无疑是巨大的IO开销，也是巨大的时间浪费。如果能够将这些需要多轮迭代的数据集Cache在内存中将会带来极大的性能提升，Spark采用RDD思想做到了这一点。
+ Interactive analytics（交互式查询分析）: 虽然在MapReduce框架之上提供了Hive/Pig这样的类SQL引擎来方便用户进行adhoc query，但是其查询效率仍然是巨大的诟病，通常一次查询需要分钟甚至小时级别，难以达到像数据库一样的交互式查询体验。这归结于MapReduce框架设计的初衷并不是提供交互式处理，而是批处理类型的处理任务，例如MapReduce的Map处理要将中间结果持久化到本地磁盘需要Disk IO开销，shuffle阶段需要将Map中间结果HTTP fetch到Reduce端需要网络IO开销，每个Job的Reduce需要将结果持久化到HDFS才能进行下一次Job，下一次Job又需要重新从HDFS load上一次Job的结果。这种计算模型进行一些大规模数据集的批处理作业是OK的，但是不能够提供快速的交互式adhoc查询（秒级别）。Spark放弃了Map-Shuffle-Reduce这样简单粗暴的编程模型而采用Transformation/Action模型，利用RDD思想能够将中间结果缓存起来而不是持久化，同时提供了一个与Hive一致的SQL接口（Shark）达到了MPP分布式数据库交互式查询的效率（39GB数据/次秒级响应时间）。