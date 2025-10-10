
#!/bin/bash

source oracle_user_config.bash

export USER_NAME="$(id -u -n)"


if [ ${USER_NAME} != 'oracle' ]; then

   echo "Script must be run as user: oracle"
   exit -1

fi

echo ${ORACLE_HOME}


${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${BUGNO}/${OCW_BUG}/custom/scripts/prepatch.sh -dbhome ${ORACLE_HOME}

export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${OCW_BUG}_${TIMESTAMP}.log
opatch apply -silent -oh ${ORACLE_HOME} -local ${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${BUGNO}/${OCW_BUG} >> ${LOGFILE}


export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${DBRU_BUG}_${TIMESTAMP}.log
opatch apply -silent -oh ${ORACLE_HOME} -local ${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${BUGNO}/${DBRU_BUG} >> ${LOGFILE}

${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${BUGNO}/${OCW_BUG}/custom/scripts/postpatch.sh -dbhome ${ORACLE_HOME}
