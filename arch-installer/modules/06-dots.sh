#!/usr/bin/env bash
set -e

su - $USERNAME -c "
git clone $DOTS_URL ~/dots &&
cd ~/dots &&
chmod +x install.sh &&
./install.sh
"
