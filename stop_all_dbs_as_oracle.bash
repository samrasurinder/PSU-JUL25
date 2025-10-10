#!/bin/bash

source oracle_user_config.bash

export USER_NAME="$(id -u -n)"


if [ ${USER_NAME} != 'oracle' ]; then

   echo "Script must be run as user: oracle"
   exit -1

fi


if [[ $IS_THIS_RAC_DB == "YES" ]]; then
   srvctl stop home -o ${ORACLE_HOME} -s ${PATCH_DIR}/dbnames_$(hostname)_$(date +%Y-%m-%d).txt -n $(hostname) 
else
  srvctl stop home -o ${ORACLE_HOME} -s ${PATCH_DIR}/dbnames_$(hostname)_$(date +%Y-%m-%d).txt 
fi


