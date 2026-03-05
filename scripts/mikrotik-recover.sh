#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/lib/common.sh
source "${SCRIPTS_DIR}/lib/common.sh"

check_cli mactelnet

MAC="${1:-}"
USER="${2:-admin}"
PASS="${3:-}"
BACKUP_NAME="${4:-backup}"
IS_RSC="${5:-false}"

if [[ -z "${MAC}" ]]; then
    log error "MAC address is required"
fi

log info "Recovering MikroTik device" "mac=${MAC}" "user=${USER}" "backup=${BACKUP_NAME}"

if [[ "${IS_RSC}" == "true" ]]; then
    COMMANDS="/import file-name=\"${BACKUP_NAME}.rsc\""
    log info "Importing RSC configuration" "file=${BACKUP_NAME}.rsc"
else
    # Note: loading a backup usually reboots the device immediately
    COMMANDS="/system backup load name=\"${BACKUP_NAME}.backup\""
    log info "Loading binary backup" "file=${BACKUP_NAME}.backup"
fi

log debug "Running recovery commands" "commands=${COMMANDS}"

# Use the piping approach with sleep to handle the interactive nature of mactelnet
(
    sleep 2
    echo "${COMMANDS}"
    sleep 2
    echo "y" # Confirm reboot/load if prompted
    sleep 1
    echo "/quit"
) | mactelnet -t 5 -u "${USER}" -p "${PASS}" "${MAC}"

log info "Recovery command sent. The device might reboot." "mac=${MAC}"
