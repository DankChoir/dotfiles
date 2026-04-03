#!/usr/bin/env bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

# Check if awww is installed
if ! command -v awww >/dev/null 2>&1; then
  notify-send "Wallpaper Error" "The 'awww' binary was not found."
  exit 1
fi

# Check if directory exists
if [[ ! -d "$WALLPAPER_DIR" ]]; then
  notify-send "Wallpaper Error" "Directory $WALLPAPER_DIR does not exist."
  exit 1
fi

# Pick a random wallpaper
# find is safer than ls for handling spaces and filtering by extension
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.webp" \) | shuf -n 1)

if [[ -n "$RANDOM_WALLPAPER" ]]; then
  # Optional: ensure the daemon is running (common for swww/awww)
  # pgrep -x awww-daemon > /dev/null || awww-daemon &

  # Apply the wallpaper with transitions
  awww img "$RANDOM_WALLPAPER" \
    --transition-type any \
    --transition-duration 1 \
    --transition-fps 60
else
  notify-send "Wallpaper Error" "No suitable images found in $WALLPAPER_DIR"
  exit 1
fi
