#!/bin/bash

echo "Removing Zed configuration files..."

paths=(
"$HOME/Library/Application Support/Zed"
"$HOME/Library/Saved Application State/dev.zed.Zed.savedState"
"$HOME/Library/Logs/Zed"
"$HOME/Library/Caches/dev.zed.Zed"
)

for path in "${paths[@]}"; do
  if [ -e "$path" ]; then
    echo "Deleting: $path"
    rm -rf "$path"
  else
    echo "Not found: $path"
  fi
done

echo "Zed data cleanup completed."