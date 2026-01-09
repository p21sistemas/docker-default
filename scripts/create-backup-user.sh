#!/usr/bin/env bash
set -e

docker exec -i default-mysql8 \
  mysql --defaults-file=/root/.my.root.cnf -u root <<'SQL'
CREATE USER IF NOT EXISTS 'backup'@'%'
IDENTIFIED BY 'backup';

GRANT SELECT, LOCK TABLES, SHOW VIEW, EVENT, TRIGGER
ON *.* TO 'backup'@'%';

FLUSH PRIVILEGES;
SQL
