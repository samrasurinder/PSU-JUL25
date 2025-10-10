#!/bin/bash

export ORAENV_ASK=NO
export EXIT_STATUS=0
export HOSTNAME=`hostname`


export ORACLE_HOME=/u02/app/oracle/product/19.3.0/db_1
export PATH=$ORACLE_HOME/bin:$PATH
export TNS_ADMIN=$ORACLE_HOME/network/admin
 

db_list=`ps -efZ | grep [p]mon | grep -v asm | awk '{print $NF}' | sed s/ora_pmon_// | grep -v / | grep -v "-"`

 

for db in $db_list
do
export ORACLE_SID=${db}
sqlplus -s "/ as sysdba" << EOF
spool logs/${HOSTNAME}_${ORACLE_SID}_UTLRP.log
col action format a40
col status format a20
col action_Time format a60
col description format a60
set lines 200
select * from global_name;
select count(*) from dba_invalid_objects;
@?/rdbms/admin/utlrp;
Select action,status,action_Time,description from SYS.dba_registry_sqlpatch where description like '%19.28%';
select count(*) from dba_invalid_objects;
EOF
done
