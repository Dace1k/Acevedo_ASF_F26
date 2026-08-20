FROM postgres:15
ENV POSTGRES_DB=neon_logs_db
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=password

COPY 2026-08-19_created_security_logs_raw_table.sql /docker-entrypoint-initdb.d/
EXPOSE 5432


