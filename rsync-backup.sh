#!/bin/bash
# usage: rsync-backup [options] from_dir backup_dir backup_name
#
# perform incremental backups using rsync.  The backups are put
# in a directory called
#
#    backup-$name-$date
#
# where date is of the form 
#
#    "+%Y-%m-%dT%H:%M:%S"
#
# IMPORTANT
# you need to put the current link in by hand the first time
# 
#
# Note these options are used
#     -avx --delete 
# If an exclude list is sent, it is used as  
#     --exclude-from

function usage_and_exit {
    echo "rsync-backup [-e exclude_list] from_dir backup_dir name"
    exit 1
}

options=""

exclude_list="none"
while getopts "e:" Option
  do
  case $Option in
      e)  exclude_list=$OPTARG ;;
      [?]) usage_and_exit ;;  
  esac
done
shift $(($OPTIND - 1))

if [[ $# -lt 3 ]]; then
    usage_and_exit
fi


from_dir=$1
backup_dir=$2
name=$3



if [[ $exclude_list != "none" ]]; then
    options="--exclude-from=$exclude_list"
fi

mkdir -p $backup_dir || exit 1
echo "cd $backup_dir"
cd $backup_dir || exit 1

dt=`date "+%Y-%m-%dT%H:%M:%S"`
backup_name="backup-$name-$dt"


# this is run from backup_dir
command="
rsync
	-avx
	$options
	--delete
	--link-dest=../current
	${from_dir}/
	./$backup_name/
"

echo "executing rsync command:"
echo "$command"
$command || exit 1

rm -f current
ln -s $backup_name current

echo Done
date