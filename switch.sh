#!/bin/bash

if [ $2 -lt $3 ];then
        start=$2
        stop=$3
else
        start=$3
        stop=$2
fi
awk -F "" -v line="$1" -v var1="$start" -v var2="$stop" 'NR==line { 
	for(i=1;i<var1;i++){
                printf "%s", $i
	} 
        printf "%s", $var2
	for(i=var1+1;i<var2;i++){
                printf "%s", $i
	} 
        printf "%s", $var1
	for(i=var2+1;i<=NF;i++){
                printf "%s", $i
	} 
        printf "\n"
} 
NR != line {print $0}' <&0
