#!/bin/bash

if [[ $# != 2 ]]
then
  echo "backup.sh target_directory destination_directory"
  exit
fi

if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory"
  exit
fi

targetDirectory=$1
destinationDirectory=$2

echo "$1"
echo "$2"

currentTS=$(date +'%s')

backupFileName="backup-$currentTS.tar.gz"

  # 1: Pergi ke target directory
  # 2: Membuat backup file
  # 3: Pindah backup file ke destination directory

origAbsPath=`pwd`

cd $destinationDirectory # <-
destDirAbsPath=`pwd`

cd $origAbsPath # <-
cd $targetDirectory # <-

yesterdayTS=$(($currentTS - 24 * 60 * 60))

declare -a toBackup

for file in $(ls) 
do
  if ((`date -r $file +%s` > $yesterdayTS))
  then
    toBackup+=($file) 
  fi
done

tar -czvf $backupFileName ${toBackup[@]}

mv $backupFileName $destDirAbsPath
# Finished!
