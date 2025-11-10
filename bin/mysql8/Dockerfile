FROM mysql:8.0

RUN echo "[mysqld]" >> /etc/mysql/conf.d/my.cnf
RUN echo "sql_mode = STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/conf.d/my.cnf
RUN echo "default-authentication-plugin=mysql_native_password" >> /etc/mysql/conf.d/my.cnf
RUN echo "character-set-server=utf8mb4" >> /etc/mysql/conf.d/my.cnf
RUN echo "collation-server=utf8mb4_unicode_ci" >> /etc/mysql/conf.d/my.cnf
RUN echo "disable_log_bin=1" >> /etc/mysql/conf.d/my.cnf
