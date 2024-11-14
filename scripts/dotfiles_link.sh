#!/bin/bash

# Define the source directory (dotfiles) and the target directory (~/.config)
SOURCE_DIR="$(dirname "$(realpath "$0")")/../dotfiles"
TARGET_DIR="$HOME/.config"

sudo rm -rf $TARGET_DIR/*

# Check if the source directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: Source directory '$SOURCE_DIR' does not exist."
  exit 1
fi

# Create the .config directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Iterate through all directories in the source directory
find "$SOURCE_DIR" -type d | while read -r dir; do
  # Strip the leading path part and create the corresponding directory structure in .config
  relative_path="${dir#$SOURCE_DIR/}"
  target_dir="$TARGET_DIR/$relative_path"

  # If the directory does not already exist in .config, create it
  if [[ ! -d "$target_dir" ]]; then
    echo "Creating directory: $target_dir"
    mkdir -p "$target_dir"
  fi

  # Hard link the files inside the directory
  for file in "$dir"/*; do
    # Only link regular files (not directories)
    if [[ -f "$file" ]]; then
      # Generate the corresponding file path in .config
      target_file="$TARGET_DIR/$relative_path/$(basename "$file")"
      
      # If the file does not already exist, create the hard link
      if [[ ! -e "$target_file" ]]; then
        echo "Linking $file to $target_file"
        ln "$file" "$target_file"
      fi
    fi
  done
done

echo "All dotfiles have been hard-linked to $TARGET_DIR."
