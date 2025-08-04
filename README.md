# Healthchecks

Healthchecks is a cron job monitoring service. It listens for HTTP requests and email messages ("pings") from your cron jobs and scheduled tasks ("checks"). When a ping does not arrive on time, Healthchecks sends out alerts.

healthchecks.io

<img src="https://raw.githubusercontent.com/healthchecks/healthchecks/refs/heads/master/static/img/favicon.svg" alt="healthchecks logo" width="30%" height="auto">

## How to use this Makejail

```sh
appjail makejail \
    -j healthchecks \
    -f gh+AppJail-makejails/healthchecks \
    -o virtualnet=":<random> default" \
    -o nat \
    -o expose=8823 \
    -V HCKS_DEBUG=False \
    -V HCKS_SITE_ROOT=http://healthchecks \
    -V HCKS_SITE_NAME=healthchecks \
    -V HCKS_APPRISE_ENABLED=True \
    -V HCKS_DEFAULT_FROM_EMAIL=hcks@example.org \
    -V HCKS_SECRET_KEY=mysecretkey \
    -V HCKS_EMAIL_HOST=example.org \
    -V HCKS_EMAIL_HOST_PASSWORD=123 \
    -V HCKS_EMAIL_HOST_USER=hcks \
    -V HCKS_EMAIL_PORT=1025 \
    -V HCKS_EMAIL_USE_TLS=False \
    -V HCKS_EMAIL_USE_VERIFICATION=False
```

### Arguments

* `healthchecks_ajspec` (default: `gh+AppJail-makejails/healthchecks`): Entry point where the `appjail-ajspec(5)` file is located.
* `healthchecks_tag` (default: `13.5`): see [#tags](#tags).
* `healthchecks_uwsgi` (default: `files/uwsgi.ini`): File configuration for uWSGI.
* `healthchecks_http_socket` (default: `0.0.0.0:8823`): Value of `http-socket` option.

### Volumes

| Name            | Owner | Group | Perm | Type | Mountpoint |
| --------------- | ----- | ----- | ---- | ---- | ---------- |
| hcks-data       | 790   | 790   | -    | -    | /data      |

**Note**: The `hcks-data` volume is only necessary if you use SQLite as your database engine (which is the default).

## Tags

| Tag        | Arch     | Version            | Type   |
| ---------- | -------- | ------------------ | ------ |
| `13.5` | `amd64`  | `13.5-RELEASE` | `thin` |
| `14.3` | `amd64`  | `14.3-RELEASE` | `thin` |
