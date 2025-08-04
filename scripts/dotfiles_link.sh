#!/bin/bash

# Define the source directory (dotfiles) and the target directory (~/.config)
SOURCE_DIR="$(dirname "$(realpath "$0")")/../dotfiles"
TARGET_DIR="$HOME/.config"

# Check if the source directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: Source directory '$SOURCE_DIR' does not exist."
  exit 1
fi

# Create the .config directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Iterate through all directories (top-level only) in the source directory
for dir in "$SOURCE_DIR"/*; do
  if [[ -d "$dir" ]]; then
    dir_name=$(basename "$dir")
    target_path="$TARGET_DIR/$dir_name"

    # Remove existing file or directory at the target location
    if [[ -e "$target_path" || -L "$target_path" ]]; then
      echo "Removing existing $target_path"
      rm -rf "$target_path"
    fi

    # Create the symbolic link
    echo "Linking $dir -> $target_path"
    ln -s "$dir" "$target_path"
  fi
done

echo "All dotfile directories have been symlinked to $TARGET_DIR."
