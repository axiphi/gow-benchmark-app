FROM ghcr.io/games-on-whales/base-app:edge

RUN <<'EOF'
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
    sudo \
    vulkan-tools \
    mesa-utils \
    unzip \
    libdrm-dev \
    libgbm-dev \
    libglm-dev \
    libassimp-dev \
    libwayland-dev \
    wayland-protocols \
    build-essential \
    autoconf \
    meson \
    xorg-dev \
    libsdl1.2-dev \
    libsdl-gfx1.2-dev \
    libsdl-net1.2-dev \
    libsdl-image1.2-dev \
    libsdl-ttf2.0-dev \
    libsdl-mixer1.2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    apt-file

wget -O /tmp/phoronix.deb https://github.com/phoronix-test-suite/phoronix-test-suite/releases/download/v10.8.4/phoronix-test-suite_10.8.4_all.deb
dpkg -i /tmp/phoronix.deb
rm /tmp/phoronix.deb
apt-get install -y --no-install-recommends --fix-broken

apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
EOF

COPY --chmod=777 wolf-graphics-suite.xml /opt/gow/suite-definition.xml

COPY --chmod=777 make-sudoer.sh /etc/cont-init.d/20-make-sudoer.sh
COPY --chmod=777 setup-phoronix.sh /etc/cont-init.d/30-setup-phoronix.sh

COPY --chmod=0777 --chown=0:0 sway.config /cfg/sway/config

COPY --chmod=0777 <<'EOF' /opt/gow/startup-app.sh
#!/bin/bash
set -e

source /opt/gow/launch-comp.sh
launcher /usr/bin/kitty
EOF

ENV XDG_RUNTIME_DIR=/tmp/.X11-unix

LABEL org.opencontainers.image.source=https://github.com/axiphi/gow-benchmark-app
