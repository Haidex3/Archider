#!/usr/bin/expect -f
spawn su -c "/home/Haider/scripts/nvidia-fan-curve.sh"
expect "Password:"
send "contraseña\r"
interact
