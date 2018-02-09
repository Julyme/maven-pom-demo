#! /bin/sh
app_name="MsgServiceApplication"
PIDS=`ps -f | grep java | grep "${app_name}" | awk '{print $2}'`
if [ "0" != "${PIDS}0" ]; then
echo "${app_name}-${PIDS} is stopping ..."
else
        echo "${app_name} is not start."
	exit
fi
ps aux|grep java|grep ${app_name}|grep -v grep|awk '{print $2}'|xargs kill 
count=0
while [ ${count} -lt 1 ]; do
    echo -e ".\c"
    sleep 1
    count=`ps -f | grep java | grep ${app_name} | awk '{print $2}' | wc -l`
    if [ "0" = "${count}" ]; then
        break
    fi
done
echo "${app_name} is stopped!"
