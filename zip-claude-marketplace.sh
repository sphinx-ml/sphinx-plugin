#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="$SCRIPT_DIR/sphinx-artifact-marketplace.zip"

rm -f "$OUTPUT_FILE"
cd "$SCRIPT_DIR"

zip -r "$OUTPUT_FILE" \
  .claude-plugin \
  plugins \
  docs \
  README.md \
  LICENSE \
  -x '*.zip' '*/.DS_Store' '*/__pycache__/*' '*.pyc'
