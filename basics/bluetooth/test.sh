#!/bin/sh
set -eu

# Check Bluetooth service.
rc-service bluetooth status

# Check Bluetooth radio.
rfkill list bluetooth

# Show available Bluetooth controllers.
bluetoothctl list

# Show the default controller.
bluetoothctl show
