#!/usr/bin/env bash

set -euo pipefail

# Constants
readonly SCRIPT_NAME=$(basename "$0")
readonly LOG_FILE="/var/log/${SCRIPT_NAME%.*}.log"
readonly TMP_DIR=$(mktemp -d -t HomeLabSetup-XXXXXX)
readonly DOMAINNAME=$(hostname)".local"
readonly DOCKERDIRNAME="docker"
readonly DOCKERDIR="~/${DOCKERDIRNAME}"


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

# Docker Prerequisites
enable_docker_prerequisites() {
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt remove -y $pkg; done

    local deps="ca-certificates curl"
    log "INFO" "Installing docker prerequisites: $deps"
    apt install -y $deps || error_exit "Failed to install docker prerequisites"

    # Add Docker's official GPG key:
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update
    }

# Install dependencies
install_dependencies() {
    local deps="docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
    log "INFO" "Installing build dependencies: $deps"
    apt install -y $deps || error_exit "Failed to install dependencies"
}

# Main function
main() {
    log "INFO" "Starting HomeLab Container Management installation script"

    trap cleanup EXIT

    apt update || error_exit "Failed to update package lists"

    enable_docker_prerequisites
    install_dependencies

    cd ~
    echo "$DOCKERDIRNAME"
    mkdir -p "$DOCKERDIRNAME"

    # Create portainer volume if not exists
    if [ ! "$(docker volume ls -f name=portainer_data -q 2> /dev/null)" ]; then 
        docker volume create portainer_data
    fi
    
    # Launch Container Mangement Stack
    export DOCKERDIR
    export DOMAINNAME
    curl -s https://raw.githubusercontent.com/SamuelGTurner/HomeLab/refs/heads/dev/shared/container-management/docker-compose.yml | docker compose -f - config container-management
    curl -s https://raw.githubusercontent.com/SamuelGTurner/HomeLab/refs/heads/dev/shared/container-management/docker-compose.yml | docker compose -f - up -d

}

# Run the script
main "$@"