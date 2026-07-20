# Healthchecks

Healthchecks is a cron job monitoring service. It listens for HTTP requests and email messages ("pings") from your cron jobs and scheduled tasks ("checks"). When a ping does not arrive on time, Healthchecks sends out alerts.

healthchecks.io

<img src="https://raw.githubusercontent.com/healthchecks/healthchecks/refs/heads/master/static/img/favicon.svg" width="30%" height="auto" alt="Healthchecks logo">

## How to use this Makejail

```console
$ mkdir -p /var/appjail-volumes/hcks/data
$ appjail oci run -Pd \
    -o fstab="/var/appjail-volumes/hcks/data /data" \
    -o overwrite=force \
    -o virtualnet=":<random> default" \
    -o nat \
    -e DEBUG=False \
    -e ALLOWED_HOSTS=healthchecks \
    -e SITE_ROOT=http://healthchecks \
    -e SITE_NAME=healthchecks \
    -e APPRISE_ENABLED=True \
    -e DEFAULT_FROM_EMAIL=hcks@example.org \
    -e SECRET_KEY=mysecretkey \
    -e EMAIL_HOST=example.org \
    -e EMAIL_HOST_PASSWORD=123 \
    -e EMAIL_HOST_USER=hcks \
    -e EMAIL_PORT=1025 \
    -e EMAIL_USE_TLS=False \
    -e EMAIL_USE_VERIFICATION=False \
    ghcr.io/appjail-makejails/healthchecks healthchecks
```

### Arguments (stage: build)

* `healthchecks_from` (default: `ghcr.io/appjail-makejails/healthchecks`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `healthchecks_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).

### Environment (OCI image)

* `PGID` (default: `1000`): Equivalent to `PUID` but for the Process Group ID.
* `PUID` (default: `1000`): Process User ID for the container's main process, allowing you to match the owner of files written to mounted host volumes to your host system's user. Writable volumes are changed based on this environment variable.

### Volumes

| Name | Owner | Group | Perm | Type | Mountpoint |
| --- | --- | --- | --- | --- | --- |
| appjail-263aca83a3-data | `${PUID}` | `${PGID}` | - | - | /data |

## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.1
      containerfile: Containerfile
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.1"
        PYVER: "312"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
```
