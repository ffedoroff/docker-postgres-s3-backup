# Postgres to S3 backup tools

## What is inside

1. **Backup tool**. You are able to backup particular Postgre database and upload it to Amazon S3 storage

1. **Restore tool**. You are able to restore Postgre database from Amazon S3 url.

4. **Cron scedduler tool**. This package contains builtin `go-cron` which interracts like ordinary cron
but in Docker container.

## How to use

### clone repository

```
git clone https://github.com/ffedoroff/docker-postgres-s3-backup.git
```

Update parameters

## Backup database manually
You need to find docker container `pgbackup` full name or id using `docker ps` command.
It is usually called `dockersentry_pgbackup_1` Then run: 
```
docker exec -it dockersentry_pgbackup_1 ./cron-task.sh
```
And you will have proper database backup done, archived and uploaded to S3 storage.

## Restore database
You need to find url of your database archive in S3 storage and make it temporary public.
For example your url is https://s3-us-west-1.amazonaws.com/your-bucket/sentry-20151110-021500.sql.gz
Then you need to find docker container `pgbackup` full name or id using `docker ps` command.
It is usually called `dockersentry_pgbackup_1` To restore database run: 
```
docker exec -it dockersentry_pgbackup_1 ./restore.sh https://s3-us-west-1.amazonaws.com/your-bucket/sentry-20151110-021500.sql.gz
```
