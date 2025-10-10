#!/bin/bash

source oracle_user_config.bash

export USER_NAME="$(id -u -n)"


if [ ${USER_NAME} != 'oracle' ]; then

   echo "Script must be run as user: oracle"
   exit -1

fi

zip_dir=${PATCH_DIR}/CPU_ZIP_FILES
dest_dir=${PATCH_DIR}


if [ ! -d "$zip_dir" ]; then
    echo "Error: Directory '$zip_dir' does not exist."
    exit 1
fi


cd "$zip_dir"


for zip_file in *.zip; do

    if [ -f "$zip_file" ]; then
        echo "Unzipping $zip_file..."
        unzip -oq "$zip_file" -d "$dest_dir"
        if [ $? -eq 0 ]; then
            echo "$zip_file extracted successfully."
        else
            echo "Error: Failed to extract $zip_file."
        fi
    else
        echo "No ZIP files found in $zip_dir."
        break
    fi
done

echo "Changing permissions - Please wait"
chmod -R 777 $dest_dir/3*

