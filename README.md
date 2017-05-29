# tklx/blockstack - A New Internet for Decentralized Apps
[![CircleCI](https://circleci.com/gh/tklx/blockstack.svg?style=shield)](https://circleci.com/gh/tklx/blockstack)

[Blockstack][blockstack] is a new decentralized internet where users own
their data and apps run locally.

This is a developer preview.

## Features

- Based on the super slim [tklx/base][base] (Debian GNU/Linux).
- Uses [tini][tini] for zombie reaping and signal forwarding.
- Includes blockstack core, virtualchain and the browser portal. We will most
  likely split the different components into different containers in the
  future, and provide documentation/wrapper scripts for container linking.

## Usage

Pull the blockstack container and run it, dropping to a shell

```console
docker pull tklx/blockstack
docker run --rm -it \
    -p 127.0.0.1:1337:1337 \
    -p 127.0.0.1:3000:3000 \
    -p 127.0.0.1:6270:6270 \
    tklx/blockstack /bin/bash
```

In the shell, setup blockstack core and start the api

```console
source /blockstack/core/bin/activate
BITCOIN_WALLET_PASSWORD=$(mcookie)
blockstack setup -y --password "$BITCOIN_WALLET_PASSWORD"
sed -i "s/localhost/0.0.0.0/" ~/.blockstack/client.ini
blockstack api start -y --password "$BITCOIN_WALLET_PASSWORD" --debug
```

Take note of your wallet and api passwords

```console
echo $BITCOIN_WALLET_PASSWORD
grep api_password ~/.blockstack/client.ini | sed 's/api_password = //g'
```

Start the cors proxy and browser portal

```console
cd /blockstack/portal
CORSPROXY_HOST=0.0.0.0 npm run dev-proxy &
npm run dev
```

Browse to http://localhost:3000 (the portal). You'll need to enter the api
password you took note of above.

Tip: setup a [protocol-handler][protocol-handler]


## Automated builds

The [Docker image](https://hub.docker.com/r/tklx/blockstack/) is built,
and pushed by [CircleCI](https://circleci.com/gh/tklx/blockstack) from source hosted on [GitHub](https://github.com/tklx/blockstack).

* Tag: ``x.y.z`` refers to a [release](https://github.com/tklx/blockstack/releases) (recommended).
* Tag: ``latest`` refers to the master branch.

## Issue Tracker

TKLX uses a central [issue tracker][tracker] on GitHub for reporting and
tracking of bugs, issues and feature requests.


[blockstack]: https://blockstack.org/
[base]: https://github.com/tklx/base
[tini]: https://github.com/krallin/tini
[protocol-handler]: https://github.com/blockstack/blockstack-core/blob/rc-0.14.2/docs/setup_core_portal.md#setting-up-a-protocol-handler
[tracker]: https://github.com/tklx/tracker/issues

