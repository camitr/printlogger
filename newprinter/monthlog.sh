#!/bin/bash


monthly_print(){

echo $file
total_pages=`wc -l $file|awk {'print $1'}`
zenity --info --title="Total page print" --text="$total_pages"


}

total_user(){

	user_list=($(awk '{if (user[$2]++ == 0) print $2; }' "$@" $file))
	
	user_total=${#user_list[@]}

	
#	printf "%s\n" "${user_list[@]}"

	zenity --list  --title="List of user"  \
		    --width=400 --height=500  --column=Username "${user_list[@]}"
}



page_count(){
	arr=()
	idx=0
	for i in ${user_list[@]}
	do
       	#	printf "Number of print by $i are =:" 
	 # cat $file| grep $i |wc -l
	 arr[idx]=($(grep $i < $file| wc -l))
	 idx=$((idx+1))
	done

	print ${arr[1]}
#	print ${user_print[@]}
}



zenity --info --title="Monthly page logger" --text="Welcome to printer log detail, Please give file name in next window"
file=$(zenity --entry --title="Monthly logger" --text="File name:")
total_user
page_count
monthly_print
