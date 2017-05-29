FROM tklx/base:stretch

ENV TINI_VERSION=v0.14.0
ENV TINI_HASH=eeffbe853a15982e85d923390d3a0c4c5bcf9c78635f4ddae207792fa4d7b5e6
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN set -x \
    && echo -n "${TINI_HASH}  /tini" | sha256sum --strict --check - \
    && chmod +x /tini

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
