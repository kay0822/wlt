#!/bin/bash
awk -v var1="$1" -v var2="$2" 'NR==var1 { 
	s=$0;
	for(i=var1+1;i<var2;i++){
		getline; s=$0"\n"s 
	} 
	getline;print;print s
	next
}1' <&0
