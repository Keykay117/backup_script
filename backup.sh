#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "The target directory is $1"
echo "The destination directory is $2"

# [TASK 3]
currentTS=$(date +%s)
#echo "$currentTS"
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")

# [TASK 4]
backupFileName="backup-${timestamp}.tar.gz"
#echo "$backupFileName" #This was a test to ensure functionality

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath="/Users/kingmuffinator/be_dev_course/shellscript_finalproject/backupScript"
#echo $origAbsPath #checking to ensure path is correct

# [TASK 6]
cd $origAbsPath
destAbsPath=($origAbsPath/backupFiles)
#echo $destAbsPath #This was a check to ensure correct destination directory

# [TASK 7]
cd  $origAbsPath
cd  $destAbsPath

# [TASK 8]
yesterdayTS=$((currentTS - 86400))
#echo $yesterdayTS #Testing to ensure date was stamped to exactly a day prior to currentTS

declare -a toBackup

toBackup+=($(ls "$targetDirectory"))

for file in ${toBackup[@]}; # [TASK 9]
do filePath="$targetDirectory/$file"
#done #finished the for loop here to ensure it was working properly before continuing
  # [TASK 10]
  if [[ -f "$filePath" && $(date -r "$filePath" +%s) -gt $yesterdayTS ]];
    # [TASK 11]
    then
    toBackup+=($file)
  fi
done

# [TASK 12]
tar -czvf "$backupFileName" "${toBackup[@]}"
# [TASK 13]
mv "$backupFileName" "$destAbsPath"
# Congratulations! You completed the final project for this course!