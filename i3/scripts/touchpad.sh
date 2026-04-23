#!/usr/bin/env bash

# Use the specific identifier from your output
DEVICE="ASUE120A:00 04F3:319B Touchpad"
MASTER_ID=2

# Check if device is floating or disabled
# 1. Check if it's in the 'floating' section of xinput
IS_FLOATING=$(xinput list | grep "$DEVICE" | grep -c "floating")

# 2. Check if it's disabled (if not floating)
IS_DISABLED=$(xinput list-props "$DEVICE" | grep "Device Enabled" | grep -o "0$")

if [ "$IS_FLOATING" -eq 1 ] || [ "$IS_DISABLED" -eq 1 ]; then
    # Re-attach and enable
    xinput reattach "$DEVICE" "$MASTER_ID"
    xinput enable "$DEVICE"
    notify-send "Touchpad" "Enabled" --icon=input-touchpad
else
    # Disable (this might float it depending on your driver)
    xinput disable "$DEVICE"
    notify-send "Touchpad" "Disabled" --icon=input-touchpad
fi
