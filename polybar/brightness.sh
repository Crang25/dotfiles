#!/usr/bin/env bash

BRIGHTNESS=$(brightnessctl info | grep -oP '\d+%')
echo "| 󰃟 Brightness: $BRIGHTNESS | "

