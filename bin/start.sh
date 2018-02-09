#! /bin/sh
app_name="MsgServiceApplication"
app_jar_name="ghw_sdk_h5_platform_service_msg"
deploy_dir="$(cd "`dirname $(readlink -nf "$0")`"/..; pwd -P)"
echo "app_name=${app_name}  deploy_dir=${deploy_dir}"
PIDS=`ps -ef | grep java | grep ${app_name} |awk '{print $2}'`
if [ -n "$PIDS" ]; then
    echo "ERROR: The ${app_name} already started!"
    echo "PID: $PIDS"
    exit 1
fi
lib_dir=$deploy_dir/lib
echo "lib dir: ${lib_dir}"
main_jar=`ls ${deploy_dir}|grep ${app_jar_name}|grep .jar|awk '{print "'${deploy_dir}'/"$0}'|tr "\n" " "`
echo "main jar: ${main_jar}"
echo "${app_name} is startting..."
nohup java -Xms128m -Xmx1024m  \
-Djava.ext.dirs=${deploy_dir}/lib  \
 -cp ${main_jar} com.ghw.sdk.h5.platform.service.msg.MsgServiceApplication  \
--spring.config.location=${deploy_dir}/config/   \
 >/dev/null  2>&1 &
count=0
while [ ${count} -lt 1 ]; do
    echo -e ".\c"
    sleep 1
    count=`ps -f | grep java | grep ${app_name} | awk '{print $2}' | wc -l`
    if [ ${count} -gt 0 ]; then
        break
    fi
done
echo "${app_name} is started!"
PIDS=`ps -f | grep java | grep "${app_name}" | awk '{print $2}'`
echo "PID: ${PIDS}"
