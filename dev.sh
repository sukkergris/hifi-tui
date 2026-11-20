#!/usr/bin/env bash
# Developer install: copy the local bin/hifi (incl. uncommitted changes) over the installed one.
# ./install.sh puts the packaged version from GitHub back.
set -euo pipefail
cd "$(dirname "$0")"
sudo install -vDm755 bin/hifi /usr/bin/hifi
