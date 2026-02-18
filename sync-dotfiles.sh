#!/usr/bin/env bash
set -e

MODE="push"
if [ "$1" == "--pull" ]; then
    MODE="pull"
fi

echo "Modo de sincronización: $MODE"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null || echo "$SCRIPT_DIR")"

export MODE REPO_ROOT

# Cargar módulos
source "$REPO_ROOT/install/01-detect-hardware.sh"
source "$REPO_ROOT/install/02-paths.sh"
source "$REPO_ROOT/install/03-quickshell-profile.sh"
source "$REPO_ROOT/install/04-sync-core.sh"
source "$REPO_ROOT/install/05-sync-extras.sh"

detect_hardware
setup_paths

if [ "$MODE" == "pull" ]; then
    SRC_CONFIG="$TARGET"
    DST_CONFIG="$SOURCE"
else
    SRC_CONFIG="$SOURCE"
    DST_CONFIG="$TARGET"
fi

handle_quickshell_profile
run_sync

echo "Sincronización completa"
