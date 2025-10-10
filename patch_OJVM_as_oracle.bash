
#!/bin/bash

source oracle_user_config.bash

export USER_NAME="$(id -u -n)"


if [ ${USER_NAME} != 'oracle' ]; then

   echo "Script must be run as user: oracle"
   exit -1

fi

echo ${ORACLE_HOME}



export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${DB_OJVM_PATCH_NUMBER}_${TIMESTAMP}.log

cd ${PATCH_DIR}/${COMBO_PATCH_NUMBER}/${DB_OJVM_PATCH_NUMBER}
opatch apply -silent >> ${LOGFILE}

