#!/bin/bash

SVC_FLG=1
END_FLG=0
IFS=$'\n'

echo '{ "data" : ['

for LINE in `sudo /sbin/ipvsadm -Ln`
do
#	echo ${LINE}
	TYPE=`echo ${LINE} | awk '{print $1}'`
	IP_INFO=`echo ${LINE} | awk '{print $2}'`
	if [ ${END_FLG} != 0 ] ; then
		echo ", "
	fi
	if [ "${TYPE}" = "TCP" -o "${TYPE}" = "UDP" ] ; then
		CUR_TYPE=${TYPE}
		CUR_IP_INFO=${IP_INFO}
		SVC_FLG=0
	elif [ "${TYPE}" = "->" -a ${SVC_FLG} = 0 ] ; then
		echo -n "{ \"{#VTYPE}\" : \"${CUR_TYPE}\", \"{#VIPINFO}\" : \"${CUR_IP_INFO}\", \"{#RIPINFO}\" : \"${IP_INFO}\" }"
		END_FLG=1
	fi
done
echo " ] }"

