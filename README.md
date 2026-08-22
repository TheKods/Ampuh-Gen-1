<p align="center">
  <img src="custom/res/Images/QGCLogoFull.svg" alt="AMPUH Gen 1 Tactical GCS Logo" width="500">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Project-AMPUH%20Gen%201-00f0ff?style=for-the-badge&logo=drone" alt="AMPUH Gen 1">
  <img src="https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20Android-0284c7?style=for-the-badge" alt="Platforms">
  <img src="https://img.shields.io/badge/Status-Active%20Tactical%20GCS-10b981?style=for-the-badge" alt="Status">
</p>

# AMPUH Gen 1 Tactical Ground Control Station

**AMPUH Gen 1** is an advanced Tactical Ground Control Station (GCS) engineered for Unmanned Aerial Vehicles (UAVs), providing autonomous mission planning, real-time cyber telemetry, and precision flight control for *MAVLink-enabled* platforms (including *PX4* and *ArduPilot* autopilots).

---

## ⚡ Fitur Utama (Core Features)

- 🎯 **Tactical Cyber HUD (FlyView)** — Dilengkapi pita kompas 360° (*Heading Ribbon*), indikator sikap pesawat (*Attitude Indicator*), serta bar telemetri instan (Altitude, Speed, Distance, Battery, Flight Mode).
- 🛰️ **Autonomous Mission Planning** — Perencanaan misi cerdas: waypoint navigasi, pemetaan survey grid, struktur 3D scan, serta fail-safe return-to-launch (RTL).
- 🎨 **Stealth Cyber-Dark Theme** — Palet warna antarmuka taktis dengan kontras tinggi (*Stealth Slate*, *Cyber Cyan*, dan *Sky Blue*) untuk kenyamanan operasional siang & malam.
- ⚙️ **Vehicle Setup & Calibration** — Wizard terpandu untuk kalibrasi sensor IMU, kompas, radio transmitter, flight modes, dan power module.
- 📡 **MAVLink High-Speed Protocol** — Kompatibel penuh dengan telemetri radio, serial link, UDP WiFi/LAN, serta Bluetooth.
- 📹 **Low-Latency Video Pipeline** — Streaming video RTP/RTSP terintegrasi berbasis GStreamer dengan perekaman langsung pada layar terbang.
- 🛡️ **Defensive Architecture** — Modul kustom independen (`custom/`) yang terisolasi dan mudah di-upgrade.

---

## 🚀 Panduan Memulai Cepat (Quick Start)

### 1. Prasyarat Sistem (Prerequisites)
- **Sistem Operasi**: Windows 10 / 11 (64-bit), Linux, atau macOS
- **Compiler**: Visual Studio 2022 (MSVC C++ Desktop) atau GCC / Clang
- **Framework**: Qt 6.8+ (Qt Quick, Positioning, SerialPort, Location)
- **Build Tools**: CMake 3.25+ & Ninja

### 2. Instalasi Tooling Lingkungan
Jalankan di PowerShell:
```powershell
python tools/setup/install_python.py dev
.\.venv\Scripts\activate
```

### 3. Konfigurasi dan Kompilasi
```powershell
# Konfigurasi CMake otomatis
just configure

# Kompilasi aplikasi (Release)
just release

# Jalankan AMPUH Gen 1
just run
```

---

## 📁 Struktur Modul Kustom (`custom/`)

```text
custom/
├── cmake/
│   └── CustomOverrides.cmake    # Konfigurasi nama (AMPUH Gen 1), ID, dan branding
├── res/
│   ├── Images/QGCLogoFull.svg   # Logo vektor taktis AMPUH Gen 1
│   └── icons/custom_*.svg       # Ikon launcher & aplikasi
├── src/
│   ├── CustomPlugin.cc/.h       # Core plugin & palet warna Cyber-Dark
│   ├── FlyViewCustomLayer.qml   # Tactical Cyber HUD overlay & telemetry bar
│   ├── CustomGuidedActionsController.qml # Dialog aksi taktis terpandu
│   ├── AutoPilotPlugin/         # Konfigurasi komponen setup autopilot
│   └── FirmwarePlugin/          # Pengaturan mode terbang taktis
└── CMakeLists.txt               # Registrasi resource & komponen kustom
```

---

## 📄 Lisensi & Hak Cipta

Project ini dikembangkan berbasis arsitektur **AMPUH Gen 1** dan dirilis di bawah lisensi open source [GNU General Public License v3 (GPLv3)](LICENSE-GPL).
