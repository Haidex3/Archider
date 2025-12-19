#!/bin/bash
# ~/.config/waybar/scripts/gpu.sh

usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
mem=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)

echo " ${usage}% (${mem}MB)  ${temp}°C"
