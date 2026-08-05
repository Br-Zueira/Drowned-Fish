#!/usr/bin/env bash

# Safety flags for any error
set -euo pipefail

# Bundles game before packaging
source ./bundle.sh

# Find the project root directory (where this script lives)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define paths relative to the project root
DEP="$PROJECT_ROOT/bundle-dependencies"
LOVE_APPIMAGE="$DEP/love-11.5-x86_64.AppImage"
APPIMAGETOOL="$DEP/appimagetool-x86_64.AppImage"

# Ensure the AppImages are executable
chmod +x "$LOVE_APPIMAGE"
chmod +x "$APPIMAGETOOL"

# Create and move into the 'out' directory
cd "out"

echo "Extracting Love AppImage"
rm -rf squashfs-root # Cleans up old extraction
"$LOVE_APPIMAGE" --appimage-extract > /dev/null 2>&1 # Extracts the Love AppImage

# Game name to be used
GAME="drowned-fish"

# Folder of extracted Love AppImage
FOLDER="squashfs-root"

# Merges binaries, ensure game bin is executable and removes Love bin
echo "Merging Love AppImage with game bundle"
cat "$FOLDER/bin/love" "$PROJECT_ROOT/$OUTPUT" > "$FOLDER/bin/$GAME"
chmod +x "$FOLDER/bin/$GAME"
rm -f "$FOLDER/bin/love"

# Desktop file path
DESKTOP="$FOLDER/$GAME".desktop

# Changes file names to match game name
echo "Changing file names"
mv "$FOLDER/love.desktop" $DESKTOP
mv "$FOLDER/love.svg" "$FOLDER/$GAME".svg

# Cleanly separates Love license from game license (and copies game license into folder)
echo "Handling licenses and readme"
mv "$FOLDER/license.txt" "$FOLDER/LICENSE-LOVE.txt"
cp "$PROJECT_ROOT/LICENSE" "$FOLDER"
mv "$FOLDER/LICENSE" "$FOLDER/LICENSE-GAME.txt"
cp "$PROJECT_ROOT/README.md" "$FOLDER"

echo "Changing variables"
# Desktop file variables
sed -i "s/^Name=.*/Name=$GAME/" "$DESKTOP"
sed -i "s/^Comment=.*/Comment=A simple 2D troll game made with Love2D. The name is a thing as impossible as you beating this game./" "$DESKTOP"
sed -i "/^MimeType=/d" "$DESKTOP"
sed -i "s/^Exec=.*/Exec=$GAME %f/" "$DESKTOP"
sed -i "s/^Categories=.*/Categories=Game;ActionGame;ArcadeGame;X-Troll;X-Love2DGame/" "$DESKTOP"
sed -i "s/^Icon=.*/Icon=$GAME/" "$DESKTOP"
sed -i "/^NoDisplay=/d" "$DESKTOP"

# AppRun binary name
sed -i "s|/bin/love|/bin/$GAME|" "$FOLDER/AppRun"

# Compresses folder back into AppImage
echo "Compressing into AppImage"

# Tells AppImageTool we're building AppImage for x86_64 CPUs
ARCH=x86_64

# Wraps folder into AppImage
# Warns about error if any, else echoes success message
rm -f "$GAME"-linux-x86_64.AppImage
if $APPIMAGETOOL "squashfs-root" "$GAME"-linux.x86_64.AppImage > /dev/null 2>&1; then
    echo "'$GAME'.AppImage successfully created"
else
    echo "An error occurred"
    exit 1
fi