#!/usr/bin/env bash
# Mata procesos viejos que puedan pisar polybar
killall -q blueman-tray 2>/dev/null

# Mata polybar si ya está
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

polybar main &
