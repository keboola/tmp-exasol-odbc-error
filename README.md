```shell
docker build . -t exa_odbc
docker run exa_odbc

#UnixODBC
docker run \
-it \
--mount type=bind,source="$(pwd)"/exasol.ini,target=/etc/exasol.ini \
exa_odbc:latest

# in container run
odbcinst -i -s -l -f /etc/exasol.ini
odbcinst -q -s -f /etc/exasol.ini
isql -v sass

#PHP
docker run \
-it \
--mount type=bind,source="$(pwd)"/connect.php,target=/tmp/connect.php \
exa_odbc:latest

# in container run
php /tmp/connect.php
```
