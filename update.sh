#!/bin/bash

set -e

SERVICE_NAME="zivpn"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="zivpn-server"
BINARY_PATH="${INSTALL_DIR}/${BINARY_NAME}"
MENU_TARGET="/usr/local/bin/menu1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

require_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "This updater must be run as root."
    exit 1
  fi
}

detect_arch() {
  ARCH="$(uname -m)"
  case "${ARCH}" in
    x86_64) BINARY_SOURCE="${SCRIPT_DIR}/files/zivpn-linux-amd64" ;;
    aarch64|arm64) BINARY_SOURCE="${SCRIPT_DIR}/files/zivpn-linux-arm64" ;;
    *)
      echo "Unsupported architecture: ${ARCH}"
      exit 1
      ;;
  esac
}

check_files() {
  if [ ! -f "${BINARY_SOURCE}" ]; then
    echo "Binary file not found: ${BINARY_SOURCE}"
    exit 1
  fi

  if [ ! -f "${SCRIPT_DIR}/menu1" ]; then
    echo "Menu file not found: ${SCRIPT_DIR}/menu1"
    exit 1
  fi
}

update_binary() {
  cp "${BINARY_SOURCE}" "${BINARY_PATH}"
  chmod +x "${BINARY_PATH}"
}

update_menu() {
  cp "${SCRIPT_DIR}/menu1" "${MENU_TARGET}"
  chmod +x "${MENU_TARGET}"
}

restart_service() {
  systemctl daemon-reload
  if systemctl list-unit-files | grep -q "^${SERVICE_NAME}\.service"; then
    systemctl restart "${SERVICE_NAME}"
  else
    echo "Warning: ${SERVICE_NAME}.service was not found."
  fi
}

show_summary() {
  echo "=================================="
  echo "ZIVPN update completed."
  echo "Updated binary : ${BINARY_PATH}"
  echo "Updated menu   : ${MENU_TARGET}"
  echo "Service        : ${SERVICE_NAME}"
  echo "=================================="
  systemctl --no-pager --full status "${SERVICE_NAME}" || true
}

main() {
  require_root
  detect_arch
  check_files
  update_binary
  update_menu
  restart_service
  show_summary
}

main "$@"
