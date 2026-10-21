#!/bin/sh
set -eu

# Partition management.
doas apk add parted
doas apk add lsblk
doas apk add cfdisk

# Filesystem utilities.
doas apk add e2fsprogs
doas apk add dosfstools
doas apk add exfatprogs
