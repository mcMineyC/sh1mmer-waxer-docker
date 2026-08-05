FROM debian:bookworm-slim

# Install runtime dependencies for wax.sh
RUN apt-get update && apt-get install -y --no-install-recommends \
        bash \
        util-linux \
        gdisk \
        e2fsprogs \
        file \
        coreutils \
        pv \
        tar \
        git \
        wget \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Clone the repo (beautifulworld is the current default branch)
WORKDIR /opt/sh1mmer
RUN git clone --depth 1 --branch beautifulworld https://github.com/MercuryWorkshop/sh1mmer.git .

WORKDIR /opt/sh1mmer/wax

# Ensure bundled binaries are executable
RUN chmod +x wax.sh \
    && find lib/bin -type f -exec chmod +x {} + || true

# Pass all arguments straight through to wax.sh
ENTRYPOINT ["bash", "wax.sh"]
