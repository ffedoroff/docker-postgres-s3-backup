FROM postgres:9.4.5

RUN apt-get update -y && apt-get install -y s3cmd curl

COPY backup-db.sh /
COPY backup-upload.sh /
COPY s3cfg /.s3cfg
COPY s3setup.sh /
COPY restore.sh /
COPY docker-entrypoint.sh /

# Folders for s3cmd optionations
RUN mkdir /opt/src
RUN mkdir /opt/dest

RUN curl -L https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron && chmod u+x /usr/local/bin/go-cron

WORKDIR /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/cron.sh"]

