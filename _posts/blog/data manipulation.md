No.|hbase_column_name| database_column_name
--|--|--
1 | 10 | WTG_ID
2 | 11 | WTG_CODE
3 | 12 | APPRODUCTION
4 | 13 | RPPRODUCTION
5 | 14 | APCONSUMED
6 | 15 | RPCONSUMED
7 | 16 | PCURVESTSAVE
8 | 17 | PCURVESTSMAX
9 | 18 | PCURVESTSMIN
10 | 19 | PCURVESTSSTD
11 | 20 | WINDSPEEDAVE
12 | 21 | WINDSPEEDMAX
13 | 22 | WINDSPEEDMIN
14 | 23 | WINDSPEEDSTD
15 | 24 | ACTIVEPWAVE
16 | 25 | ACTIVEPWMAX
17 | 26 | ACTIVEPWMIN
18 | 27 | ACTIVEPWSTD
19 | 28 | ACTIVEPWCALAVE
20 | 29 | ACTIVEPWCALMAX
21 | 30 | ACTIVEPWCALMIN
22 | 31 | ACTIVEPWCALSTD
23 | 32 | WINDDIRECTIONAVE
24 | 33 | WINDDIRECTIONMAX
25 | 34 | WINDDIRECTIONMIN
26 | 35 | WINDDIRECTIONSTD
27 | 36 | WINDVANEDIRECTIONAVE
28 | 37 | WINDVANEDIRECTIONMAX
29 | 38 | WINDVANEDIRECTIONMIN
30 | 39 | WINDVANEDIRECTIONSTD
31 | 40 | TEMOUTAVE
32 | 41 | TEMOUTMAX
33 | 42 | TEMOUTMIN
34 | 43 | TEMOUTSTD
35 | 44 | ATOMPRESSUREAVE
36 | 45 | ATOMPRESSUREMAX
37 | 46 | ATOMPRESSUREMIN
38 | 47 | ATOMPRESSURESTD
39 | 48 | GENSPDAVE
40 | 49 | GENSPDMAX
41 | 50 | GENSPDMIN
42 | 51 | GENSPDSTD
43 | 52 | BLADEPITCHAVE
44 | 53 | BLADEPITCHMAX
45 | 54 | BLADEPITCHMIN
46 | 55 | BLADEPITCHSTD
47 | 56 | READWINDSPEEDAVE
48 | 57 | READWINDSPEEDMAX
49 | 58 | READWINDSPEEDMIN
50 | 59 | READWINDSPEEDSTD
51 | 60 | DATATIME
52 | 61 | GENERATION_TIME
53 | 62 | NORMALSTATE
54 | 63 | WTG_ALIAS
55 | 64 | TORQUESETPOINTAVE
56 | 65 | TORQUESETPOINTMAX
57 | 66 | TORQUESETPOINTMIN
58 | 67 | TORQUESETPOINTSTD
59 | 68 | TORQUEAVE
60 | 69 | TORQUEMAX
61 | 70 | TORQUEMIN
62 | 71 | TORQUESTD
63 | 72 | NACELLEPOSITIONAVE
64 | 73 | NACELLEPOSITIONMAX
65 | 74 | NACELLEPOSITIONMIN
66 | 75 | NACELLEPOSITIONSTD
67 | 76 | ROTORSPDAVE
68 | 77 | ROTORSPDMAX
69 | 78 | ROTORSPDMIN
70 | 79 | ROTORSPDSTD
71 | 80 | GENERATION_TIME_UTC
72 | 81 | DATATIME_UTC
73 | 82 | POWERCURVE_VALID


创建row-key
-
	430000200,WF0003WTG0024,11595352.000000000000,673056.000000000000,47340.000000000000,279342.000000000000,100.000000,100.000000,100.000000,0.000000,5.130000,8.440000,2.660000,1.060000,289.800000,651.830000,82.040000,140.380000,296.610000,655.430000,94.440000,137.960000,150.480000,170.700000,125.280000,9.440000,-0.700000,19.320000,-28.860000,9.610000,13.300000,13.320000,13.300000,0.010000,,,,,1202.410000,1556.240000,1076.590000,142.550000,0.130000,0.800000,0.000000,0.250000,1358.950000,2269.540000,679.190000,291.570000,11/27/2014 17:20:00,11/27/2014 17:20:00,71,F01.T1_L1.WTG024,2271.960000,4021.470000,846.230000,774.280000,2268.040000,4021.780000,835.300000,773.990000,151.180000,154.340000,147.410000,3.320000,11.330000,14.680000,10.130000,1.340000,11/27/2014 09:20:00,11/27/2014 09:20:00,0

**Shell 转化脚本：**

	cat pointvalue.csv | awk  -F, '{OFS=",";gsub(":","",$72);gsub("/","",$72);gsub(" ","",$72);printf("%s,",substr($72,5,4)substr($72,1,2)substr($72,4,1)$2substr($72,1,4)substr($72,9,3));print $0}' >a

	2014117WF0003WTG00241127092,430000200,WF0003WTG0024,11595352.000000000000,673056.000000000000,47340.000000000000,279342.000000000000,100.000000,100.000000,100.000000,0.000000,5.130000,8.440000,2.660000,1.060000,289.800000,651.830000,82.040000,140.380000,296.610000,655.430000,94.440000,137.960000,150.480000,170.700000,125.280000,9.440000,-0.700000,19.320000,-28.860000,9.610000,13.300000,13.320000,13.300000,0.010000,,,,,1202.410000,1556.240000,1076.590000,142.550000,0.130000,0.800000,0.000000,0.250000,1358.950000,2269.540000,679.190000,291.570000,11/27/2014 17:20:00,11/27/2014 17:20:00,71,F01.T1_L1.WTG024,2271.960000,4021.470000,846.230000,774.280000,2268.040000,4021.780000,835.300000,773.990000,151.180000,154.340000,147.410000,3.320000,11.330000,14.680000,10.130000,1.340000,11/27/2014 09:20:00,11272014092000,0


**hbase 数据导入**
	hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=,   -Dimporttsv.columns=HBASE_ROW_KEY,a:10,a:11,a:12,a:13,a:14,a:15,a:16,a:17,a:18,a:19,a:20,a:21,a:22,a:23,a:24,a:25,a:26,a:27,a:28,a:29,a:30,a:31,a:32,a:33,a:34,a:35,a:36,a:37,a:38,a:39,a:40,a:41,a:42,a:43,a:44,a:45,a:46,a:47,a:48,a:49,a:50,a:51,a:52,a:53,a:54,a:55,a:56,a:57,a:58,a:59,a:60,a:61,a:62,a:63,a:64,a:65,a:66,a:67,a:68,a:69,a:70,a:71,a:72,a:73,a:74,a:75,a:76,a:77,a:78,a:79,a:80,a:81,a:82 point point10m.csv
	
	hadoop fs -chmod -R 777 /user/root/qkp/h_point10m.csv
	
	
	hbase org.apache.hadoop.hbase.mapreduce.LoadIncrementalHFiles /user/root/qkp/h_point10m.csv point
	
**映射到Hive**

	CREATE EXTERNAL TABLE hbase_point10m(
	KEY STRING,
	WTG_ID DECIMAL(22,6),
	WTG_CODE STRING,
	APPRODUCTION DECIMAL(22,6),
	RPPRODUCTION DECIMAL(22,6),
	APCONSUMED DECIMAL(22,6),
	RPCONSUMED DECIMAL(22,6),
	PCURVESTSAVE DECIMAL(22,6),
	PCURVESTSMAX DECIMAL(22,6),
	PCURVESTSMIN DECIMAL(22,6),
	PCURVESTSSTD DECIMAL(22,6),
	WINDSPEEDAVE DECIMAL(22,6),
	WINDSPEEDMAX DECIMAL(22,6),
	WINDSPEEDMIN DECIMAL(22,6),
	WINDSPEEDSTD DECIMAL(22,6),
	ACTIVEPWAVE DECIMAL(22,6),
	ACTIVEPWMAX DECIMAL(22,6),
	ACTIVEPWMIN DECIMAL(22,6),
	ACTIVEPWSTD DECIMAL(22,6),
	ACTIVEPWCALAVE DECIMAL(22,6),
	ACTIVEPWCALMAX DECIMAL(22,6),
	ACTIVEPWCALMIN DECIMAL(22,6),
	ACTIVEPWCALSTD DECIMAL(22,6),
	WINDDIRECTIONAVE DECIMAL(22,6),
	WINDDIRECTIONMAX DECIMAL(22,6),
	WINDDIRECTIONMIN DECIMAL(22,6),
	WINDDIRECTIONSTD DECIMAL(22,6),
	WINDVANEDIRECTIONAVE DECIMAL(22,6),
	WINDVANEDIRECTIONMAX DECIMAL(22,6),
	WINDVANEDIRECTIONMIN DECIMAL(22,6),
	WINDVANEDIRECTIONSTD DECIMAL(22,6),
	TEMOUTAVE DECIMAL(22,6),
	TEMOUTMAX DECIMAL(22,6),
	TEMOUTMIN DECIMAL(22,6),
	TEMOUTSTD DECIMAL(22,6),
	ATOMPRESSUREAVE DECIMAL(22,6),
	ATOMPRESSUREMAX DECIMAL(22,6),
	ATOMPRESSUREMIN DECIMAL(22,6),
	ATOMPRESSURESTD DECIMAL(22,6),
	GENSPDAVE DECIMAL(22,6),
	GENSPDMAX DECIMAL(22,6),
	GENSPDMIN DECIMAL(22,6),
	GENSPDSTD DECIMAL(22,6),
	BLADEPITCHAVE DECIMAL(22,6),
	BLADEPITCHMAX DECIMAL(22,6),
	BLADEPITCHMIN DECIMAL(22,6),
	BLADEPITCHSTD DECIMAL(22,6),
	READWINDSPEEDAVE DECIMAL(22,6),
	READWINDSPEEDMAX DECIMAL(22,6),
	READWINDSPEEDMIN DECIMAL(22,6),
	READWINDSPEEDSTD DECIMAL(22,6),
	DATATIME string,
	GENERATION_TIME string,
	NORMALSTATE STRING,
	WTG_ALIAS STRING,
	TORQUESETPOINTAVE DECIMAL(22,6),
	TORQUESETPOINTMAX DECIMAL(22,6),
	TORQUESETPOINTMIN DECIMAL(22,6),
	TORQUESETPOINTSTD DECIMAL(22,6),
	TORQUEAVE DECIMAL(22,6),
	TORQUEMAX DECIMAL(22,6),
	TORQUEMIN DECIMAL(22,6),
	TORQUESTD DECIMAL(22,6),
	NACELLEPOSITIONAVE DECIMAL(22,6),
	NACELLEPOSITIONMAX DECIMAL(22,6),
	NACELLEPOSITIONMIN DECIMAL(22,6),
	NACELLEPOSITIONSTD DECIMAL(22,6),
	ROTORSPDAVE DECIMAL(22,6),
	ROTORSPDMAX DECIMAL(22,6),
	ROTORSPDMIN DECIMAL(22,6),
	ROTORSPDSTD DECIMAL(22,6),
	GENERATION_TIME_UTC STRING,
	DATATIME_UTC STRING,
	POWERCURVE_VALID DECIMAL(22,6)
	)
	STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
	WITH SERDEPROPERTIES ('hbase.columns.mapping' = ':key#string,a:10#string,a:11#string,a:12#string,a:13#string,a:14#string,a:15#string,a:16#string,a:17#string,a:18#string,a:19#string,a:20#string,a:21#string,a:22#string,a:23#string,a:24#string,a:25#string,a:26#string,a:27#string,a:28#string,a:29#string,a:30#string,a:31#string,a:32#string,a:33#string,a:34#string,a:35#string,a:36#string,a:37#string,a:38#string,a:39#string,a:40#string,a:41#string,a:42#string,a:43#string,a:44#string,a:45#string,a:46#string,a:47#string,a:48#string,a:49#string,a:50#string,a:51#string,a:52#string,a:53#string,a:54#string,a:55#string,a:56#string,a:57#string,a:58#string,a:59#string,a:60#string,a:61#string,a:62#string,a:63#string,a:64#string,a:65#string,a:66#string,a:67#string,a:68#string,a:69#string,a:70#string,a:71#string,a:72#string,a:73#string,a:74#string,a:75#string,a:76#string,a:77#string,a:78#string,a:79#string,a:80#string,a:81#string,a:82#string')
	TBLPROPERTIES ('hbase.table.name' = 'point');
	
**将wtg，理论功率曲线数据数据导入到hive中**

	create table wtg(
	WTG_CODE string,
	WTG_ID string,
	WTG_NAME_ENG string,
	WTG_TYPE_NAME_CHN string,
	WTG_TYPE_ID string,
	FARM_ID int,
	NAME string,
	FEEDER_LINE_ID int,
	PLC_ID int)
	COMMENT 'WTG RECORD'
	ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
	STORED AS TEXTFILE;
	LOAD DATA  INPATH '/user/qkp/wtg.csv' INTO TABLE wtg;



tpc表

	create table tpc(
	farm_id int,
	wtg_type_id int,
	WIND_SPEED_RANK FLOAT,
	POWER_AT_WIND_SPEED_RANK int,
	group_rank string
	)
	COMMENT 'tpc RECORD'
	ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
	STORED AS TEXTFILE;
	LOAD DATA  INPATH '/user/qkp/theoretic_power_curve.csv' INTO TABLE tpc;

--ss 内表

Rowkey转化：
	head -1 ssnew.csv | awk -F, -v a="" '{a=$2;gsub(/\./,"",a);gsub("_","",a);printf("%s",a);a=$3;gsub("-","",a);gsub(":","",a);gsub(" ","",a);printf("%s,",a);print $0}'


	hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=,   -Dimporttsv.columns=HBASE_ROW_KEY,a:10,a:11,a:12,a:13,a:14,a:15,a:16,a:17 ss /user/qkp/ss.csv
	
	
No.|hbase_column_name| database_column_name
--|--|--
1 | 10 | SS_GROUP_ID
2 | 11 | WTG_ALIAS
3 | 12 | SC_STARTTIME
4 | 13 | REASON
5 | 14 | SYSTEM_ID
6 | 15 | RESPON
7 | 16 | COMPONENET_ID
8 | 17 | FLAG

	CREATE EXTERNAL TABLE hbase_ss(
	KEY STRING,
	SS_GROUP_ID int,
	WTG_ALIAS string,
	SC_STARTTIME string,
	REASON string,
	SYSTEM_ID string,
	RESPON string,
	COMPONENET_ID string,
	FLAG string 
	)
	STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
	WITH SERDEPROPERTIES ('hbase.columns.mapping' = ':key#string,a:10#string,a:11#string,a:12#string,a:13#string,a:14#string,a:15#string,a:16#string,a:17#string')
	TBLPROPERTIES ('hbase.table.name' = 'ss');
	
	
SS损失电量计算
-

	insert OVERWRITE table eba_factor  select reason,ss_group_id,wtg_alias,sc_starttime,sc_endtime,sum(prod) from (select ss.*, point.prod from (select ss_group_id,wtg_alias, from_unixtime(unix_timestamp(concat(substr(sc_starttime,1,19),'.',substr(sc_starttime,21,3)),'yyyy-MM-dd HH:mm:ss.SSS')) sc_starttime, lead(from_unixtime(unix_timestamp(concat(substr(sc_starttime,1,19),'.',substr(sc_starttime,21,3)),'yyyy-MM-dd HH:mm:ss.SSS')))  over (partition by wtg_alias order by sc_starttime) sc_endtime, reason from hbase_ss) ss join ( select wtg_code, wtg_alias, DATATIME_UTC, from_unixtime(unix_timestamp(DATATIME_UTC, 'MMddyyyyHHmmss')) as min10,lead(APPRODUCTION) over (partition by wtg_code order by from_unixtime(unix_timestamp(DATATIME_UTC,'MMddyyyyHHmmss'))) - APPRODUCTION as prod from hbase_point10m) point on (point.wtg_alias = ss.wtg_alias) where ss.sc_endtime > minus_mins(point.DATATIME_UTC,10) and ss.sc_starttime <= point.min10 and ss_group_id in (70,71,72) union all  select ss.*,REV.prod from (select ss_group_id,wtg_alias,from_unixtime(unix_timestamp(concat(substr(sc_starttime,1,19),'.',substr(sc_starttime,21,3)),'yyyy-MM-dd HH:mm:ss.SSS')) sc_starttime, lead(from_unixtime(unix_timestamp(concat(substr(sc_starttime,1,19),'.',substr(sc_starttime,21,3)),'yyyy-MM-dd HH:mm:ss.SSS')))  over (partition by wtg_alias order by sc_starttime) sc_endtime, reason from hbase_ss) ss join ( select point.wtg_code, point.wtg_alias, point.DATATIME_UTC,point.min10,tpc.POWER_AT_WIND_SPEED_RANK - ap as prod from ( select wtg_code, wtg_alias, DATATIME_UTC, READWINDSPEEDAVE, from_unixtime(unix_timestamp(DATATIME_UTC, 'MMddyyyyHHmmss')) as min10,lead(APPRODUCTION) over (partition by wtg_code order by from_unixtime(unix_timestamp(DATATIME_UTC,'MMddyyyyHHmmss'))) - APPRODUCTION as ap from hbase_point10m) point  join wtg on point.wtg_code = wtg.wtg_code  join tpc on (tpc.WIND_SPEED_RANK = round(point.READWINDSPEEDAVE*2)/2  and tpc.farm_id = wtg.farm_id  and tpc.wtg_type_id = wtg.wtg_type_id) ) REV on (REV.wtg_alias = ss.wtg_alias) where (ss.sc_endtime > minus_mins(REV.DATATIME_UTC,10) and ss.sc_starttime <= REV.min10  and ss_group_id not in (70,71,72)) ) ta group by reason,ss_group_id,wtg_alias,sc_starttime,sc_endtime;
		
	
	create table eba_factor(
	reason string,
	ss_group_id int,
	wtg_alias string,
	sc_starttime string,
	sc_endtime string,
	revenue float
	)
	COMMENT 'eba_factor RECORD';

 




hive 导入外表时，忽略第一行
-
	Create external table testtable (name string, message string) row format delimited fields terminated by '\t' lines terminated by '\n' location '/testtable' tblproperties ("skip.header.line.count"="1");
	

分步计算ss损失：
-
point_temp

	create table point_temp(
	wtg_code string,
	wtg_alias string,
	DATATIME_UTC string,
	WINDSPEEDAVE DECIMAL(22,6),
	min10 string,
	prod DECIMAL(22,6)
	)
	COMMENT 'point_temp RECORD';
	insert overwrite table point_temp
	SELECT wtg_code,wtg_alias,DATATIME_UTC,WINDSPEEDAVE,from_unixtime(unix_timestamp(DATATIME_UTC, 'MMddyyyyHHmmss'))AS min10,lead(APPRODUCTION) over (partition BY wtg_code order by from_unixtime(unix_timestamp(DATATIME_UTC,'MMddyyyyHHmmss'))) - APPRODUCTION AS prod FROM hbase_point10m_t where APPRODUCTION is not NULL union all SELECT wtg_code,wtg_alias,DATATIME_UTC,WINDSPEEDAVE,from_unixtime(unix_timestamp(DATATIME_UTC, 'MMddyyyyHHmmss'))AS min10,0 AS prod FROM hbase_point10m_t where APPRODUCTION is  NULL;
	
tap

	create table tap(
	wtg_code string,
	wtg_alias string,
	DATATIME_UTC string,
	min10 string,
	tp DECIMAL(22,6),
	ap DECIMAL(22,6)
	)
	COMMENT 'tap RECORD';
	
	insert overwrite table tap select  point_temp.wtg_code,point_temp.wtg_alias,point_temp.DATATIME_UTC,point_temp.min10,tpc.POWER_AT_WIND_SPEED_RANK/6  as tp,prod as ap  from point_temp   JOIN wtg ON point_temp.wtg_code = wtg.wtg_code JOIN tpc ON (tpc.WIND_SPEED_RANK = ROUND(point_temp.WINDSPEEDAVE*2)/2 AND tpc.farm_id = wtg.farm_id AND tpc.wtg_type_id = wtg.wtg_type_id and group_rank='TPC_STD');
	
ss_t

	create table ss_t(
	ss_group_id string,
	wtg_alias string,
	sc_starttime string,
	sc_endtime string,
	reason string
	)
	COMMENT 'ss_t RECORD';
	insert overwrite table ss_t select ss_group_id,
	wtg_alias,
	from_unixtime(unix_timestamp(concat(SUBSTR(sc_starttime,1,19),'.',SUBSTR(sc_starttime,21,3)),'yyyy-MM-dd HH:mm:ss.SSS')) sc_starttime,
	lead(from_unixtime(unix_timestamp(concat(SUBSTR(sc_starttime,1,19),'.',SUBSTR(sc_starttime,21,3)),'yyyy-MM-dd HH:mm:ss.SSS'))) over (partition BY wtg_alias order by sc_starttime) sc_endtime,
	reason   from hbase_ss_t;

point_ss

	create table point_ss(
	ss_group_id string,
	wtg_alias string,
	sc_starttime string,
	sc_endtime string,
	reason string,
	net_ap DECIMAL(22,6)
	)
	COMMENT 'point_ss RECORD';
	
	
	insert overwrite table point_ss  SELECT ss_group_id,
	ss_t.wtg_alias,
	sc_starttime,
	sc_endtime,
	reason,
	tap.tp - tap.ap 
	FROM ss_t  join tap on (tap.wtg_alias = ss_t.wtg_alias) WHERE ss_t.sc_endtime>str_to_date(minus_mins(tap.DATATIME_UTC,10),'MMddyyyyHHmmss')  AND ss_t.sc_starttime<= tap.min10 AND ss_group_id NOT  IN (70,71,72) union all SELECT ss_group_id,
	ss_t.wtg_alias,
	sc_starttime,
	sc_endtime,
	reason,tap.ap FROM ss_t join tap on (tap.wtg_alias = ss_t.wtg_alias) WHERE ss_t.sc_endtime> str_to_date(minus_mins(tap.DATATIME_UTC,10),'MMddyyyyHHmmss')  AND ss_t.sc_starttime<= tap.min10 AND ss_group_id  IN (70,71,72);
	
	
point_ss_sum

	create table point_ss_sum(
	reason string,
	ss_group_id string,
	wtg_alias string,
	sc_starttime string,
	sc_endtime string,
	net_ap_sum DECIMAL(22,6)
	)
	COMMENT 'point_ss_sum RECORD';
	
	insert overwrite table point_ss_sum
	select reason,ss_group_id,wtg_alias,sc_starttime,sc_endtime,sum(net_ap) from point_ss group by reason,ss_group_id,wtg_alias,sc_starttime,sc_endtime;
