#!/bin/bash
set -e

fname="$DBNAME-$(date +%Y%m%d-%H%M%S).sql.gz"
dname="/data/"
rm -rf "$dname"
mkdir -p "$dname"

/bin/bash backup-db.sh "$dname$fname"

/bin/bash s3setup.sh
cd "$dname"
/usr/bin/s3cmd put --rr "$fname" s3://$AWS_S3_PATH$fname

cd /
rm -rf "$dname"
