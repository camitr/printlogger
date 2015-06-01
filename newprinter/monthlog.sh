#!/bin/bash


monthly_print(){

echo $file
#echo "Total number of pages printed in this month =" `wc -l $file|awk {'print $1'}`
total_pages=`wc -l $file|awk {'print $1'}`
zenity --info --title="Total page print" --text="$total_pages"


}

total_user(){

	user_list=($(awk '{if (user[$2]++ == 0) print $2; }' "$@" $file))
	
	user_total=${#user_list[@]}

	echo "Total user in this month =:" $user_total 
	
	echo "List of user::"
#	printf "%s\n" "${user_list[@]}"

	zenity --list  --title="List of user"  \
		    --width=400 --height=500  --column=Username "${user_list[@]}"
}



page_count(){
	for i in ${user_list[@]}
	do
		printf "Number of print by $i are =: "
		cat $file| grep $i |wc -l
	done
}



#printf " Welcome to the Monthly log details\n"
zenity --info --title="Monthly page logger" --text="Welcome to printer log detail, Please give file name in next window"
file=$(zenity --entry --title="Monthly logger" --text="File name:")
total_user
page_count
monthly_print
