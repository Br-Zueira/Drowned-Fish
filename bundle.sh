#!/usr/bin/env bash

set -euo pipefail # Safety flags that quit at any error

echo "Setting up variables"
OUTPUT="out/drowned-fish.love" # Sets the final file name
TARGETS=( # Files and folders to be included
    "assets"
    "libs"
    "maps"
    "modules"
    "conf.lua"
    "main.lua"
)

echo "Cleaning old bundles"
rm -f "$OUTPUT" # Remove old build, if any

echo "Creating new bundle"
zip -9 -rq "$OUTPUT" "${TARGETS[@]}" -x "*.git*" "*.DS_Store" # Zips the game

echo "'$OUTPUT' bundle successfully finished"