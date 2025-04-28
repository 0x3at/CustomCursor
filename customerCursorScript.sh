#!/usr/bin/env bash

# customerCursorScript.sh - Extracts Cursor AppImage to ~/.local/share/cursor-extracted

# Define paths
cursorAppImage="/opt/cursor-bin/cursor-bin.AppImage"
extractDir="$HOME/.local/share/cursor-extracted"
backupDir="$HOME/.local/share/cursor-extracted-backup"
backupTimestamp=$(date +"%Y%m%d_%H%M%S")

# Check if the AppImage exists
if [ ! -f "$cursorAppImage" ]; then
    echo "Error: Cursor AppImage not found at $cursorAppImage"
    exit 1
fi

# Create extraction directory if it doesn't exist
mkdir -p "$extractDir"

# Backup previous extraction if it exists
if [ -d "$extractDir/squashfs-root" ]; then
    echo "Creating backup of previous extraction..."
    mkdir -p "$backupDir"
    backupName="cursor_backup_$backupTimestamp"
    cp -r "$extractDir/squashfs-root" "$backupDir/$backupName"
    
    # Copy timestamp file if it exists
    if [ -f "$extractDir/.extracted_timestamp" ]; then
        cp "$extractDir/.extracted_timestamp" "$backupDir/$backupName.timestamp"
    fi
    
    echo "Backup created at $backupDir/$backupName"
    echo "Removing previous extraction..."
    rm -rf "$extractDir/squashfs-root"
fi

# Extract the AppImage
echo "Extracting Cursor AppImage..."
cd "$extractDir"
"$cursorAppImage" --appimage-extract

# Create timestamp file
date > "$extractDir/.extracted_timestamp"

echo "Cursor has been extracted to $extractDir"
echo "You can now run cursor from $extractDir/squashfs-root/usr/bin/cursor"

# Make the binary executable
chmod +x "$extractDir/squashfs-root/usr/bin/cursor"

exit 0 