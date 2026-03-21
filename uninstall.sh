#!/bin/bash

set -e

SERVICE_NAME="zivpn"
BINARY_PATH="/usr/local/bin/zivpn-server"
MENU_PATH="/usr/local/bin/menu1"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
CONFIG_DIR="/etc/udp-zivpn"

require_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "This uninstaller must be run as root."
    exit 1
  fi
}

stop_and_disable_service() {
  if systemctl list-unit-files | grep -q "^${SERVICE_NAME}\.service"; then
    systemctl stop "${SERVICE_NAME}" 2>/dev/null || true
    systemctl disable "${SERVICE_NAME}" 2>/dev/null || true
  fi
}

remove_service_file() {
  if [ -f "${SERVICE_FILE}" ]; then
    rm -f "${SERVICE_FILE}"
  fi
  systemctl daemon-reload
  systemctl reset-failed 2>/dev/null || true
}

remove_binary() {
  if [ -f "${BINARY_PATH}" ]; then
    rm -f "${BINARY_PATH}"
  fi
}

remove_menu() {
  if [ -f "${MENU_PATH}" ]; then
    rm -f "${MENU_PATH}"
  fi
}

remove_config_dir() {
  if [ -d "${CONFIG_DIR}" ]; then
    rm -rf "${CONFIG_DIR}"
  fi
}

show_summary() {
  echo "=================================="
  echo "ZIVPN uninstallation completed."
  echo "Removed service : ${SERVICE_NAME}"
  echo "Removed binary  : ${BINARY_PATH}"
  echo "Removed menu    : ${MENU_PATH}"
  echo "Removed config  : ${CONFIG_DIR}"
  echo "=================================="
}

main() {
  require_root
  stop_and_disable_service
  remove_service_file
  remove_binary
  remove_menu
  remove_config_dir
  show_summary
}

main "$@"
