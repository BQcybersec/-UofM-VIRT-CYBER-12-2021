#!/bin/bash

#variables

states=('Nebraska' 'California' 'Texas' 'Hawaii' 'Washington')

#loopy

for state in ${states[@]}

do

if [ $state == 'Hawaii' ];

then
	echo "Hawaii is the Best!"
else
	echo "I dislike $state's pineapple scent."
	fi
done
