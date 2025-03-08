#!/usr/bin/env bash

set -euo pipefail

# Constants
if [ $(basename "$0") == "bash" ]
then
    readonly SCRIPT_NAME="HomeLabSetup"
else
    readonly SCRIPT_NAME=$(basename "$0")
fi
readonly LOG_FILE="/var/log/${SCRIPT_NAME%.*}.log"
readonly TMP_DIR=$(mktemp -d -t HomeLabSetup-XXXXXX)

# Logger function
log() {
    local level="$1"
    shift
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [${level}] $*" | tee -a "$LOG_FILE"
}

# Error handler
error_exit() {
    log "ERROR" "$1"
    exit 1
}

# Cleanup function
cleanup() {
    log "INFO" "Cleaning up temporary directory ${TMP_DIR}"
    rm -rf "$TMP_DIR"
}

# Main function
main() {
    log "INFO" "Starting HomeLab Container Management installation script"

    trap cleanup EXIT

    sudo apt-get update || error_exit "Failed to update package lists"

    # Launch Container Mangement Stack
    # wget -qO- https://raw.githubusercontent.com/SamuelGTurner/HomeLab/main/shared/container-management/docker-compose.yml | docker compose -f - up -d
}

# Run the script
main "$@"