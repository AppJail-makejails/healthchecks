#!/bin/sh

. /lib.subr

set -e

create_user

chown noroot:noroot /var/db/healthchecks
change_owner /data

exec su-exec noroot uwsgi /uwsgi.ini
