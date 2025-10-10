#!/bin/bash



# Function to check if the current server is part of an RAC
check_rac_status() {
    # Extract hostname and convert to lowercase
    local hostname=$(hostname | tr '[:upper:]' '[:lower:]')

    # Default value for IS_THIS_RAC_DB
    local is_this_rac_db="NO"

    # Read through the file
    while IFS=, read -r server rac_flag
    do
        # Convert server name to lowercase for case-insensitive comparison
        local server_lower=$(echo "$server" | tr '[:upper:]' '[:lower:]')

        if [[ "$server_lower" == "$hostname" ]]; then
            if [[ "$rac_flag" == "Y" ]]; then
                is_this_rac_db="YES"
            fi
            break
        fi
    done < "$FILE_PATH"

    echo $is_this_rac_db
}


export GI_BASE=/u02/app/grid
export GI_HOME=/u02/app/19.3.0/grid
export LD_LIBRARY_PATH=${GI_HOME}/lib
export PATH=$PATH:${GI_HOME}/bin:${GI_HOME}/OPatch

export TIMESTAMP=$(date +"%Y-%m-%d-%T")
export PATCH_DIR=/nonproddatabase/oracle/software/PSU/JUL2025/$(hostname)
export PATCH_LOG_DIR=${PATCH_DIR}/logs


# File path to the server list
export FILE_PATH=${PATCH_DIR}/server_list.txt
# Call the function and store the result in a variable
export IS_THIS_RAC_DB=$(check_rac_status)

echo "Is this a RAC instance: "${IS_THIS_RAC_DB}




export COMBO_PATCH_NUMBER=37952382
export GI_DB_HOME_PATCH_NUMBER=37957391
export DB_OJVM_PATCH_NUMBER=37847857

export ROLLBACK_MERGE_PATCH_ID=34672698
export MERGE_PATCH_ID=34672698

export BUGNO=${GI_DB_HOME_PATCH_NUMBER}
export OCW_BUG=37962946
export ACFS_BUG=37962938
export TOMCAT_BUG=38124772
export DBWLM_BUG=36758186
export DBRU_BUG=37960098
export JDK_PATCH=37860476




export ROLLBACK_PATCH_LIST="rollback_patch_list.txt"
export ONEOFF_PATCH_LIST="oneoff_oracle_home_patch_list.txt"


#export PATH=$ORACLE_HOME/perl/bin:$PATH
#export PERL5LIB=$ORACLE_HOME/perl/lib

