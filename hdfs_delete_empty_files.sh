#!/bin/bash -e

HDFS=$1

echo "Checking for empty files in $HDFS..."

IFS=$'\n'

for i in `hdfs dfs -ls $HDFS | grep -e "$HDFS/*" | awk '{print $0}'` ; do
	file=$(echo $i | awk '{print $8}')
	size=$(echo $i | awk '{print $5}') 

	if [ $size -eq 0 ]; then
		echo "Deleting $file ...";
		hdfs dfs -rm $file ;
	fi
done
