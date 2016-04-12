#!/bin/bash

HOSTNAME=localhost
PORT=6379
USER=root
DATABASE="--all-databases"
FILE=dump.sql
PASSWORD=""
METHOD=mysqldump


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

function mysqldump_backup(){
   #     echo "$1"
  #      echo "$2"
#echo "$3"
#echo "$4"
#echo "$5"
#echo "$6"

	mysqldump -h $1 --port=$2 -u $3 --password=$4 $5> "$6"
}

#make_backup localhost 6379 root 852456 dump_test dump_test2.sql

function binlog_backup(){
	echo "helloworld"
}

function echo_valid_method(){
	echo "-m mysqldump || mysqlbinlog  default=mysqldump"
}
function do_backup(){
     case $METHOD in
         mysqldump)
            mysqldump_backup $HOSTNAME $PORT $USER $PASSWORD $DATABASE $FILE;;
         ?)
            echo "unvalid method"
            exit 1
            ;;
    esac
    echo "================SUCCESSFULLY BACKUP================"
    echo "DUMPFILE: "$FILE
    echo `date`
    echo "=====================##END##========================"
 }

while getopts "m:h:P:u:p:d:f:" arg
do
 #	echo $OPTARG
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
	m)
               METHOD=$OPTARG;;
        ?)
               default_command
               exit 1
               ;;
     esac
done

if [ ${#PASSWORD} -eq 0 ]; then
   echo "-p must be setted for password"
else
   do_backup
fi
