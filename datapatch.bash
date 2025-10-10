#!/bin/bash

export ORACLE_HOME=/u02/app/oracle/product/19.3.0/db_1
export PATH=$ORACLE_HOME/bin:$PATH
export TNS_ADMIN=$ORACLE_HOME/network/admin

 

db_list=`ps -efZ | grep [p]mon | grep -v asm | awk '{print $NF}' | sed s/ora_pmon_// | grep -v / | grep -v "-" | grep -v '+' | sort`

for db in $db_list
do
export ORACLE_SID=$db

cd $ORACLE_HOME/OPatch
./datapatch &

done
