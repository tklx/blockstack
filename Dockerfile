FROM tklx/base:stretch

ENV TINI_VERSION=v0.14.0
RUN set -x \
    && TINI_URL=https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini \
    && TINI_GPGKEY=595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
    && export GNUPGHOME="$(mktemp -d)" \
    && apt-get update \
    && apt-get -y install gnupg dirmngr wget ca-certificates \
    && wget -O /tini ${TINI_URL} \
    && wget -O /tini.asc ${TINI_URL}.asc \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys ${TINI_GPGKEY} \
    && gpg --verify /tini.asc \
    && chmod +x /tini \
    && rm -rf ${GNUPGHOME} /tini.asc \
    && apt-get purge -y --auto-remove gnupg dirmngr wget ca-certificates \
    && apt-clean --aggressive

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
