# Postgres to S3 backup tools

This tool able to backup manually, backup automatically and restore postgres databases and store it into Amazon S3 storage. This tool works very good in docker-compose environment.

## What is inside

1. **Backup tool** - backup particular Postgre database and upload it to Amazon S3 storage

1. **Restore tool** - restore Postgre database from Amazon S3 url.

1. **Cron scheduler tool**. This package contains builtin [go-cron](https://github.com/odise/go-cron/) which interracts like ordinary cron but inside Docker container.

## Use with docker-compose

#### Create docker-compose file
You can use [docker-compose.sample.yml](https://github.com/ffedoroff/docker-postgres-s3-backup/blob/master/docker-compose.sample.yml) file as example. Please pay attention, that real postgres container should be called exactly `postgres`:
```
pgbackup:
  image: docker-postgres-s3-backup
  links:
    - postgres
  environment:
    - SCHEDULE=0 0 8 * * *
    - DBNAME=please-enter
    - AWS_S3_PATH=please-enter-path/to/your/bucket/
    - AWS_KEY=please-enter
    - AWS_SECERT=please-enter

postgres:
  image: postgres
  environment:
    - POSTGRES_PASSWORD=optional-value
    - POSTGRES_USER=optional-value
  volumes:
    - /var/lib/postgresql/data
```
On example above, tool will make automatic backup each day at 8am and upload it into S3 bucket. If you want to see real life example, please look on [docker-sentry](https://github.com/ffedoroff/docker-sentry) project.

#### Environment variables

`SCHEDULE` - is like linux cron syntax, but with seconds precise. (Second, Minute, Hour, Day_of_the_Month, Month_of_the_Year, Day_of_the_Week)

`DBNAME` - database name to backup

`AWS_S3_PATH` - path to your amazon S3 bucket, for example: my-amazon-bucket/

`AWS_KEY` - your Amazon API key

`AWS_SECERT` - your Amazon API Secret

`POSTGRES_PASSWORD` - your database userpassword

`POSTGRES_USER` - your database username

#### Backup database manually
You need to find docker container `pgbackup` full name or id using `docker ps` command.
It is usually called `dockersentry_pgbackup_1` Then run: 
```
docker exec -it dockersentry_pgbackup_1 ./cron-task.sh
```
And you will have proper database backup done, archived and uploaded to S3 storage.

#### Restore database
You need to find url of your database archive in S3 storage and make it temporary public.
For example your url is https://s3-us-west-1.amazonaws.com/your-bucket/sentry-20151110-021500.sql.gz
Then you need to find docker container `pgbackup` full name or id using `docker ps` command.
It is usually called `dockersentry_pgbackup_1` To restore database run: 
```
docker exec -it dockersentry_pgbackup_1 ./restore.sh https://s3-us-west-1.amazonaws.com/your-bucket/sentry-20151110-021500.sql.gz
```
