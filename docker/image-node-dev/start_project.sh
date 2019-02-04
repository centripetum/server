#!/bin/sh
set -e

project_path=$1
start_script=$2

if [ ! -d "/home/node/workspace/$project_path" ]; then
    echo "error: /home/node/workspace/$project_path does not exist"
    exit
fi

cd /home/node/workspace/$project_path
yarn
yarn $start_script
