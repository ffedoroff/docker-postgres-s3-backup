#!/bin/bash
set -e

if [ "$1" = '/cron.sh' ]; then
    echo "starting go-cron with SCHEDULE=$SCHEDULE"
    go-cron "$SCHEDULE" /bin/bash cron-task.sh
fi

exec "$@"
