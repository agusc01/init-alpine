#!/bin/sh
set -eu

# Timezone data.
doas apk add tzdata

# Terminal calendar and task manager.
doas apk add calcurse
