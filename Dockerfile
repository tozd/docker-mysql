FROM cloyne/runit

MAINTAINER Mitar <mitar.docker@tnode.com>

EXPOSE 3306/tcp

RUN apt-get update -q -q && \
 apt-get install mysql-server --yes --force-yes && \
 mkdir -m 700 /var/lib/mysql.orig && \
 mv /var/lib/mysql/* /var/lib/mysql.orig/ && \
 sed -i 's/127\.0\.0\.1/0.0.0.0/' /etc/mysql/my.cnf && \
 apt-get install rsyslog --no-install-recommends --yes --force-yes && \
 sed -i 's/\/var\/log\/daemon/\/var\/log\/mysql\/daemon/' /etc/rsyslog.conf

COPY ./patches patches

RUN \
 apt-get install patch --yes --force-yes && \
 for patch in patches/*; do patch --prefix=./patches/ -p0 --force "--input=$patch" || exit 1; done && \
 rm -rf patches && \
 apt-get purge patch --yes --force-yes

COPY ./etc /etc
