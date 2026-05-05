#!/usr/bin/env bash
# deploy.sh — Add a visual explainer to the AIAIS Visuals site
# Usage: ./deploy.sh path/to/your-visual.html
# The file will be copied to visuals/ and pushed to GitHub Pages.

set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: ./deploy.sh path/to/visual.html"
  exit 1
fi

SRC="$1"
FILENAME="$(basename "$SRC")"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST="$REPO_DIR/visuals/$FILENAME"

if [ ! -f "$SRC" ]; then
  echo "Error: File not found: $SRC"
  exit 1
fi

echo "Deploying $FILENAME..."
cp "$SRC" "$DEST"

cd "$REPO_DIR"
git add "visuals/$FILENAME"
git commit -m "feat: add visual explainer — $FILENAME"
git push origin main

echo ""
echo "Deployed: https://jfrost1011.github.io/aiais-visuals/visuals/$FILENAME"
