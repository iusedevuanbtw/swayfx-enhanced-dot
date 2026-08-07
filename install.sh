#!/bin/sh
set -e

PACKAGES="waybar wofi swaylock mako SwayOSD wlsunset cliphist grim slurp swappy wlogout playerctl python3-i3ipc Foot Alacritty Font-Awesome"

echo "[*] Checking and installing secondary packages on Void Linux..."
if command -v xbps-install >/dev/null 2>&1; then
    sudo xbps-install -Sy $PACKAGES
else
    echo "[!] xbps-install not found. Skipping package installation."
fi

echo "[*] Creating config directories..."
mkdir -p ~/.config

echo "[*] Deploying dotfiles..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for dir in mako sway swaylock waybar wlogout wofi; do
    if [ -d "$SCRIPT_DIR/$dir" ]; then
        cp -rf "$SCRIPT_DIR/$dir" ~/.config/
        echo " -> Copied $dir to ~/.config/"
    fi
done

echo "[*] Setting execution permissions for scripts..."
chmod +x ~/.config/sway/scripts/*.sh 2>/dev/null || true
chmod +x ~/.config/sway/scripts/*.py 2>/dev/null || true

echo "[+] Done! Reload SwayFX."
