FROM php:7.4-cli-buster as dev
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q \
    && ACCEPT_EULA=Y apt-get install \
        unixodbc \
        unixodbc-dev \
        -y --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

# Exasol
RUN set -ex; \
    mkdir -p /tmp/exasol/odbc /opt/exasol ;\
    curl https://www.exasol.com/support/secure/attachment/206420/EXASOL_ODBC-7.1.10.tar.gz --output /tmp/exasol/odbc.tar.gz; \
    tar -xzf /tmp/exasol/odbc.tar.gz -C /tmp/exasol/odbc --strip-components 1; \
    cp /tmp/exasol/odbc/lib/linux/x86_64/libexaodbc-uo2214lv2.so /opt/exasol/;\
    echo "\n[exasol]\nDriver=/opt/exasol/libexaodbc-uo2214lv2.so\n" >> /etc/odbcinst.ini; \
    rm -rf /tmp/exasol;

# PHP modules
RUN set -ex; \
	docker-php-source extract; \
	{ \
		echo '# https://github.com/docker-library/php/issues/103#issuecomment-271413933'; \
		echo 'AC_DEFUN([PHP_ALWAYS_SHARED],[])dnl'; \
		echo; \
		cat /usr/src/php/ext/odbc/config.m4; \
	} > temp.m4; \
	mv temp.m4 /usr/src/php/ext/odbc/config.m4; \
	docker-php-ext-configure odbc --with-unixODBC=shared,/usr; \
	docker-php-ext-install odbc; \
	docker-php-source delete


ENTRYPOINT ["/bin/bash"]
