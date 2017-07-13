#!/bin/bash

hdfs dfs -ls $1 | awk '{print $8}' | \
  xargs -n 1 -I ^ -P 10 bash -c \ #Parallelize by downloading and grepping 10 files at a time
  "hdfs dfs -cat ^ | grep -q '$2' && echo ^"
