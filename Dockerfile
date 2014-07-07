FROM cloyne/runit

MAINTAINER Mitar <mitar.docker@tnode.com>

EXPOSE 3306/tcp

COPY ./patches .

RUN apt-get update -q -q && \
 apt-get install mysql-server --yes --force-yes && \
 mkdir -m 700 /var/lib/mysql.orig && \
 mv /var/lib/mysql/* /var/lib/mysql.orig/ && \
 sed -i 's/127\.0\.0\.1/0.0.0.0/' /etc/mysql/my.cnf && \
 apt-get install patch --yes --force-yes && \
 patch --directory=/ --force /usr/bin/mysqld_safe mysqld_safe.patch && \
 rm mysqld_safe.patch && \
 apt-get purge patch --yes --force-yes && \
 apt-get install rsyslog --no-install-recommends --yes --force-yes && \
 sed -i 's/\/var\/log\/daemon/\/var\/log\/mysql\/daemon/' /etc/rsyslog.conf

COPY ./etc /etc
