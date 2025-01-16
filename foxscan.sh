#!/usr/bin/env bash
set -euo pipefail

# Check for needed tools
command -v gau >/dev/null 2>&1 || { echo >&2 "Error: gau not found."; exit 1; }
command -v dalfox >/dev/null 2>&1 || { echo >&2 "Error: dalfox not found."; exit 1; }

# Helper function
usage() {
    echo "Usage: $0 <URL>"
    echo "Example: $0 https://example.com"
    exit 1
}

# Check arguments
if [ $# -lt 1 ]; then
    usage
fi

URL=$1
DOMAIN=$(echo "$URL" | sed -E 's#https?://([^/]+)/?.*#\1#')
OUTPUT_DIR="${DOMAIN}_scan_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

GAU_OUTPUT_FILE="${OUTPUT_DIR}/result.txt"
PROCESSED_FILE="${OUTPUT_DIR}/processed_input.txt"
DALFOX_OUTPUT_FILE="${OUTPUT_DIR}/xss.txt"

echo "███████╗  ██████╗  ██╗  ██╗  ██████╗   ██████╗  █████╗   ███╗   ██╗"
echo "██╔════╝ ██╔═══██╗ ╚██╗██╔╝ ██╔════╝  ██╔════╝ ██╔══██╗  ████╗  ██║"
echo "█████╗   ██║   ██║  ╚███╔╝  ╚█████╗   ██║      ███████║  ██╔██╗ ██║"
echo "██╔══╝   ██║   ██║  ██╔██╗    ╚═══██  ██║      ██╔══██║  ██║╚██╗██║"
echo "██║      ╚██████╔╝ ██╔╝ ██╗ ██████╔╝  ███████╗ ██║  ██║  ██║ ╚████║"
echo "╚═╝       ╚═════╝   ╚═╝  ╚═╝ ╚════╝   ╚══════╝ ╚═╝  ╚═╝  ╚═╝  ╚═══╝"
echo ""
echo "                  Automated XSS Scanner"
echo ""
echo "Start of script"

# Step 1: Run gau
echo "[*] Running gau on: $URL"
gau -o "$GAU_OUTPUT_FILE" "$URL"

if [ ! -s "$GAU_OUTPUT_FILE" ]; then
    echo "Error: gau output file is empty or not created."
    exit 1
fi
echo "[*] GAU output saved to: $GAU_OUTPUT_FILE"

# Step 2: Process the output
echo "[*] Processing GAU output with sed"
sed 's/=.*/=/' "$GAU_OUTPUT_FILE" > "$PROCESSED_FILE"

if [ ! -s "$PROCESSED_FILE" ]; then
    echo "Error: Processed file is empty."
    exit 1
fi
echo "[*] Processed file saved to: $PROCESSED_FILE"

# Step 3: Run dalfox
echo "[*] Running dalfox in pipe mode"
DALFOX_FLAGS="--skip-mining-dom --worker 50"
dalfox pipe $DALFOX_FLAGS -o "$DALFOX_OUTPUT_FILE" < "$PROCESSED_FILE"

if [ ! -s "$DALFOX_OUTPUT_FILE" ]; then
    echo "Error: dalfox output is empty."
    exit 1
fi
echo "[*] Dalfox output saved to: $DALFOX_OUTPUT_FILE"

echo "End of script"

