#!/usr/bin/env bash

set -euo pipefail

# Constants
readonly SCRIPT_NAME=$(basename "$0")
readonly LOG_FILE="${HOME}/log/${SCRIPT_NAME%.*}.log"
readonly TMP_DIR=$(mktemp -d -t HomeLab-XXXXXX)

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
    echo $HOME
    echo $LOG_FILE
    sudo touch "$LOG_FILE"
    sudo chmod 666 "$LOG_FILE"  # Allows all users to write

    log "INFO" "Starting HomeLab Container Management installation script"

    trap cleanup EXIT

    sudo apt-get update || error_exit "Failed to update package lists"

    # Launch Container Mangement Stack
    # wget -qO- https://raw.githubusercontent.com/SamuelGTurner/HomeLab/main/shared/container-management/docker-compose.yml | docker compose -f - up -d
}

# Run the script
main "$@"