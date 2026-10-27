FROM registry.gitlab.com/tozd/docker/dinit:ubuntu-jammy

EXPOSE 3306/tcp

ENV MYSQL_DATA_CHOWN=
ENV DINIT_JSON_STDOUT=0

VOLUME /var/log/mysql
VOLUME /var/lib/mysql

RUN apt-get update -q -q && \
  apt-get install --yes --force-yes mariadb-server && \
  mkdir -m 700 /var/lib/mysql.orig && \
  mv /var/lib/mysql/* /var/lib/mysql.orig/ && \
  rm -f /etc/mysql/mariadb.conf.d/50-mysqld_safe.cnf && \
  apt-get autoremove --yes --force-yes && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc /etc
