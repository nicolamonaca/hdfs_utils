# hdfs_utils
The Hadoop Distributed File System (HDFS) is known for having some limitations when dealing with files. In particular, some tasks like deleting empty files under a certain HDFS directory or counting the lines in *all* the files under a folder can be difficult or simply time-consuming to carry on, not to mention hard-to-remember commands. In order to overcome these limitations, I've released a set of functions to better interact with the HDFS. More will hopefully come in the future. Below is a description of each function's purpose, usage and a sample output: 

## hdfs_check_folder_size.sh

***Purpose:*** check a HDFS folder's size.

***Usage:***

    ./hdfs_check_folder_size.sh /user/nic/size

***Output:***

    81.9 G  /user/nic/size

## hdfs_delete_empty_files.sh

***Purpose:*** delete empty files under a HDFS folder. This is particularly useful when performing a "INSERT OVERWRITE DIRECTORY" from HIVE, which sometimes produces a lot of empty files.

***Usage:***

    ./hdfs_delete_empty_files.sh /user/nic/empty

***Output:***

    Checking for empty files in /user/nic/empty...
    
    Deleting /user/nic/empty/empty.txt ...
    17/07/13 11:32:56 INFO fs.TrashPolicyDefault: Namenode trash configuration: Deletion interval = 360 minutes, Emptier interval = 0 minutes.
    Moved: 'hdfs://hdm1.gphd.local:8020/user/nic/empty.txt' to trash at: hdfs://hdm1.gphd.local:8020/user/nic/empty/.Trash/Current
    
    Deleting /user/tufcdl/nic/empty/empty2.txt ...
    17/07/13 11:32:58 INFO fs.TrashPolicyDefault: Namenode trash configuration: Deletion interval = 360 minutes, Emptier interval = 0 minutes.
    Moved: 'hdfs://hdm1.gphd.local:8020/user/nic/empty/empty2.txt' to trash at: hdfs://hdm1.gphd.local:8020/user/nic/empty/.Trash/Current

## hdfs_space_report.sh

***Purpose:*** get a report of the free and used space in the cluster's total, free and used storage capacity.

***Usage:***

    ./hdfs_space_report.sh

***Output:***

    Configured Capacity: 239871532728320 (218.16 TB)
    Present Capacity: 239842944492192 (218.14 TB)
    DFS Remaining: 38827775640636 (35.31 TB)
    DFS Used: 201015168851556 (182.82 TB)
    DFS Used%: 83.81%
    Under replicated blocks: 4679
    Blocks with corrupt replicas: 0
    Missing blocks: 0
    
## hdfs_wc_over_dir.sh

***Purpose:*** count the number of lines in each file contained in a particular HDFS folder, optionally excluding n header lines in each file from the total count. This comes handy when one has to make sure the count over an external table mapped on a particular folder contains all the expected lines contained in the raw files under that same directory. 

***Usage:**

    ./hdfs_wc_over_dir.sh /user/nic/count/ 0 (<- how many header lines in each file we must exclude from the count)

***Output:***

    Counting lines... 14758

## hdfs_grep_over_dir.sh

***Purpose:*** grep a string over an entire folder. The function returns all the HDFS files in which the string was found, if any, so that it would be possible to perform a regular grep over that file to see the occurrence. The function operates in parallel, downloading a number of files that depends on the number of files in the folder, so it auto-adjusts.  

***Usage:***
    
    ./hdfs_grep_over_dir.sh /user/nic/grep 1122

***Output:***
           
    /user/nic/grep/13460604_15
    /user/nic/grep/13460604_4
