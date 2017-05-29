## 0.1.0

Initial development release.

#### Notes

- Based off [tklx/base:stretch](https://github.com/tklx/base)
- Uses tini for zombie reaping and signal forwarding.
- Includes blockstack core and virtualchain (rc-0.14.2).
- Includes blockstack browser portal (v0.8).

- Includes ``EXPOSE 1337 3000 3001 6720``:

    - 1337: cors
    - 3000: browser portal
    - 3001: browsersync
    - 6720: core api

- Builds are automated via CircleCI:

    - Images tagged with ``latest`` are built from the master branch.
    - Images tagged with ``x.y.z`` refer to signed tagged releases.

