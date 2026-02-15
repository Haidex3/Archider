#!/usr/bin/env bash

# =========================
# CONFIG
# =========================
BUS="9"          # <-- cambia si detect cambia
STEP=10
MAX=100

export PATH=/usr/bin:/bin

# =========================
# GET CURRENT BRIGHTNESS
# =========================
get_brightness() {
    ddcutil getvcp 10 --bus=$BUS --terse 2>/dev/null | awk '{print $4}'
}

# =========================
# MAIN
# =========================
current=$(get_brightness)

if [[ -z "$current" ]]; then
    exit 1
fi

case "$1" in
    up)
        new=$(( current + STEP ))
        ;;
    down)
        new=$(( current - STEP ))
        ;;
    set)
        new=$2
        ;;
    get)
        echo "$current" > /tmp/brightness-value
        exit 0
        ;;

    *)
        exit 1
        ;;
esac

# Clamp
if (( new > MAX )); then new=$MAX; fi
if (( new < 0 )); then new=0; fi

ddcutil setvcp 10 "$new" --bus=$BUS >/dev/null 2>&1
echo "$new"
