#!/bin/bash

sed -i 's/\///g' 2


while IFS=, read -ra arr; do
	    ## Do something with ${arr0]}, ${arr[1]} and ${arr[2]}


dat=$(date -d ${arr[1]:0:9} +'%Y-%m-%d')
dat=$(echo $dat ${arr[1]:10})
	    echo "INSERT INTO print_detail (printer,date,user,IP,info) VALUES ('${arr[0]}','$dat','${arr[2]}','${arr[3]}', '${arr[4]}');"

done < 2 | mysql -uroot -p123 printer 
sed  -i 's/ /:/' 2
