#!/usr/bin/env bash

set -euo pipefail

# Constants
readonly SCRIPT_NAME=$(basename "$0")
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

# Install dependencies
install_dependencies() {
    local deps="git cmake build-essential pkg-config libzmq3-dev libssl-dev zlib1g-dev libpq-dev unzip libusb-1.0-0-dev libsqlite3-dev"
    log "INFO" "Installing build dependencies: $deps"
    apt install -y $deps || error_exit "Failed to install dependencies"
}

# Main function
main() {
    log "INFO" "Starting HomeLab Container Management installation script"

    trap cleanup EXIT

    apt update || error_exit "Failed to update package lists"

    # Launch Container Mangement Stack
    # wget -qO- https://raw.githubusercontent.com/SamuelGTurner/HomeLab/main/shared/container-management/docker-compose.yml | docker compose -f - up -d
}

# Run the script
main "$@"