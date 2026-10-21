#!/bin/sh
set -eu

# Check required commands.
for command in aplay speaker-test alsamixer
do
    if ! command -v "$command" >/dev/null 2>&1; then
        echo "Error: missing command: $command" >&2
        echo "Run basics/audio/install.sh first."
        exit 1
    fi
done

# Display detected sound cards.
echo "Detected sound cards:"
cat /proc/asound/cards

echo
echo "Playback devices:"
aplay -l

echo
echo "Testing left and right speakers..."

# Play one test cycle.
speaker-test -c 2 -t wav -l 1

echo
printf "Did you hear sound? [y/N]: "
IFS= read -r answer

case "$answer" in
    y|Y|yes|YES)
        echo "Audio test passed."
        ;;
    *)
        echo "Audio test failed."
        echo "Check the selected sound card and ALSA mixer levels."
        exit 1
        ;;
esac
