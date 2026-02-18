#!/bin/bash

cliphist list | tail -n +11 | cliphist delete

selected=$(cliphist list | cut -f2- | rofi -dmenu \
    -p "Clipboard" \
    -theme ~/.config/rofi/applications.rasi)


if [[ -n "$selected" ]]; then
    cliphist decode "$(cliphist list | grep -F "$selected")" | wl-copy
fi