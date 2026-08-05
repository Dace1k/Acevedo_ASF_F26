FROM postgres:latest

ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=secret
ENV POSTGRES_DB=sql_docker

COPY init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 5432