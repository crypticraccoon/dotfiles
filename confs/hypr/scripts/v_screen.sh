#! /bin/bash

VMONITOR="headless"
VWORKSPACE=6
RMONITORY="eDP-1"

cleanup() {
  echo "\n[wayvnc] Cleaning up..."
  hyprctl dispatch moveworkspacetomonitor $VMONITOR $RMONITORY
  hyprctl dispatch focusmonitor "$RMONITORY"
  pkill wayvnc
  echo "[wayvnc] Done."
  exit 0
}

trap cleanup INT TERM EXIT

if ! hyprctl monitors | grep -q "$VMONITOR"; then
  echo "[wayvnc] Creating $VMONITOR dynamically..."
  hyprctl output create headless
	hyprctl dispatch moveworkspacetomonitor $VWORKSPACE $VMONITOR
  sleep 0.5
fi

hyprctl dispatch focusmonitor "$RMONITORY"

wayvnc -f 60 -dD 0.0.0.0 5900 HEADLESS-2
