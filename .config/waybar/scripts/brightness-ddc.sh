#!/usr/bin/env bash

BUS="2"
STEP=10
MAX=100

get_brightness() {
    ddcutil getvcp 10 --bus=$BUS 2>/dev/null | grep -oP 'current value =\s*\K[0-9]+' || echo "?"
}

case "$1" in
  up)
    current=$(get_brightness)
    (( new = current + STEP ))
    (( new > MAX )) && new=$MAX
    ddcutil setvcp 10 "$new" --bus=$BUS >/dev/null 2>&1
    ;;
  down)
    current=$(get_brightness)
    (( new = current - STEP ))
    (( new < 0 )) && new=0
    ddcutil setvcp 10 "$new" --bus=$BUS >/dev/null 2>&1
    ;;
  *)
    get_brightness
    ;;
esac
