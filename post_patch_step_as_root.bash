#!/bin/bash

source grid_user_config.bash

export USER_NAME="$(id -u -n)"


if [ ${USER_NAME} != 'root' ]; then

   echo "Script must be run as user: root"
   exit -1

fi

export LOGFILE=${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${TIMESTAMP}.log

${GI_HOME}/rdbms/install/rootadd_rdbms.sh >> ${LOGFILE}

if [[ $IS_THIS_RAC_DB == "YES" ]]; then
   ${GI_HOME}/crs/install/rootcrs.sh -postpatch >> ${LOGFILE}
else
   ${GI_HOME}/crs/install/roothas.sh -postpatch >> ${LOGFILE}
fi


