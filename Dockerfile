FROM tklx/base:stretch

ENV TINI_VERSION=v0.14.0
ENV TINI_HASH=eeffbe853a15982e85d923390d3a0c4c5bcf9c78635f4ddae207792fa4d7b5e6
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN set -x \
    && echo -n "${TINI_HASH}  /tini" | sha256sum --strict --check - \
    && chmod +x /tini

ENV BLOCKSTACK_CORE_VERSION=rc-0.14.2
ENV VIRTUALCHAIN_VERSION=rc-0.14.2
RUN set -x \
    && apt-get update \
    && apt-get -y install build-essential git libssl-dev libffi-dev python-pip python-dev rng-tools \
    && pip install virtualenv \
    && mkdir /blockstack \
    && virtualenv --python=python2.7 /blockstack/core \
    && /blockstack/core/bin/python -m pip install git+https://github.com/blockstack/virtualchain.git@${VIRTUALCHAIN_VERSION} \
    && /blockstack/core/bin/python -m pip install git+https://github.com/blockstack/blockstack-core.git@${BLOCKSTACK_CORE_VERSION} \
    && apt-get purge -y --auto-remove build-essential \
    && apt-clean --aggressive

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
