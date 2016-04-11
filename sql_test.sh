#!/bin/bash

function query_test(){
QUERY=`mysql -u root --password=852456 <<EOF
use dump_test;
select * from user;
exit 
EOF`
echo $QUERY
}
function default_command(){
     echo  -e "host =localhost\nport =6379\nuser =root\ndatabase =--all-databases\ndumo_path =dump.sql"
}
function make_backup(){
   #     echo "$1"
  #      echo "$2"
#echo "$3"
#echo "$4"
#echo "$5"
#echo "$6"

	mysqldump -h $1 --port=$2 -u $3 --password=$4 $5> "$6"
}

#make_backup localhost 6379 root 852456 dump_test dump_test2.sql
HOSTNAME=localhost
PORT=6379
USER=root
DATABASE="--all-databases"
FILE=dump.sql
PASSWORD=""
while getopts "h:P:u:p:d:f:" arg
do
 	echo $OPTARG
      case $arg in
         h)
              HOSTNAME=$OPTARG;;
         P)
              PORT=$OPTARG;;
	 u)
	       USER=$OPTARG;;
        p)
               PASSWORD=$OPTARG;;
        d) 
		DATABASE=$OPTARG;;
        f)
                FILE=$OPTARG;;
        ?)
               default_command
               exit 1
               ;;
     esac
done

if [ ${#PASSWORD} -eq 0 ]; then
   echo "-p must be setted s password"
else
   make_backup $HOSTNAME $PORT $USER $PASSWORD $DATABASE $FILE

fi
