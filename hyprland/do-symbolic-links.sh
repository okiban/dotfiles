#!/bin/bash

SRC_DIR="$(pwd)"
DEST_DIR="$HOME/.config"
CONFIG_DIR="$SRC_DIR"/.config
mkdir -p "$DEST_DIR"

for dir in $CONFIG_DIR/*; do
    base_dir="$(basename "$dir")"
    echo $(basename "$dir")

    # skip if the directory is the destination itself
    if [[ "$CONFIG_DIR/$base_dir" == "$DEST_DIR" ]]; then
	continue
    fi

    # Create the symlink if it doesn't already exist
    if [[ ! -e "$DEST_DIR/$base_dir" ]]; then
        ln -s "$CONFIG_DIR/$base_dir" "$DEST_DIR/$base_dir"
        echo "Linked $base_dir"
    else
        echo "Skipped $base_dir (already exists)"
    fi
done
