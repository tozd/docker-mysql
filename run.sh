#/bin/bash -e

mkdir -p /srv/var/log/mysql
mkdir -p /srv/mysql

docker run -d --restart=always --name mysql --hostname mysql -v /srv/var/hosts:/etc/hosts:ro -v /srv/var/log/mysql:/var/log/mysql -v /srv/mysql:/var/lib/mysql cloyne/mysql
