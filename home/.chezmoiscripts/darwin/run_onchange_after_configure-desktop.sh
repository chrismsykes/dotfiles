#!/bin/bash

set -eufo pipefail

# Needs Automation permission for the terminal to control System Events; on a fresh
# Mac the permission prompt can time out (-1712). Warn rather than abort the apply.
set_wallpaper='tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Space Gray Pro.png" as POSIX file'
if ! osascript -e "$set_wallpaper"; then
    echo "WARNING: couldn't set the desktop picture. Allow your terminal to control System Events in" >&2
    echo "         System Settings → Privacy & Security → Automation, then run:" >&2
    echo "         osascript -e '$set_wallpaper'" >&2
fi
