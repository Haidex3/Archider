#!/usr/bin/env bash

CONFIG="$HOME/.config/hypr/configs/monitors.conf"

# Get active monitors
mapfile -t MONITORS < <(hyprctl monitors -j | jq -r '.[].name')

PRIMARY="${MONITORS[0]}"
SECONDARY="${MONITORS[1]}"

# Get primary monitor resolution and refresh rate
PRIMARY_RES=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$PRIMARY\") | \"\(.width)x\(.height)@\(.refreshRate)\"")

# If there is a second monitor
if [[ -n "$SECONDARY" ]]; then
    SECONDARY_WIDTH=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$SECONDARY\") | .width")
    SECONDARY_HEIGHT=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$SECONDARY\") | .height")
    SECONDARY_REFRESH=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$SECONDARY\") | .refreshRate")
    SECONDARY_RES="${SECONDARY_WIDTH}x${SECONDARY_HEIGHT}@${SECONDARY_REFRESH}"
    OFFSET_X="-$SECONDARY_WIDTH"
else
    SECONDARY_RES=""
fi

# Rewrite entire file
{
echo "# -------------------------------------------------"
echo "# Monitor setup (auto-generated)"
echo "# -------------------------------------------------"

echo ""
echo "# Primary monitor"
echo "monitor=$PRIMARY,$PRIMARY_RES,0x0,1"

if [[ -n "$SECONDARY" ]]; then
    echo ""
    echo "# Secondary monitor (left)"
    echo "monitor=$SECONDARY,$SECONDARY_RES,${OFFSET_X}x0,1"
fi

} > "$CONFIG"

echo "Monitors config updated."
