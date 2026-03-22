# Auto-Script-Install-X-ray-ZIVPN-Only
# 🚀 Auto Script Install X-RAY & ZIVPN (Lightweight Edition)

![Badge](https://img.shields.io/badge/Release-v18.02.26-blue?style=for-the-badge&logo=linux)
![Badge](https://img.shields.io/badge/Supported-Ubuntu%20%7C%20Debian-orange?style=for-the-badge&logo=ubuntu)
![Badge](https://img.shields.io/badge/Code-Bash-green?style=for-the-badge&logo=gnu-bash)

Script Auto Installer khusus untuk **X-ray Core** dan **ZIVPN Tunnel**. Didesain sangat ringan, stabil, dan memiliki tampilan **Platinum Clean UI** yang informatif. Sangat cocok untuk VPS dengan spesifikasi kecil (Low-End VPS).

---

## 📥 PERINTAH INSTALL (INSTALLATION)

Salin dan jalankan perintah di bawah ini pada terminal VPS Anda (Wajib run sebagai **root**):

```bash
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/tendostore/Auto-Script-Install-X-ray-ZIVPN-Only/main/setup && chmod +x setup && ./setup
```
Pastikan VPS dalam keadaan fresh (baru diinstall ulang) untuk hasil terbaik.

---

### ⭐ KEUNGGULAN UTAMA (KEY FEATURES)
Script ini difokuskan pada performa dan kemudahan penggunaan:

#### ⚡ 1. Super Ringan & Cepat
- Hanya menginstall paket yang benar-benar dibutuhkan (X-ray & ZIVPN).
- Tidak memberatkan RAM dan CPU.
- Cocok untuk VPS dengan RAM 512MB - 1GB.

#### 🎨 2. Platinum Clean UI Dashboard
- Tampilan menu kotak (Box Layout) yang rapi tanpa garis putus.
- **System Info Lengkap:** Menampilkan OS, RAM, SWAP, ISP, Kota, IP, dan Uptime secara realtime.
- **Account Counter:** Menghitung jumlah akun yang aktif langsung di menu utama.
- **Status Monitor:** Indikator warna (ON/OFF) untuk service Xray, Zivpn, dan IPtables.

#### 🌐 3. Fleksibilitas Domain
Saat instalasi, Anda diberikan dua pilihan:
- **Auto Domain:** Menggunakan subdomain random gratis dari Tendo Store (langsung aktif SSL).
- **Custom Domain:** Menggunakan domain Anda sendiri.

#### 🎮 4. Support Game & Call (ZIVPN)
- Sudah terintegrasi dengan ZIVPN UDP Tunneling.
- Support untuk bermain game online dan panggilan WhatsApp lancar.
- Port UDP Gateway yang luas.

---

### 🛠️ DAFTAR FITUR LENGKAP

#### 📡 Protocols
| Protocol | Transport | Port |
| :--- | :--- | :--- |
| **VMess** | WS TLS / Non-TLS | 443 / 80 |
| **VLess** | WS TLS / Non-TLS | 443 / 80 |
| **Trojan** | WS TLS | 443 |
| **ZIVPN** | UDP Tunnel | 5667 / 6000-19999 |

#### ⚙️ Tools & Manager
- ✅ Create, Delete, Renew, Check User Account
- ✅ Auto Installer (Sekali klik langsung jadi)
- ✅ Speedtest by Ookla (Official Binary)
- ✅ Benchmark VPS (YABS Script Integration)
- ✅ Auto Reboot Manager
- ✅ Clear Cache & Swap Cleaner
- ✅ Change Domain & Auto Renew SSL

---

### 💻 PERSYARATAN SISTEM (REQUIREMENTS)
- **OS:**
  - Ubuntu 20.04 / 22.04 LTS (Recommended)
  - Debian 10 / 11
- **RAM:** Minimal 512MB
- **Core:** Minimal 1 Core
- **ISP:** Support Cloud Providers (DigitalOcean, Vultr, Linode, AWS, Azure, dll)

---

### 📸 PREVIEW (TAMPILAN)
Tampilan Menu Dashboard yang Informatif dan Rapi:

![Tampilan Script 1](https://github.com/tendostore/Auto-Script-Install-X-ray-ZIVPN-Only/blob/2199db91b0edd8ad7ac6db466668279608005b04/Screenshot_20260218-133906.png?raw=true)
![Tampilan Script 2](https://github.com/tendostore/Auto-Script-Install-X-ray-ZIVPN-Only/blob/b410e0df34405e39c7da650f65a15629449ef374/Screenshot_20260218-134043.png?raw=true)

> **Note:** Script ini dilindungi dan di-compile menggunakan SHC untuk keamanan. Source code asli disimpan oleh developer.

---

### 📞 KONTAK & SUPPORT
Jika menemukan bug atau ingin request fitur tambahan, silakan hubungi:

- **Telegram:** [@tendo_32](https://t.me/tendo_32)
- **Owner:** Tendo Store

<div align="center">
  <small>Copyright © 2026 Tendo Store. All Rights Reserved.</small>
</div>
