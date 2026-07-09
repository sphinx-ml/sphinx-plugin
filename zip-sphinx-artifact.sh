#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="sphinx-artifact.zip"

cd "$SCRIPT_DIR"
rm -f "$OUTPUT_FILE"
zip -r "$OUTPUT_FILE" . -x "$OUTPUT_FILE" "./$OUTPUT_FILE"
