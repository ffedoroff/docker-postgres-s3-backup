#!/bin/bash
set -e

if [ "$1" = '/cron.sh' ]; then
    echo "starting go-cron with SCHEDULE=$SCHEDULE"
    go-cron "$SCHEDULE" /bin/bash backup-upload.sh
fi

exec "$@"
