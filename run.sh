#!/bin/bash -e

# An example script to run MySQL (MariaDB fork) in production. It uses data volumes under the $DATA_ROOT directory.
# By default /srv.

NAME='mysql'
DATA_ROOT='/srv'
MYSQL_DATA="${DATA_ROOT}/${NAME}/data"
MYSQL_LOG="${DATA_ROOT}/${NAME}/log"

mkdir -p "$MYSQL_DATA"
mkdir -p "$MYSQL_LOG"

docker stop "${NAME}" || true
sleep 1
docker rm "${NAME}" || true
sleep 1
docker run --detach=true --restart=always --name "${NAME}" --volume "${MYSQL_LOG}:/var/log/mysql" --volume "${MYSQL_DATA}:/var/lib/mysql" tozd/mysql
