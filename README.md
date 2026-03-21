# ZIVPN Installer (Custom Build)

A lightweight installer for running ZIVPN UDP server with full control via a simple CLI menu.

---

## 📦 Features

- Automatic installation of ZIVPN server
- Auto-detect system architecture (AMD64 / ARM64)
- Automatic TLS certificate generation
- Systemd service integration
- Simple management menu (menu1)
- Easy update and uninstall scripts

---

## 📁 Project Structure

zivpn-installer/
├── install.sh
├── update.sh
├── uninstall.sh
├── menu1
└── files/
    ├── zivpn-linux-amd64
    └── zivpn-linux-arm64

---

## 🚀 Installation

Upload the project to your server, then run:

chmod +x install.sh
sudo ./install.sh

---

## ⚙️ Service Info

Service name: zivpn  
Config file: /etc/udp-zivpn/server.json  
Certificate: /etc/udp-zivpn/cert.pem  
Key: /etc/udp-zivpn/key.pem  
Default port: 7300  

---

## 🧠 Management

After installation, use:

menu1

Menu Options:
- Start / Stop / Restart service
- Enable / Disable auto-start
- View logs
- View config
- Change port

---

## 🔄 Update

To update the service:

chmod +x update.sh
sudo ./update.sh

---

## ❌ Uninstall

To remove everything:

chmod +x uninstall.sh
sudo ./uninstall.sh

---

## ⚠️ Notes

- Requires root access
- Designed for Debian / Ubuntu systems
- Uses self-signed TLS certificate (can be replaced manually)

---

## 📌 Author

Custom build based on ZIVPN binary reverse integration.
