#!/usr/bin/env bash
set -e

cd ..

docker exec default-mysql8-backup mysql --defaults-file=/root/.my.cnf -N -e "SHOW DATABASES" \
| grep -Ev "^(information_schema|performance_schema|mysql|sys)$" | while read -r db; do  \
docker exec default-mysql8-backup       mysqldump --defaults-file=/root/.my.cnf  --single-transaction --quick \
--no-tablespaces         "$db"       | gzip > "./backups/$db.sql.gz";   done

