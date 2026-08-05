# SH1MMER Wax Docker Image

Fully self-contained Docker image for the [MercuryWorkshop/sh1mmer](https://github.com/MercuryWorkshop/sh1mmer) `wax` tooling.

This image includes everything needed for normal SH1MMER injection, legacy payloads, Chromebrew/Devshim builds, and Br0ker-style update payloads.

The container runs `wax/wax.sh` by default and modifies the provided shim **in place**.

> **Warning**: The operation is destructive. Always keep a clean backup of your original RMA shim.

---

## Supported Boards

Including **grunt**:

```
ambassador, banon, brask, brya, clapper, coral, corsola, cyan, dedede,
edgar, elm, enguarde, fizz, glimmer, grunt, hana, hatch, jacuzzi,
kalista, kefka, kukui, lulu, nami, nissa, octopus, orco, puff, pyro,
reef, reks, relm, sand, sentry, snappy, stout, strongbad, tidus,
trogdor, ultima, volteer, zork
```

---

## Quick Start

### Basic Beautiful World shim (recommended for most users)

```bash
docker run --rm --privileged \
  -v /path/to/your/shim/folder:/data \
  ghcr.io/mcMineyC/sh1mmer-waxer-docker:latest \
  -i /data/your_rma_shim.bin
```

### Legacy payload (for advanced users, but easier to update)

```bash
docker run --rm --privileged \
  -v /path/to/your/shim/folder:/data \
  ghcr.io/mcMineyC/sh1mmer-waxer-docker:latest \
  -i /data/your_rma_shim.bin -p legacy
```

### Chromebrew / Devshim

A Chromebrew tarball can be obtained via the below command:

```bash
wget "https://web.archive.org/web/20230324140756id_/https://dl.sh1mmer.me/build-tools/chromebrew/chromebrew.tar.gz"
```

And for a dev tarball:

```bash
wget "https://web.archive.org/web/20230324140756id_/https://dl.sh1mmer.me/build-tools/chromebrew/chromebrew-dev.tar.gz"
```

Place the downloaded tarball in the same folder as your shim, then run:

**Normal Chromebrew** (`-s 4G`):

```bash
docker run --rm --privileged \
  -v /path/to/your/shim/folder:/data \
  ghcr.io/mcMineyC/sh1mmer-waxer-docker:latest \
  -i /data/your_rma_shim.bin \
  --chromebrew /data/chromebrew.tar.gz \
  -s 4G
```

**Devshim** (`-s 7G`):

```bash
docker run --rm --privileged \
  -v /path/to/your/shim/folder:/data \
  ghcr.io/mcMineyC/sh1mmer-waxer-docker:latest \
  -i /data/your_rma_shim.bin \
  --chromebrew /data/chromebrew-dev.tar.gz \
  -s 7G
```

### Other useful flags

| Flag | Description |
|------|-------------|
| `-i <path>` | Path to the RMA shim (required) |
| `-p bw\|legacy` | Main payload (default: `bw`) |
| `-s SIZE` | SH1MMER partition size |
| `--chromebrew <tar.gz>` | Include Chromebrew |
| `-d` | Enable debug output |
| `--fast` | Skip shrink/squash (larger image) |

All flags are passed directly to `wax.sh`.

## Building Locally

If you prefer to build the image yourself instead of pulling from GHCR:

```bash
git clone https://github.com/mcMineyC/sh1mmer-waxer-docker.git
cd sh1mmer-waxer-docker
docker build -t sh1mmer-wax .
```

Then run it the same way, replacing the image name:

```bash
docker run --rm --privileged \
  -v /path/to/your/shim/folder:/data \
  sh1mmer-wax -i /data/your_rma_shim.bin
```

---

## Notes

- Only genuine **raw RMA factory shims** work. Recovery images from cros.download will fail.
- Always use `--privileged` (loop devices are required).
- The finished SH1MMER image appears in the same directory you mounted.
- Image is based on Debian Bookworm + the `beautifulworld` branch of sh1mmer.
- All credit for this tool goes to MercuryWorkshop, I just poorly wrapped their scripts in a Docker container

---

## Credits

Original project: [MercuryWorkshop/sh1mmer](https://github.com/MercuryWorkshop/sh1mmer)  
Wax tooling by CoolElectronics, Sharp_Jack, r58playz, Rafflesia, OlyB and contributors.
