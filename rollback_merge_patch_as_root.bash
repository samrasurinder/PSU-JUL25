#!/bin/bash


source grid_user_config.bash

LOGFILE=$PATCH_LOG_DIR/$(hostname)_$(basename "$0")_${TIMESTAMP}.log
touch $LOGFILE
chmod 777 $LOGFILE

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $@" >> $LOGFILE
}


# Function to handle errors
check_error() {
    if [ $? -ne 0 ]; then
        log "Last command failed. Exiting."
        exit 1
    fi
}

# Ensure the script is running as root
if [ "$(id -u)" -ne 0 ]; then
   log "This script must be run as root"
   exit 1
fi



# Pre-patch operations
log "Starting pre-patch operations..."

if [[ $IS_THIS_RAC_DB == "YES" ]]; then
    $GI_HOME/crs/install/rootcrs.sh -prepatch 2>&1 | tee -a $LOGFILE
else
  $GI_HOME/crs/install/roothas.sh -prepatch 2>&1 | tee -a $LOGFILE
fi

check_error

# Modify permissions for Oracle

source oracle_user_config.bash

log "Changing owner to oracle for oradism..."

ls -ld $ORACLE_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
chown oracle $ORACLE_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
chmod 0750 $ORACLE_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
ls -ld $ORACLE_HOME/bin/oradism 2>&1 | tee -a $LOGFILE

# Run command as 'oracle' user
log "Switching to oracle user..."

su - oracle -c "
echo 'Now running as oracle user...' >> $LOGFILE;
hostname >> $LOGFILE;
whoami >> $LOGFILE;
$ORACLE_HOME/OPatch/opatch rollback -local -silent -id $ROLLBACK_MERGE_PATCH_ID -oh $ORACLE_HOME >> $LOGFILE
" 2>&1 | tee -a $LOGFILE
check_error

# Modify permissions for Grid

source grid_user_config.bash

log "Changing owner to grid for oradism..."
ls -ld $GI_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
chown grid $GI_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
chmod 0750 $GI_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
ls -ld $GI_HOME/bin/oradism 2>&1 | tee -a $LOGFILE

# Run command as 'grid' user
log "Switching to grid user..."

su - grid -c "
echo 'Now running as grid user...' >> $LOGFILE;
hostname >> $LOGFILE;
whoami >> $LOGFILE;
$GI_HOME/OPatch/opatch rollback -local -silent -id $ROLLBACK_MERGE_PATCH_ID -oh $GI_HOME >> $LOGFILE
" 2>&1 | tee -a $LOGFILE
check_error


# Final root operations
log "Setting final permissions for oradism..."

chown root $ORACLE_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
chmod 4750 $ORACLE_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
ls -ld $ORACLE_HOME/bin/oradism 2>&1 | tee -a $LOGFILE

chown root $GI_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
chmod 4750 $GI_HOME/bin/oradism 2>&1 | tee -a $LOGFILE
ls -ld $GI_HOME/bin/oradism 2>&1 | tee -a $LOGFILE


# Post-patch operations
log "Starting post-patch operations..."

if [[ $IS_THIS_RAC_DB == "YES" ]]; then
   $GI_HOME/crs/install/rootcrs.sh -postpatch 2>&1 | tee -a $LOGFILE
else
  $GI_HOME/crs/install/roothas.sh -postpatch 2>&1 | tee -a $LOGFILE
fi




log "Script completed successfully."

