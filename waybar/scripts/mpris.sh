#!/bin/bash

player=$(playerctl -l 2>/dev/null | head -n 1)
if [ -z "$player" ]; then
  echo "⏹️ No player"
  exit
fi

status=$(playerctl --player="$player" status 2>/dev/null)
title=$(playerctl --player="$player" metadata title 2>/dev/null)
artist=$(playerctl --player="$player" metadata artist 2>/dev/null)

case "$status" in
Playing) icon="▶️" ;;
Paused) icon="⏸️" ;;
Stopped) icon="⏹️" ;;
*) icon="❔" ;;
esac

if [ -n "$title" ] || [ -n "$artist" ]; then
  echo "$icon $artist - $title"
else
  echo "$icon No track"
fi
