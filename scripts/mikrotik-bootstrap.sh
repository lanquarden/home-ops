#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/lib/common.sh
source "${SCRIPTS_DIR}/lib/common.sh"

check_cli mactelnet

MAC="${1:-}"
USER="${2:-admin}"
PASS="${3:-}"
NEW_USER="${4:-admin}"
NEW_PASS="${5:-}"

if [[ -z "${MAC}" ]]; then
    log error "MAC address is required"
fi

log info "Bootstrapping MikroTik device" "mac=${MAC}" "user=${USER}"

# Commands to run
# 1. Set password for the user
# 2. Enable SSH
# 3. Create a new user if specified (optional)

COMMANDS="/user set ${USER} password=\"${NEW_PASS}\"; /ip service set ssh disabled=no"

if [[ "${USER}" != "${NEW_USER}" ]]; then
    COMMANDS="${COMMANDS}; /user add name=\"${NEW_USER}\" password=\"${NEW_PASS}\" group=full"
fi

log debug "Running commands" "commands=${COMMANDS}"

# Use the piping approach with sleep to handle the interactive nature of mactelnet
# Note: This approach might be sensitive to timing.
(
    sleep 2
    echo "${COMMANDS}"
    sleep 2
    echo "/quit"
) | mactelnet -t 5 -u "${USER}" -p "${PASS}" "${MAC}"

log info "Bootstrapping completed" "mac=${MAC}"
