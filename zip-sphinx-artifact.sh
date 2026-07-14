#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="$SCRIPT_DIR/sphinx-artifact.zip"
PLUGIN_DIR="$SCRIPT_DIR/plugins/sphinx-artifact"

rm -f "$OUTPUT_FILE"
cd "$PLUGIN_DIR"
zip -r "$OUTPUT_FILE" .
