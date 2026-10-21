#!/bin/sh
set -eu

PATH="$PATH:/sbin:/usr/sbin"
export PATH

# Detect Intel Cherry Trail with the NAU8824 codec.
if [ ! -d /sys/bus/acpi/devices/808622A8:00 ] ||
   [ ! -d /sys/bus/i2c/devices/i2c-10508824:00 ]; then
    echo "Cherry Trail NAU8824 hardware not detected."
    exit 0
fi

echo "Intel Cherry Trail NAU8824 detected."

# Check the BIOS audio configuration.
acpi_status=/sys/bus/acpi/devices/808622A8:00/status

if [ -r "$acpi_status" ] &&
   [ "$(cat "$acpi_status")" != "15" ]; then
    echo "Warning: LPE Audio ACPI mode may be disabled."
    echo "Check the audio configuration in BIOS/UEFI."
fi

# Check for required firmware, including compressed files.
has_firmware()
{
    for file in "$1" "$1".*
    do
        [ -f "$file" ] && return 0
    done

    return 1
}

firmware=/lib/firmware/intel/sof/sof-cht.ri
topology=/lib/firmware/intel/sof-tplg/sof-cht-nau8824.tplg

if has_firmware "$firmware" && has_firmware "$topology"; then
    echo "Required firmware is already installed."
    exit 0
fi

# Use the community repository matching the installed Alpine version.
alpine_version=$(cut -d. -f1,2 /etc/alpine-release)

doas apk add \
    --repository "https://dl-cdn.alpinelinux.org/alpine/v$alpine_version/community" \
    sof-firmware

# Verify the required firmware files.
if ! has_firmware "$firmware" ||
   ! has_firmware "$topology"; then
    echo "Error: required SOF firmware files are missing." >&2
    exit 1
fi

echo "SOF firmware installed successfully."
echo "Reboot to allow the kernel to detect the audio device."
