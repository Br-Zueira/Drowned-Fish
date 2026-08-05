#!/usr/bin/env bash

# Safety flags for any error
set -euo pipefail

# Bundles game before packaging
source ./bundle.sh

echo "Setting up folders"
PACKAGE="drowned-fish-windows"
FOLDER="out/$PACKAGE"
LOVE="bundle-dependencies/love-11.5-win64"
rm -rf "$FOLDER" # Cleans up old build, if any
mkdir -p "$FOLDER" # Creates brand new folder

echo "Copying dynamic libraries"
cp "$LOVE"/*.dll "$FOLDER" # Copies all dlls into build folder

echo "Copying licenses and readme"
cp "$LOVE/license.txt" "$FOLDER/LICENSE-LOVE.txt" # Copies and renames Love license
cp "LICENSE" "$FOLDER/LICENSE-GAME.txt" # Copies and renames Game license
cp "README.md" "$FOLDER" # Copies readme

echo "Merging binaries"
EXECUTABLE="drowned-fish.exe"
cat "$LOVE/love.exe" "$OUTPUT" > "$FOLDER/$EXECUTABLE" # Merges love and game bundle into a single executable file

echo "Compressing build"
(cd out && zip -9 -rq "$PACKAGE".zip "$PACKAGE") # Packages game into easily distributable zips

echo "'$EXECUTABLE' compiled successfully"