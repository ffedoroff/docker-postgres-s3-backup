#!/bin/bash
set -e

dname="/data/"
rm -rf "$dname"
mkdir "$dname"
curl "$1" | zcat > "${dname}restore-me.sql"

PGHOST="$POSTGRES_PORT_5432_TCP_ADDR" \
PGPORT="$POSTGRES_PORT_5432_TCP_PORT" \
PGUSER="$POSTGRES_ENV_POSTGRES_USER" \
PGPASSWORD="$POSTGRES_ENV_POSTGRES_PASSWORD" \
pg_restore -Fc --no-owner --dbname "$DBNAME" -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -w "${dname}restore-me.sql"

# rm -rf "$dname"
