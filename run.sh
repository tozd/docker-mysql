#!/bin/bash -e

# An example script to run MySQL (MairaDB fork) in production. It uses data volumes under the $DATA_ROOT directory.
# By default /srv. After first run, you can connect to the MySQL as an administrator from the inside
# the container, by default:
#
# docker exec -t -i mysql /bin/bash
#
# mysql -u root
#
# You should set MySQL root user's password as soon as possible:
#
# mysqladmin -u root password '<PASSWORD>'
#
# After that you can connect to the MySQL using:
#
# mysql -u root -p
#
# You can create database:
#
# CREATE DATABASE <DBNAME>
#
# You can create users:
#
# GRANT ALL PRIVILEGES ON <DBNAME>.* TO <USERNAME>@localhost IDENTIFIED BY '<PASSWORD>'

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
