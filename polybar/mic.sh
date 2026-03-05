#!/usr/bin/env bash

if [ "$(pamixer --default-source --get-mute)" = "true" ]; then
  echo " | 󰍭 Muted";
else
  echo " |  Mic: $(pamixer --default-source --get-volume)%";
fi

