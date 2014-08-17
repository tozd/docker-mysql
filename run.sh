#/bin/bash -e

mkdir -p /srv/var/log/mysql
mkdir -p /srv/mysql

docker run -d --name mysql -h mysql.mysql.server2.docker -v /srv/var/log/mysql:/var/log/mysql -v /srv/mysql:/var/lib/mysql cloyne/mysql
