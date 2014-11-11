#!/bin/bash

awk '{print $1 "," $4 "," $2 "," $9 "," $10$11$12$13$14$15$16$17$18}' page_log.1|tr -d [] > pagelog



sed -i 's/\///g' pagelog


while IFS=, read -ra arr; do
	    ## Do something with ${arr0]}, ${arr[1]} and ${arr[2]}


dat=$(date -d ${arr[1]:0:9} +'%Y-%m-%d')
dat=$(echo $dat ${arr[1]:10})
echo ${arr[1]}>a

#date formate of file to compare as integer 
sed -i  's/:/ /' a

a=`cat a`

b=$(date --date="$a" +"%s")

#return last insert data date
id=`mysql -uroot -p123 -s -N -e "select date from printer.print_detail where id = ( select max(id) from printer.print_detail);"`
echo $id>id

# convert db date in compareable formate

id=$(date --date="$id" +"%s")


if [  $id -gt  $b  ]
then
	echo ""

	    
else

	  echo "INSERT INTO print_detail (printer,date,user,IP,info) VALUES ('${arr[0]}','$dat','${arr[2]}','${arr[3]}', '${arr[4]}');"
	#echo " not match "
	
fi	

done < pagelog
| mysql -uroot -p123 printer 
sed  -i 's/ /:/' pagelog
