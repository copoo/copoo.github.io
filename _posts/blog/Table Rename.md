Table Rename
-
In versions 0.90.x of hbase and earlier, we had a simple script that would rename the hdfs table directory and then do an edit of the hbase:meta table replacing all mentions of the old table name with the new. The script was called ./bin/rename_table.rb. The script was deprecated and removed mostly because it was unmaintained and the operation performed by the script was brutal.

As of hbase 0.94.x, you can use the snapshot facility renaming a table. Here is how you would do it using the hbase shell:

	hbase shell> disable 'tableName'
	hbase shell> snapshot 'tableName', 'tableSnapshot'
	hbase shell> clone_snapshot 'tableSnapshot', 'newTableName'
	hbase shell> delete_snapshot 'tableSnapshot'
	hbase shell> drop 'tableName'
or in code it would be as follows:

	void rename(HBaseAdmin admin, String oldTableName, String newTableName) {
	  String snapshotName = randomName();
	  admin.disableTable(oldTableName);
	  admin.snapshot(snapshotName, oldTableName);
	  admin.cloneSnapshot(snapshotName, newTableName);
	  admin.deleteSnapshot(snapshotName);
	  admin.deleteTable(oldTableName);
	}
	
	
不间断执行某命令 while true;do ps -ef|grep INFA;sleep 1;done