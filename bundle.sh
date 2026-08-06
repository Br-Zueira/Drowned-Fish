#!/usr/bin/env bash

set -euo pipefail # Safety flags that quit at any error

echo "Setting up variables"
OUTPUT="out/drowned-fish.love" # Sets the final file name
OUTPUT_ABS="$(realpath -m "$OUTPUT")"
TARGET="src" # Source target of build

echo "Cleaning old bundles"
rm -f "$OUTPUT" # Remove old build, if any

echo "Creating new bundle"
(cd $TARGET && zip -9 -rq "$OUTPUT_ABS" . -x "*.git*" "*.DS_Store") # Zips the game

echo "'$OUTPUT' bundle successfully finished"