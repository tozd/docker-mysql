# tozd/mysql

<https://gitlab.com/tozd/docker/mysql>

Available as:

- [`tozd/mysql`](https://hub.docker.com/r/tozd/mysql)
- [`registry.gitlab.com/tozd/docker/mysql`](https://gitlab.com/tozd/docker/mysql/container_registry)

## Image inheritance

[`tozd/base`](https://gitlab.com/tozd/docker/base) ← [`tozd/runit`](https://gitlab.com/tozd/docker/runit) ← `tozd/mysql`

## Tags

- `5.5`: MariaDB 5.5
- `10.0`: MariaDB 10.0
- `10.1`: MariaDB 10.1
- `10.3`: MariaDB 10.3
- `10.6`: MariaDB 10.6

## Volumes

- `/var/log/mysql`: Log files.
- `/var/lib/mysql`: Persist this volume to not lose state.

## Variables

- `MYSQL_DATA_CHOWN`: If set, then container will on startup change ownership of all files in `/var/lib/mysql` to MySQL. Use if you copied data into the volume from elsewhere.

## Ports

- `3306/tcp`: Port on which MySQL listens.

## Description

Image providing [MySQL (MariaDB fork)](https://mariadb.org/) as a service.

Different Docker tags provide different MySQL versions.

You should make sure you mount data volume (`/var/lib/mysql`) so that you do not
lose database data when you are recreating a container. If a volume is empty, image
will initialize it at the first startup.

The intended use of this image is that it is shared between multiple other services
and that you create databases and users accordingly.

After first run, you can connect to the MySQL as an administrator from the inside
the container, for example, for a container named `mysql`:

```
$ docker exec -t -i mysql /bin/bash
$ mysql -u root
```

You should set MySQL root user's password as soon as possible:

```
$ mysqladmin -u root password '<PASSWORD>'
```

After that you can connect to the MySQL using:

```
$ mysql -u root -p
```

You can create database:

```
> CREATE DATABASE <DBNAME>
```

You can create users:

```
> GRANT ALL PRIVILEGES ON <DBNAME>.* TO '<USERNAME>'@'%' IDENTIFIED BY '<PASSWORD>'
```
