#!/system/bin/sh

echo "BlockAdsNext Hosts Auto Update Script"
echo "By: @OodavidsinoO"

# Check User Permissions
if [ "$USER" != "root" -a "$(whoami 2>/dev/null)" != "root" ]; then
  echo "[!!!] Need root permissions"; exit 1;
fi;
case "$HOME" in
  *termux*) echo "[!!!] Need su root environment"; exit 1;;
esac;

echo "[*] Updating Hosts File..."
# Default Host File URL
DEFAULT_HOST_FILE_URL="https://raw.githubusercontent.com/OodavidsinoO/BlockAdsNext/refs/heads/main/hosts"
# Detect Busybox
BUSYBOX_PATH = ""

# Check if Busybox is installed
if [ -f "/data/adb/magisk/busybox" ]; then
    BUSYBOX_PATH="/data/adb/magisk/busybox"
elif [ -f "/data/adb/ksu/bin/busybox" ]; then
    BUSYBOX_PATH="/data/adb/ksu/bin/busybox"
elif [ -f "/data/adb/ap/bin/busybox" ]; then
    BUSYBOX_PATH="/data/adb/ap/bin/busybox"
fi

if [ -n "$BUSYBOX_PATH" ]; then
    echo "[*] Busybox detected at $BUSYBOX_PATH"
    echo "[*] Downloading $DEFAULT_HOST_FILE_URL to /etc/hosts"
    if $BUSYBOX_PATH wget -O /etc/hosts $DEFAULT_HOST_FILE_URL; then
        echo "[*] Hosts File Updated!"
    else
        echo "[!!!] Failed to update hosts file!"
    fi
fi
echo ""

# warn since Magisk's implementation automatically closes if successful
if [ "$KSU" != "true" -a "$APATCH" != "true" ]; then
    echo -e "\nClosing dialog in 10 seconds ..."
    sleep 10
fi