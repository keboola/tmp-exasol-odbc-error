```shell
docker build . -t exa_odbc
docker run exa_odbc

#UnixODBC
docker run \
-it \
--mount type=bind,source="$(pwd)"/exasol.ini,target=/etc/exasol.ini \
exa_odbc:latest

# fill exasol.ini file
# in container run
# this will work fine and connect to Exasol server
odbcinst -i -s -l -f /etc/exasol.ini
odbcinst -q -s -f /etc/exasol.ini
isql -v sass

#PHP
docker run \
-it \
--mount type=bind,source="$(pwd)"/connect.php,target=/tmp/connect.php \
exa_odbc:latest

# in container run
# fill connect.php file
# this will fail with  
# odbc_connect(): SQL error: [EXASOL][EXASolution driver]Failed to resolve hostname: 'y'., SQL state 08S01 in SQLConnect in /tmp/connect.php on line 10
php /tmp/connect.php
```

## License

MIT licensed, see [LICENSE](./LICENSE) file.
