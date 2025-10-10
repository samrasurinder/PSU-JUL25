#!/bin/bash

source oracle_user_config.bash

export USER_NAME="$(id -u -n)"


if [ ${USER_NAME} != 'oracle' ]; then

   echo "Script must be run as user: oracle"
   exit -1

fi

export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${TIMESTAMP}.log

for patch in `cat ${PATCH_DIR}/${ROLLBACK_PATCH_LIST} | sort`
do

PATCH_NUMBER=${patch}

echo "Rollbacking patch  ${PATCH_NUMBER}.." >> ${LOGFILE}

$ORACLE_HOME/OPatch/opatch rollback -silent -id ${PATCH_NUMBER} >> ${LOGFILE}

done


