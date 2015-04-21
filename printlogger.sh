#!/bin/bash
PATH=/bin:/usr/bin:/sbin:/usr/local/bin
#this script has condition with date, only recent data will be uploaded 

cp /var/log/cups/page_log /var/www/printer-script

awk '{print $1 "," $4 "," $2 "," $9 "," $10$11$12$13$14$15$16$17$18}' /var/www/printer-script/page_log|tr -d [] > /var/www/printer-script/pagelog



sed -i 's/\///g' /var/www/printer-script/pagelog


while IFS=, read -ra arr; do
	    ## Do something with ${arr0]}, ${arr[1]} and ${arr[2]}


dat=$(date -d ${arr[1]:0:9} +'%Y-%m-%d')
dat=$(echo $dat ${arr[1]:10})
echo ${arr[1]}>/var/www/printer-script/a

#date formate of file to compare as integer 
sed -i  's/:/ /' /var/www/printer-script/a

a=`cat /var/www/printer-script/a`

b=$(date --date="$a" +"%s")

#return last insert data date
id=`/usr/bin/mysql -u root -p"123" -s -N -e "select date from print_document.print_detail where id = ( select max(id) from print_document.print_detail);"`
echo $id>/var/www/printer-script/id

#echo "printer log  taken on $(date)">>/var/www/printer-script/printerSchedule.log

# convert db date in compareable formate

id=$(date --date="$id" +"%s")

id=$((id + 1))

if [  $id -gt  $b  ]
then
	echo ""

	    
else

	  echo "INSERT INTO print_detail (printer,date,user,IP,info) VALUES ('${arr[0]}','$dat','${arr[2]}','${arr[3]}', '${arr[4]}');"
	#echo " not match "
	
fi	

#done < pagelog | mysql -uroot -p123 printer 
done < /var/www/printer-script/pagelog | /usr/bin/mysql --user=root --password="123" print_document
sed  -i 's/ /:/' pagelog

echo "printer log  taken on $(date)">>/var/www/printer-script/printerSchedule.log
