#!/bin/sh

HCKS_DB="${HCKS_DB:-sqlite}"; export HCKS_DB
HCKS_DB_NAME="${HCKS_DB_NAME:-/data/hc.sqlite}"; export HCKS_DB_NAME

env | grep -Ee '^HCKS_[A-Za-z0-9_]+=.*$' | while IFS= read -r env; do
    env_key=`printf "%s" "${env}" | sed -Ee 's/^HCKS_([A-Za-z0-9_]+)=.*$/\1/'`
    env_value=`printf "%s" "${env}" | cut -s -d "=" -f2-`

    printf "env = %s=%s\n" "${env_key}" "${env_value}"
done >> "/uwsgi.ini" || exit $?
