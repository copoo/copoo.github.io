**数据导出（服务端运行）**

1. 创建DATA_DUMP_DIR服务器路径
	>sqlplus / as sysdba
	>
	>create or replace directory DATA_DUMP_DIR as 'C:\DMP';
	
2. 导出数据
	> expdp system/Envisi0n@BAOSE1 schemas=infa_161 dumpfile=infa_161_expdp.dmp log=infa_161_EXPDP.log directory=DATA_DUMP_DIR
	
	
**数据导入（服务端运行）**

1. 创建DATA_PUMP_DIR服务器路径
	>sqlplus / as sysdba
	>
	>create or replace directory DATA_PUMP_DIR as 'C:\DMP';
2. 创建表空间
	 +  查看表空间文件路径
			
			select tablespace_name,file_id,bytes/1024/1024,file_name from dba_data_files order by file_id;
	 + 创建表空间
	 
			CREATE TABLESPACE INFOREPUSER
		    LOGGING
	    	DATAFILE 
	    	'/mnt/data/app/oracle/oradata/INFOREPUSER.dbf' SIZE 1G
	    	AUTOEXTEND ON
	    	EXTENT MANAGEMENT LOCAL
	    	UNIFORM SEGMENT SPACE MANAGEMENT
	    	AUTO;


3. 导入数据
	>impdp system/Envisi0n@BAO  directory=DATA_PUMP_DIR  remap_schema=INFA_161:InfoRep dumpfile=INFA_161_EXPDP.DMP 

**停止INFA 服务**

	cd /home/infa/Informatica/9.5.1/tomcat/bin/
	 ./infaservice.sh  shutdown
**将数据库主机IP/主机名配置到本地hosts文件中**
	
	vim  /etc/hosts

在文件尾部，增加一行记录

	172.16.34.164   ESCNSHBAOAPP02.envisioncn.com   ESCNSHBAOAPP02


**修改Domain库jdbc连接**
  
  	#cd /home/infa/Informatica/9.5.1/isp/config/
  	#vim nodemeta.xml
  
 > <domainservice:DBConnectivity imx:id="ID_1" dbConnectString="jdbc:informatica:oracle:%2F%2F**ESCNSHBAOAPP02**:**1521**%3BServiceName%3D **BAO**%3BMaxPooledStatements%3D20%3BCatalogOptions%3D0%3BBatchPerformanceWorkaround%3Dtrue" dbEncryptedPassword="**GIDiC6PKCSeOcPvgZavKgw%3D%3D**" dbType="ORACLE" dbUsername="**InfoRep**"/>

加粗部分依次为:数据库主机名，数据库监听端口，服务名,数据库用户密码（加密），数据库用户名
 
**修改密码nodemeta.xml中jdbc用户密码**
 
 	./infasetup.sh UpdateGatewayNode -databasepassword InfoRep
 	
**启用INFA服务**
	
	cd /home/infa/Informatica/9.5.1/tomcat/bin/
	./infaservice.sh  startup
	
**修改控制台中知识库连接字符串及用户名密码，重启知识库服务**