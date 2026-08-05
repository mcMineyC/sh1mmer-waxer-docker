# SH1MMER Wax Docker Image

Dockerized version of the [MercuryWorkshop/sh1mmer](https://github.com/MercuryWorkshop/sh1mmer) `wax` tooling.  
This lets you inject SH1MMER payloads into a raw RMA factory shim without installing the dependencies on your host system.

The container runs `wax/wax.sh` and modifies the provided shim **in place**.

> **Warning**: The operation is destructive. Always keep a clean backup of your original RMA shim.

---

## Supported Boards

`grunt` (and all other boards listed in the upstream README) are supported:

```
ambassador, banon, brask, brya, clapper, coral, corsola, cyan, dedede,
edgar, elm, enguarde, fizz, glimmer, grunt, hana, hatch, jacuzzi,
kalista, kefka, kukui, lulu, nami, nissa, octopus, orco, puff, pyro,
reef, reks, relm, sand, sentry, snappy, stout, strongbad, tidus,
trogdor, ultima, volteer, zork
```

---

## Build

```bash
docker build -t sh1mmer-wax .
```

---

## Usage

Mount a directory that contains your raw RMA shim, then run the container with `--privileged` (required for loop devices).

### Basic Beautiful World shim

```bash
docker run --rm --privileged \
  -v /path/to/your/shim/folder:/data \
  sh1mmer-wax -i /data/your_rma_shim.bin
```

### Legacy payload

```bash
docker run --rm --privileged \
  -v /path/to/your/shim/folder:/data \
  sh1mmer-wax -i /data/your_rma_shim.bin -p legacy
```

### Dev-shim style (larger Chromebrew + desktop environment)

A Chromebrew tarball can be obtained via the below command:

```bash
wget "https://web.archive.org/web/20230324140756id_/https://dl.sh1mmer.me/build-tools/chromebrew/chromebrew.tar.gz"
```

And for a dev tarball:

```bash
wget "https://web.archive.org/web/20230324140756id_/https://dl.sh1mmer.me/build-tools/chromebrew/chromebrew-dev.tar.gz"
```


Place `chromebrew-dev.tar.gz` (or `chromebrew.tar.gz`) in the same folder as the shim:

```bash
docker run --rm --privileged \
  -v /path/to/your/shim/folder:/data \
  sh1mmer-wax \
    -i /data/your_rma_shim.bin \
    --chromebrew /data/chromebrew-dev.tar.gz \
    -s 7G
```

### Other useful flags

| Flag | Description |
|------|-------------|
| `-i <path>` | Path to the RMA shim (required) |
| `-p bw\|legacy` | Main payload (default: `bw`) |
| `-s SIZE` | SH1MMER partition size (default `72M`) |
| `--chromebrew <tar.gz>` | Include Chromebrew (use `-s 4G` for normal, or `-s 7G` for dev) |
| `-d` | Enable debug output |
| `--fast` | Skip shrink/squash (larger image) |

All flags are passed directly to `wax.sh`.

---

## Notes

- Only genuine **raw RMA factory shims** work. Recovery images from cros.download will fail.
- The shim is modified in place. The finished SH1MMER image will appear in the same directory you mounted.
- On some hosts you may need additional `--device` flags for loop devices, but `--privileged` is usually sufficient.
- For Br0ker-style update payloads you will need extra packages and to run `update_downloader.sh` first.

---

## Credits

Original project: [MercuryWorkshop/sh1mmer](https://github.com/MercuryWorkshop/sh1mmer)  
Wax tooling by CoolElectronics, Sharp_Jack, r58playz, Rafflesia, OlyB and contributors.
