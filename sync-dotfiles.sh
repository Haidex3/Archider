#!/usr/bin/env bash
set -e

MODE="push"
if [ "$1" == "--pull" ]; then
    MODE="pull"
fi

echo "Synchronization mode: $MODE"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null || echo "$SCRIPT_DIR")"

export MODE REPO_ROOT

# Load modules
source "$REPO_ROOT/install/01-detect-hardware.sh"
source "$REPO_ROOT/install/02-paths.sh"
source "$REPO_ROOT/install/03-hardware-profiles.sh"
source "$REPO_ROOT/install/04-sync-core.sh"
source "$REPO_ROOT/install/05-sync-extras.sh"

detect_hardware
setup_paths

source "$REPO_ROOT/install/06-direction.sh"
setup_direction

run_sync
post_sync_adjustments

echo "Running monitor configuration script..."

# Execute monitors script if it exists and is executable
if [ -x "$HOME/scripts/monitors.sh" ]; then
    "$HOME/scripts/monitors.sh"
else
    echo "Warning: $HOME/scripts/monitors.sh not found or not executable."
fi

echo "Synchronization complete"
