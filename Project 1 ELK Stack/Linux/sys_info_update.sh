#!/bin/bash



echo "A Quick System Audit Script"
date

echo "Machine Type Info:"

echo $MACHTYPE
echo -e "Uname info: $(uname -a) \n"
echo -e "IP Info:  $(hostname -I) \n"
echo "Hostname: $(hostname -s) \"

echo "DNS Servers:"
cat /etc/resolv.conf 


echo "Memory Info:"
echo -e "\nCPU Info:"
lscpu | grep CPU

echo "System Info"
lshw -short

echo "Disk Usage:"
echo -e "\nDisk Usage:"
df -H | head -2

echo "who's Logged In:"
echo -e "\nWho is logged in: \n $(who -a) \n"


echo -e "\n777 Files:" >> ~/research/sys_info.txt
find / -type f -perm 777 >> ~/research/sys_info.txt

echo -e "\nTop 10 Processes" >> ~/research/sys_info.txt
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> ~/research/sys_info.txt

