
#!/bin/bash

source grid_user_config.bash

export USER_NAME="$(id -u -n)"


if [ ${USER_NAME} != 'grid' ]; then

   echo "Script must be run as user: grid"
   exit -1

fi



export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${DBRU_BUG}_${TIMESTAMP}.log
opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir ${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${BUGNO}/${DBRU_BUG} >> ${LOGFILE}

export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${OCW_BUG}_${TIMESTAMP}.log
opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir ${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${BUGNO}/${OCW_BUG} >> ${LOGFILE}

export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${ACFS_BUG}_${TIMESTAMP}.log
opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir ${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${BUGNO}/${ACFS_BUG} >> ${LOGFILE}

export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${TOMCAT_BUG}_${TIMESTAMP}.log
opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir ${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${BUGNO}/${TOMCAT_BUG} >> ${LOGFILE}

export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${DBWLM_BUG}_${TIMESTAMP}.log
opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir ${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${BUGNO}/${DBWLM_BUG} >> ${LOGFILE}
