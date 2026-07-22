ARG FREEBSD_RELEASE

FROM ghcr.io/appjail-makejails/core:${FREEBSD_RELEASE}

ARG PYVER
ARG NO_PKGCLEAN

LABEL org.opencontainers.image.title="Healthchecks" \
    org.opencontainers.image.description="Open-source cron job and background task monitoring service" \
    org.opencontainers.image.source="https://github.com/AppJail-makejails/healthchecks" \
    org.opencontainers.image.url="https://github.com/AppJail-makejails/healthchecks" \
    org.opencontainers.image.vendor="DtxdF" \
    org.opencontainers.image.authors="Jesús Daniel Colmenares Oviedo <dtxdf@disroot.org>"

RUN set -xe; \
    \
    pkg update; \
    pkg install -U py${PYVER}-healthchecks uwsgi-py${PYVER}; \
    \
    if [ -z "${NO_PKGCLEAN}" ]; then \
        pkg clean -a; \
        rm -rf /var/cache/pkg/*; \
    fi; \
    rm -rf /var/db/pkg/repos/*

ENV DB_NAME=/data/hc.sqlite
ENV USE_GZIP_MIDDLEWARE=True

COPY entrypoint.sh uwsgi.ini /

RUN chmod +x /entrypoint.sh && \
    mkdir -p /data

VOLUME ["/data"]

CMD ["/entrypoint.sh"]
