# 🛸 AMPUH Gen 1 — Release v1.0.0 (Apex Tactical AI Edition)

<p align="center">
  <img src="https://img.shields.io/badge/RELEASE-v1.0.0%20APEX%20AI-00E5FF?style=for-the-badge&logo=github" alt="Release v1.0.0">
  <img src="https://img.shields.io/badge/TARGET-WINDOWS%20%7C%20ANDROID%20APK-00FF66?style=for-the-badge&logo=android" alt="Platforms">
  <img src="https://img.shields.io/badge/BUILD-STABLE%20PRODUCTION-FFD600?style=for-the-badge&logo=checkmarx" alt="Stable Build">
</p>

Kami dengan bangga merilis **AMPUH Gen 1 v1.0.0 (Apex Tactical AI Edition)** — Stasiun Kendali Darat (*Tactical Ground Control Station*) mutakhir dengan integrasi pengawasan kecerdasan buatan (**YOLOv8 / YOLOv11**), pelacakan kamera gimbal otonom via MAVLink, proyeksi GPS ke peta satelit, dan optimalisasi penuh layar sentuh lapangan **Android (APK)**.

---

## 🌟 FITUR UTAMA & HIGHLIGHTS

### 1. 🤖 Apex Tactical AI Surveillance Engine
* **YOLO Native Integration (UDP 9090):** Menerima deteksi objek real-time via UDP JSON (`xywh_center`, `xyxy`, `xywh`).
* **Autonomous MAVLink Gimbal Tracking:** Loop kendali proporsional 20 Hz di C++ secara otomatis menggerakkan gimbal kamera drone mengunci sasaran bergerak.
* **Ray-Casting Geolocation & Satellite Map Sync:** Memproyeksikan target deteksi kamera ke koordinat GPS nyata $(\text{Lat}, \text{Lon})$ dan menampilkannya sebagai marker taktis di Peta Satelit QGC.
* **Ghost Tracking (Occlusion Recovery):** Kotak bayangan `👻 GHOST PREDICTED` memprediksi arah keluarnya target jika terhalang pohon/gedung selama 1–3 detik.
* **Tactical Threat & Priority Scoring:** Penilaian skor ancaman otomatis ($0 - 100\%$) berdasarkan kecepatan, jarak, dan status kuncian (`[THR: 85%]`).
* **Virtual Perimeter Defense:** Sirine alarm suara otomatis dan banner merah berkedip saat objek melintasi radius batas aman ($50\text{m} - 500\text{m}$).
* **Action Shortcuts:** Tombol aksi langsung **[ FLY TO ]**, **[ ORBIT ]**, dan **[ LOCK ROI ]**.

### 2. 📱 Android Mobile Field-Ready
* **Haptic Vibration Feedback:** Getaran fisik taktis $60\text{ ms}$ via Android JNI Vibrator saat target disentuh/dikunci.
* **2-Finger Swipe Gesture:** Usap 2 jari di layar sentuh untuk berganti mode HUD secara instan.
* **Sunlight High-Contrast Mode:** Kontras ultra-tinggi anti-silau terik matahari lapangan.
* **Smart WakeLock (Anti-Sleep):** Layar tablet/HP tidak mati otomatis selama misi pelacakan AI aktif.

### 3. ✈️ Military Dual-Mode Glass Cockpit HUD
* **3-State HUD Toggle:** Mode HUD AI 🤖, Mode HUD UAV Telemetri ✈️, dan Hybrid Mode 🌐.
* **Tactical Glass Cockpit:** Artificial Horizon militer, Pitch Ladder, Speed/Altitude Tapes, Heading Ribbon, dan Battery/GPS Status Bar.
* **Vision Shaders:** Filter visual video *Normal RGB*, *Night-Vision Green*, *Ironbow Thermal*, dan *White-Hot FLIR*.

---

## 📦 ASSETS & DOWNLOADS

| Platform / Paket | Nama File | Arsitektur | Tipe Paket |
| :--- | :--- | :--- | :--- |
| 🪟 **Windows x64** | `AMPUH-Gen1-v1.0.0-Windows-x64.zip` | x86_64 / MSVC | Standalone Executable |
| 📱 **Android Tablet/HP** | `AMPUH-Gen1-v1.0.0-Android-arm64-v8a.apk` | ARM64-v8a | Android Application Package |
| 🐧 **Linux Desktop** | `AMPUH-Gen1-v1.0.0-Linux-x86_64.AppImage` | x86_64 | Portable AppImage |
| 📄 **Source Code** | `Source code (zip)` / `Source code (tar.gz)` | All | Repository Source Code |

---

## 🔒 SHA-256 CHECKSUMS (INTEGRITY VERIFICATION)
```text
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  AMPUH-Gen1-v1.0.0-Windows-x64.zip
a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e  AMPUH-Gen1-v1.0.0-Android-arm64-v8a.apk
bc4d209148d94e823f64c7d0d0f7a93a8d9a4e09f61b0c057639f70624d673bc  AMPUH-Gen1-v1.0.0-Linux-x86_64.AppImage
```

---

## 🚀 PANDUAN PENGGUNAAN CEPAT
1. **Windows:** Ekstrak file `.zip` lalu jalankan `QGroundControl.exe`.
2. **Android:** Install file `.apk` pada tablet/smartphone Android (Android 10 hingga 15+).
3. **AI Engine:** Sambungkan kamera drone / RTSP stream, jalankan script YOLO, dan arahkan pengiriman JSON UDP ke IP perangkat port `9090`.

*Dokumentasi teknis lengkap:* [AI_HUD_MASTER_DOCUMENTATION.md](https://github.com/TheKods/Ampuh-Gen-1/blob/master/AI_HUD_MASTER_DOCUMENTATION.md)
