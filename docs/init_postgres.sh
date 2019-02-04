#!/bin/sh

host_name=$1
postgres_password=$2
user_password=$3
self_dir=$(cd `dirname $0`; pwd)

export PGPASSWORD=${postgres_password}
psql -h ${host_name} -U postgres -c "create role cp_postgraphile login password '${user_password}';"
psql -h ${host_name} -U postgres -f ${self_dir}/init.sql -f ${self_dir}/dump.sql

