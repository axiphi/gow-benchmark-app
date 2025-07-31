#!/bin/sh

set -e

su - "${UNAME}" -c "phoronix-test-suite user-config-reset"
mkdir -p "/home/${UNAME}/.phoronix-test-suite/test-suites/local/wolf-graphics"
cp /opt/gow/suite-definition.xml "/home/${UNAME}/.phoronix-test-suite/test-suites/local/wolf-graphics/suite-definition.xml"
chown -R "${UNAME}:${UNAME}" "/home/${UNAME}/.phoronix-test-suite"
