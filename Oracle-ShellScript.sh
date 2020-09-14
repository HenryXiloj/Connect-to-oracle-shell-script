#!/bin/sh
###################################  AUTOR:  ###################################
################################   Henry       #################################

#parameters DB
DATABASE_USER=$1
DATABASE_PASS=$2
IP=$3
SID=$4


DATE=`date +"%d%m%y"`
u="$USER"
echo "User name $u"

cd /home/$u

LOCATION=$PWD
echo "path ${LOCATION}"


#ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
#export ORACLE_HOME
#echo $ORACLE_HOME

dbConexion() {
#################################################################################
# I installed sql plus client, for that i use the following command "sqlplus64" #
# If you install normal oracle on your machine then you use the ORACLE_HOME     # 
# for example ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe (set your version). #
################################################################################       
#$ORACLE_HOME/bin/sqlplus -s <<EOF> ${LOCATION}/log${DATE}.out
sqlplus64 -s <<EOF> ${LOCATION}/log${DATE}.out
$DATABASE_USER/$DATABASE_PASS@//$IP:1521/$SID
select sysdate from dual;

EOF

}

dbValidate() {
p=`cat ${LOCATION}/log${DATE}.out | grep SYSDATE`
if [ -n "$p"  ]
then
        echo "Ok conexion"
        rm ${LOCATION}/log${DATE}.out
else
        echo "Bad conexion."
        exit
fi
}

echo "Start process" 
dbConexion
echo "Check conexion on DB"
dbValidate
echo "End process" 






