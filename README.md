# tozd/mysql

<https://gitlab.com/tozd/docker/mysql>

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
