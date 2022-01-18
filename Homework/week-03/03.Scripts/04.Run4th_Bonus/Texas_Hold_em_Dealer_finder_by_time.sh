#!/bin/bash
cd /03-student/Homework3/Dealer_Schedules_0310

cat  |awk -F" " '{print $1, $2,  $7, $8}' $1_Dealer_schedule |grep $2
