#!/usr/bin/env bash
#   Squid Monitor
#   Nikkorod    

name=(squidmonitor)
path=/var/log
[[ ! -d ${path} ]] && mkdir -p ${path}
log=${path}/squidmonitor.log

squid_init[0]=/etc/init.d/squid

i=0
for init in "${squid_init[@]}"; do
    pid=""
    if [ -f ${init} ]; then
        squidstats=$(${init} status)
        if [ $? -eq 0 ]; then
            pid=$(echo "$squidstats" | sed -e 's/[^0-9]*//g')
        fi

        if [ -z "${pid}" ]; then
            echo "$(date +'%Y-%m-%d %H:%M:%S') ${name[$i]} is not running" >> ${log}
            echo "$(date +'%Y-%m-%d %H:%M:%S') Starting ${name[$i]}" >> ${log}
            ${init} start &>/dev/null
            if [ $? -eq 0 ]; then
                echo "$(date +'%Y-%m-%d %H:%M:%S') ${name[$i]} start success" >> ${log}
            else
                echo "$(date +'%Y-%m-%d %H:%M:%S') ${name[$i]} start failed" >> ${log}
            fi
        else
            echo "$(date +'%Y-%m-%d %H:%M:%S') ${name[$i]} is running with pid $pid" >> ${log}
        fi
    
    fi
    ((i++))
done
