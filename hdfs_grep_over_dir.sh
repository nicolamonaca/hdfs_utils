#!/bin/bash
hdfs_dir=$1
string=$2

# Determine the optimal parallelization factor
num_files=$(hdfs dfs -ls $hdfs_dir | wc -l)
p_factor=$((($num_files - 1) / 3))

#Parallelize by downloading $p_factor files at a time
hdfs dfs -ls $hdfs_dir | awk '{print $8}' | \
  xargs -n 1 -I ^ -P $parallelization bash -c "hdfs dfs -cat ^ | grep -q '$string' && echo ^"
