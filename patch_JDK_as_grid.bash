#!/bin/bash

source grid_user_config.bash

export USER_NAME="$(id -u -n)"

if [ "${USER_NAME}" != 'grid' ]; then
    echo "Script must be run as user: grid"
    exit 1
fi

echo "GI_HOME is set to: ${GI_HOME}"

export LOGFILE="${PATCH_LOG_DIR}/$(hostname)_$(basename "$0")_${JDK_PATCH}_${TIMESTAMP}.log"

echo "JDK version before applying patch is : $($GI_HOME/jdk/bin/java -version 2>&1)" >> "${LOGFILE}"

cd "${PATCH_DIR}/${JDK_PATCH}" || exit

opatch apply -silent >> "${LOGFILE}" 2>&1

echo "JDK version after applying patch is : $($GI_HOME/jdk/bin/java -version 2>&1)" >> "${LOGFILE}"

