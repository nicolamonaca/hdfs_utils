#!/bin/bash

HDFS_DIR=$1
HEADER_LINES=$2

total_lines_count=0

echo -n "Counting lines... "
for i in `hdfs dfs -ls "$1" | awk '{print $8}'` ; do
	total_lines_count=$(($total_lines_count+$(hdfs dfs -cat $i | wc -l)-$HEADER_LINES));
done;

echo $total_lines_count
