FROM mysql:8.0

ARG MYSQL_DATABASE
ENV MYSQL_DATABASE=$MYSQL_DATABASE

VOLUME ./docker/mysql/startup:/docker-entrypoint-initdb.d/
VOLUME mysql-data:/var/lib/mysql
