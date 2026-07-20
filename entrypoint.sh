#!/bin/sh

. /lib.subr

set -e

create_user

chown noroot:noroot /var/db/healthchecks
chown -R noroot:noroot /data

exec su-exec noroot uwsgi /uwsgi.ini
