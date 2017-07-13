# hdfs_utils
hdfs_utils is a collections of a few functions to better operate with HDFS, due to a lack of functionalities in the Hadoop Distributed File System, or, in some cases, to encapsulate hard-to-remember commands into more user-friendly names. Below is a description of each function's purpose, usage and a sample output. More functions will hopefully come in the future: 

## hdfs_check_folder_size.sh
*Purpose:* check a HDFS folder's size
*Usage:* ./hdfs_check_folder_size.sh /user/nic/
*Output:* 81.9 G  /user/nic

# hdfs_delete_empty_files.sh
*Purpose:* delete empty files under a HDFS folder. This is particularly useful when performing a "INSERT OVERWRITE DIRECTORY" from HIVE, which sometimes produces a lot of empty files.
*Usage:* ./hdfs_delete_empty_files.sh /user/nic/
*Output:* Checking for empty files in /user/nic...
Deleting /user/nic/empty.txt ...
17/07/13 11:32:56 INFO fs.TrashPolicyDefault: Namenode trash configuration: Deletion interval = 360 minutes, Emptier interval = 0 minutes.
Moved: 'hdfs://hdm1.gphd.local:8020/user/nic/empty.txt' to trash at: hdfs://hdm1.gphd.local:8020/user/nic/.Trash/Current
Deleting /user/tufcdl/nic/empty2.txt ...
17/07/13 11:32:58 INFO fs.TrashPolicyDefault: Namenode trash configuration: Deletion interval = 360 minutes, Emptier interval = 0 minutes.
Moved: 'hdfs://hdm1.gphd.local:8020/user/nic/empty2.txt' to trash at: hdfs://hdm1.gphd.local:8020/user/nic/.Trash/Current

# hdfs_space_report.sh
*Purpose:* get a report of the free and used space in the cluster's total, free and used storage capacity
*Usage:* ./hdfs_space_report.sh
*Output:* Configured Capacity: 239871532728320 (218.16 TB)
Present Capacity: 239842944492192 (218.14 TB)
DFS Remaining: 38827775640636 (35.31 TB)
DFS Used: 201015168851556 (182.82 TB)
DFS Used%: 83.81%
Under replicated blocks: 4679
Blocks with corrupt replicas: 0
Missing blocks: 0

# hdfs_wc_over_dir.sh
*Purpose:* count the number of lines in each file contained in a particular HDFS folder, optionally excluding n header lines in each file from the total count. This comes handy when making sure that the count over an external table mapped on a particular folder contains all the expected lines contained in the raw files under that same directory. 
*Usage:* ./hdfs_wc_over_dir.sh /user/nic/count_lines/ 0 (<- how many header lines in each file we must exclude from the count)
*Output:* Counting lines... 14758
