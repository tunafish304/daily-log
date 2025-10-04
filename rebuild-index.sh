#!/bin/bash

ROOT_DIR="."
TEMP_INDEX="index.md"
echo "# Conversations Index" > "$TEMP_INDEX"

# Get all folders with .md files, sorted alphabetically
folders=$(find "$ROOT_DIR" -type f -name "*.md" | sed "s|$ROOT_DIR/||" | awk -F/ '{print $1}' | sort -u)

for folder in $folders; do
    echo -e "\n## $folder" >> "$TEMP_INDEX"

    # Find and sort .md files in this folder
    find "$ROOT_DIR/$folder" -maxdepth 1 -name "*.md" | sort | while read -r file; do
        rel_path="${file#$ROOT_DIR/}"
        filename="$(basename "$file")"
        title="$(head -n 1 "$file" | sed 's/^# *//')"

        echo "- [${title:-$filename}]($rel_path) — \`$filename\`" >> "$TEMP_INDEX"
    done
done