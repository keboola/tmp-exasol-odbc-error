<?php

declare(strict_types=1);

$host = 'yegtfzuvjfb3pddriy726zkfa4.clusters.exasol.com';
$user = 'DEV_ZAJCA_WORKSPACE_36625_USER';
$password = '';

$dsn = 'Driver=exasol;ENCODING=UTF-8;EXAHOST=' . $host;
$handle = odbc_connect($dsn, $user, $password);
