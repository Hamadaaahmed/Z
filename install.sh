#!/bin/bash

set -e

SERVICE_NAME="zivpn"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="zivpn-server"
BINARY_PATH="${INSTALL_DIR}/${BINARY_NAME}"
CONFIG_DIR="/etc/udp-zivpn"
CONFIG_FILE="${CONFIG_DIR}/server.json"
CERT_FILE="${CONFIG_DIR}/cert.pem"
KEY_FILE="${CONFIG_DIR}/key.pem"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
MENU_SOURCE="menu1"
MENU_TARGET="/usr/local/bin/menu1"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

require_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "This installer must be run as root."
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

install_packages() {
  export DEBIAN_FRONTEND=noninteractive
  apt update -y
  apt install -y systemd curl wget ca-certificates openssl
}

prepare_directories() {
  mkdir -p "${INSTALL_DIR}"
  mkdir -p "${CONFIG_DIR}"
}

install_binary() {
  if [ ! -f "${BINARY_SOURCE}" ]; then
    echo "Binary file not found: ${BINARY_SOURCE}"
    echo "Please place the correct binary inside the files directory."
    exit 1
  fi

  cp "${BINARY_SOURCE}" "${BINARY_PATH}"
  chmod +x "${BINARY_PATH}"
}

generate_tls_files() {
  if [ ! -f "${CERT_FILE}" ] || [ ! -f "${KEY_FILE}" ]; then
    openssl req -x509 -nodes -newkey rsa:2048 \
      -keyout "${KEY_FILE}" \
      -out "${CERT_FILE}" \
      -days 3650 \
      -subj "/CN=udp-zivpn"
    chmod 600 "${KEY_FILE}"
    chmod 644 "${CERT_FILE}"
  fi
}

write_default_config() {
  if [ ! -f "${CONFIG_FILE}" ]; then
    cat > "${CONFIG_FILE}" <<EOF
{
  "listen": ":7300",
  "cert": "${CERT_FILE}",
  "key": "${KEY_FILE}"
}
EOF
  fi
}

write_service_file() {
  cat > "${SERVICE_FILE}" <<EOF
[Unit]
Description=ZIVPN Service
After=network.target

[Service]
Type=simple
ExecStart=${BINARY_PATH} server --config ${CONFIG_FILE}
WorkingDirectory=${CONFIG_DIR}
Restart=always
RestartSec=3
User=root
LimitNOFILE=1048576

[Install]
WantedBy=multi-user.target
EOF
}

install_menu() {
  if [ ! -f "${SCRIPT_DIR}/${MENU_SOURCE}" ]; then
    echo "Menu file not found: ${SCRIPT_DIR}/${MENU_SOURCE}"
    exit 1
  fi

  cp "${SCRIPT_DIR}/${MENU_SOURCE}" "${MENU_TARGET}"
  chmod +x "${MENU_TARGET}"
}

enable_service() {
  systemctl daemon-reload
  systemctl enable "${SERVICE_NAME}"
  systemctl restart "${SERVICE_NAME}"
}

show_summary() {
  echo "=================================="
  echo "ZIVPN installation completed."
  echo "Service name : ${SERVICE_NAME}"
  echo "Binary path  : ${BINARY_PATH}"
  echo "Config file  : ${CONFIG_FILE}"
  echo "Cert file    : ${CERT_FILE}"
  echo "Key file     : ${KEY_FILE}"
  echo "Menu command : menu1"
  echo "=================================="
  systemctl --no-pager --full status "${SERVICE_NAME}" || true
}

main() {
  require_root
  detect_arch
  install_packages
  prepare_directories
  install_binary
  generate_tls_files
  write_default_config
  write_service_file
  install_menu
  enable_service
  show_summary
}

main "$@"
