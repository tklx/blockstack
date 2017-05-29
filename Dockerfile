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
    && apt-get -y install build-essential git libssl-dev libffi-dev python-pip python-dev rng-tools lsof \
    && pip install virtualenv \
    && mkdir /blockstack \
    && virtualenv --python=python2.7 /blockstack/core \
    && /blockstack/core/bin/python -m pip install git+https://github.com/blockstack/virtualchain.git@${VIRTUALCHAIN_VERSION} \
    && /blockstack/core/bin/python -m pip install git+https://github.com/blockstack/blockstack-core.git@${BLOCKSTACK_CORE_VERSION} \
    && rm -rf /root/.cache/pip \
    && apt-get purge -y --auto-remove build-essential \
    && apt-clean --aggressive

ENV NODE_MAJOR_VERSION=7
ENV BLOCKSTACK_PORTAL_VERSION=v0.8
RUN set -x \
    && apt-get update \
    && apt-get -y install gnupg curl ca-certificates apt-transport-https lsb-release \
    && curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x | bash - \
    && apt-get -y install nodejs \
    && rm /etc/apt/sources.list.d/nodesource.list \
    && git clone https://github.com/blockstack/blockstack-portal.git -b${BLOCKSTACK_PORTAL_VERSION} /blockstack/portal \
    && cd /blockstack/portal \
    && npm install node-sass \
    && npm install \
    && npm cache clean \
    && apt-get purge -y --auto-remove gnupg curl ca-certificates apt-transport-https lsb-release \
    && apt-clean --aggressive

EXPOSE 1337 3000 3001 6270
ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
