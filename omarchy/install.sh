#!/bin/bash
# Apply these Omarchy dotfiles on a fresh (or rebuilt) Omarchy install.
#
#   git clone https://github.com/nullaroni/dotfiles.git ~/Developer/dotfiles
#   ~/Developer/dotfiles/omarchy/install.sh
#
# Safe to run again: existing files are backed up once, then replaced by symlinks.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$HERE/$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
    echo "ok      $dest"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.bak-$STAMP"
    echo "backup  $dest -> $dest.bak-$STAMP"
  fi
  ln -s "$src" "$dest"
  echo "linked  $dest"
}

echo "== Config files"
link hypr/bindings.lua    "$HOME/.config/hypr/bindings.lua"
link hypr/looknfeel.lua   "$HOME/.config/hypr/looknfeel.lua"
link hypr/monitors.lua    "$HOME/.config/hypr/monitors.lua"
link omarchy/shell.json   "$HOME/.config/omarchy/shell.json"

echo "== Theme"
omarchy theme set "Gruvbox" || echo "warning: could not set theme"

if [ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
  echo "== Reloading Hyprland"
  hyprctl reload >/dev/null
  errors="$(hyprctl configerrors)"
  if [ -n "$(echo "$errors" | tr -d '[:space:]')" ]; then
    echo "Hyprland config errors:"; echo "$errors"
  fi
fi

if [ "${SKIP_LIMINE:-}" != "1" ]; then
  echo "== Limine boot menu (needs sudo)"
  sudo bash "$HERE/limine.sh"
fi

echo "Done."
