#!/bin/sh

project_path=$1
start_script=$2
wait_sec=$3
wait_host=$4
wait_port=$5

exit_with_usage() {
    echo "usage:"
    echo "wait_to_start_project.sh <project_path> <start_script> [wait_sec] [wait_host <wait_port>]"
    exit
}

if [ -z "$project_path" ]; then
    exit_with_usage
fi

if [ -n "$wait_host" ]; then
    if [ -z "$wait_port" ]; then
        exit_with_usage
    fi
    nc_check=1
    until [ $nc_check -eq 0 ]; do
        nc -z $wait_host $wait_port
        nc_check=$?
        sleep 1
    done
fi

if [ -n "$wait_sec" ]; then
    sleep $wait_sec
fi

if [ "$start_script" = "hang" ]; then
    tail -f /dev/null
    exit
fi

self_dir=$(cd `dirname $0`; pwd)
sh $self_dir/start_project.sh $project_path $start_script
