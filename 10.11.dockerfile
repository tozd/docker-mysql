FROM registry.gitlab.com/tozd/docker/dinit:ubuntu-noble

EXPOSE 3306/tcp

ENV MYSQL_DATA_CHOWN=
ENV DINIT_JSON_STDOUT=0

VOLUME /var/log/mysql
VOLUME /var/lib/mysql

COPY ./patches-10.6 patches

RUN apt-get update -q -q && \
  apt-get install --yes --force-yes mariadb-server && \
  mkdir -m 700 /var/lib/mysql.orig && \
  mv /var/lib/mysql/* /var/lib/mysql.orig/ && \
  rm -f /etc/mysql/mariadb.conf.d/50-mysqld_safe.cnf && \
  apt-get install patch --yes --force-yes && \
  for patch in patches/*; do patch --prefix=./patches/ -p0 --force "--input=$patch" || exit 1; done && \
  rm -rf patches && \
  apt-get purge patch --yes --force-yes && \
  apt-get autoremove --yes --force-yes && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc/mysql/conf.d/local.cnf /etc/mysql/conf.d/local.cnf
COPY ./etc/mysql/mariadb.conf.d/local.cnf /etc/mysql/mariadb.conf.d/local.cnf
COPY ./etc/service/mysql /etc/service/mysql
