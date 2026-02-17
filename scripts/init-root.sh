#!/usr/bin/expect -f
spawn su -c "~/scripts/nvidia-fan-curve.sh"
expect "Password:"
send "1234\r" # Example password, replace with the actual one
interact
