#!/bin/bash

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
EXTRACTED_CURSOR="$HOME/.local/share/cursor-extracted/squashfs-root/usr/bin/cursor"

# Check if extracted Cursor exists
if [ ! -f "$EXTRACTED_CURSOR" ]; then
    echo "Error: Extracted Cursor not found at $EXTRACTED_CURSOR"
    echo "Please run the extraction script first."
    exit 1
fi

# Allow users to override command-line options
if [[ -f $XDG_CONFIG_HOME/cursor-flags.conf ]]; then
    CURSOR_USER_FLAGS="$(sed 's/#.*//' $XDG_CONFIG_HOME/cursor-flags.conf | tr '\n' ' ')"
fi

# Launch the extracted Cursor
exec "$EXTRACTED_CURSOR" "$@" $CURSOR_USER_FLAGS 