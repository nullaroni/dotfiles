#!/bin/bash
# Make the Limine boot menu always show, wait 15 seconds, and list Windows.
# Run as root: sudo bash limine.sh
set -euo pipefail

CONF=/boot/limine.conf
TOOL_CONF=/etc/limine-entry-tool.conf
TIMEOUT=15

[ "$(id -u)" -eq 0 ] || { echo "run with sudo"; exit 1; }
[ -f "$CONF" ] || { echo "$CONF not found, skipping Limine setup"; exit 0; }

# Let limine-entry-tool detect other bootloaders (Windows Boot Manager) on every update.
if [ -f "$TOOL_CONF" ]; then
  if grep -qE '^\s*FIND_BOOTLOADERS=' "$TOOL_CONF"; then
    sed -i -E 's/^\s*FIND_BOOTLOADERS=.*/FIND_BOOTLOADERS=yes/' "$TOOL_CONF"
  else
    echo 'FIND_BOOTLOADERS=yes' >> "$TOOL_CONF"
  fi
fi

cp "$CONF" "$CONF.bak-$(date +%Y%m%d-%H%M%S)"

# Regenerate entries if Windows isn't listed yet (picks it up via FIND_BOOTLOADERS).
if ! grep -qi 'bootmgfw.efi' "$CONF" && command -v limine-update >/dev/null; then
  limine-update
fi

set_option() {
  local key="$1" value="$2"
  if grep -qE "^\s*$key:" "$CONF"; then
    sed -i -E "s/^(\s*)$key:.*/\1$key: $value/" "$CONF"
  else
    sed -i "1a $key: $value" "$CONF"
  fi
}

# quiet: yes hides the menu unless a key is pressed, so turn it off.
set_option timeout "$TIMEOUT"
set_option quiet no

if grep -qi 'bootmgfw.efi' "$CONF"; then
  echo "Windows entry: present"
else
  echo "Windows entry: NOT found (is Windows installed? check 'efibootmgr')"
fi
grep -nE '^(timeout|quiet):' "$CONF"
