#!/bin/sh

set -e

usermod -a -G sudo "${UNAME}"
echo 'retro:retro' | chpasswd
