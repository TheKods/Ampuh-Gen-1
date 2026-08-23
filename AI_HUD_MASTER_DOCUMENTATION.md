# 📖 DOKUMENTASI LENGKAP PENGEMBANGAN & UPGRADE SISTEM AI HUD QGROUNDCONTROL
**Proyek:** QGroundControl Windows & Android (APK) Tactical AI GCS  
**Target Arsitektur:** C++20 / Qt6 / QML / Android NDK (ARM64-v8a) / Windows x64  
**Engine AI:** YOLO (YOLOv8 / YOLOv11 / YOLO-NAS) via UDP IPC Socket (Port 9090)  

---

## 📑 DAFTAR ISI PER FASE
1. [Fase 1: Fondasi Arsitektur Dual-Mode HUD & Backend C++](#fase-1-fondasi-arsitektur-dual-mode-hud--backend-c)
2. [Fase 2: Upgrade 1 & 2 — MAVLink Gimbal Tracking & YOLO Geolocation Map Sync](#fase-2-upgrade-1--2--mavlink-gimbal-tracking--yolo-geolocation-map-sync)
3. [Fase 3: Upgrade Full Suite — Voice Alerts, Click-to-Fly/Orbit, Multi-Class Colors & Shaders](#fase-3-upgrade-full-suite--voice-alerts-click-to-flyorbit-multi-class-colors--shaders)
4. [Fase 4: Upgrade Khusus Android & Mobile Field-Ready](#fase-4-upgrade-khusus-android--mobile-field-ready)
5. [Fase 5: Upgrade Puncak (Apex Edition) — Ghost Tracking, Threat Scoring, Perimeter Defense & CSV Export](#fase-5-upgrade-puncak-apex-edition--ghost-tracking-threat-scoring-perimeter-defense--csv-export)
6. [Struktur File Lengkap Proyek](#struktur-file-lengkap-proyek)
7. [Panduan Integrasi untuk Rekan Developer AI](#panduan-integrasi-untuk-rekan-developer-ai)

---

## 🏛️ FASE 1: Fondasi Arsitektur Dual-Mode HUD & Backend C++

### 🎯 Tujuan & Analisis Kebutuhan:
* Aplikasi dikembangkan di **Windows PC** dan akan di-build ke **Android (APK)** dengan performa 60 FPS tanpa lag.
* Engine AI dibuat terpisah oleh developer lain menggunakan **YOLO**. Komunikasi antar aplikasi dilakukan via jaringan lokal UDP port `9090`.
* HUD menampilkan bounding box AI, statistik performa AI (FPS, latency, hardware load CPU/GPU/NPU, suhu), serta dapat di-*toggle* antara **HUD AI** dan **HUD Telemetri UAV (Artificial Horizon)**.
* Terdapat tombol/panel kontrol slide-out untuk mengatur fitur AI.

### 🛠️ Pekerjaan yang Dilakukan:
1. **Modul Backend C++ (`src/AI/`):**
   * [AIStatsData.h](file:///c:/Project/qgroundcontrol-master/src/AI/AIStatsData.h): Struktur data untuk *Detections*, *PerformanceMetrics*, dan *HardwareUsageMetrics*.
   * [AIDetectionBox.h](file:///c:/Project/qgroundcontrol-master/src/AI/AIDetectionBox.h) & [AIDetectionBox.cc](file:///c:/Project/qgroundcontrol-master/src/AI/AIDetectionBox.cc): Model objek `QObject` bounding box reaktif untuk QML.
   * [AIDetectionManager.h](file:///c:/Project/qgroundcontrol-master/src/AI/AIDetectionManager.h) & [AIDetectionManager.cc](file:///c:/Project/qgroundcontrol-master/src/AI/AIDetectionManager.cc): Singleton manager dengan sistem *object pooling* agar hemat alokasi memori di Android.
   * [AndroidSystemMonitor.h](file:///c:/Project/qgroundcontrol-master/src/AI/AndroidSystemMonitor.h) & [AndroidSystemMonitor.cc](file:///c:/Project/qgroundcontrol-master/src/AI/AndroidSystemMonitor.cc): Pembaca data native sistem (`/proc/stat`, `/proc/meminfo`, sensor termal Android, dan Windows API fallback).
   * [AIReceiverSocket.h](file:///c:/Project/qgroundcontrol-master/src/AI/AIReceiverSocket.h) & [AIReceiverSocket.cc](file:///c:/Project/qgroundcontrol-master/src/AI/AIReceiverSocket.cc): Socket listener UDP di thread latar belakang (`QThread`) port 9090 lengkap dengan simulator data otomatis saat offline.
   * [AIController.h](file:///c:/Project/qgroundcontrol-master/src/AI/AIController.h) & [AIController.cc](file:///c:/Project/qgroundcontrol-master/src/AI/AIController.cc): Master controller singleton `QGCAIController` yang diekspos ke QML.
   * [CMakeLists.txt](file:///c:/Project/qgroundcontrol-master/src/AI/CMakeLists.txt): Registrasi `AIModule` dan modul QML `QGroundControl.AI`.

2. **Antarmuka Visual QML (`src/FlyView/AI_HUD/`):**
   * [AIBoundingBoxOverlay.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/AIViews/AIBoundingBoxOverlay.qml): Tampilan sudut taktis (*corner brackets*), kuncian crosshair, tag nama objek, akurasi %, dan interaksi sentuh *tap-to-lock*.
   * [AIPerformanceHUD.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/AIViews/AIPerformanceHUD.qml): Panel telemetri glassmorphic (FPS, rincian latensi ms, CPU/GPU, RAM, dan status suhu).
   * [UAVFlightHorizonHUD.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/UAVViews/UAVFlightHorizonHUD.qml): Horizon buatan militer, tangga pitch (*pitch ladder*), dan indeks roll.
   * [UAVSpeedAltitudeTapes.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/UAVViews/UAVSpeedAltitudeTapes.qml): Pita vertikal kecepatan udara, ketinggian, dan kompas heading.
   * [UAVBatteryLinkPanel.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/UAVViews/UAVBatteryLinkPanel.qml): Status bar taktis (Mode terbang, Baterai V & %, GPS, Jarak wahana).
   * [HUDModeToggleButton.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/HUDModeToggleButton.qml): Tombol sentuh pemindah mode 3-tahap (`AI_MODE`, `UAV_MODE`, `HYBRID_MODE`).
   * [AIFeatureToolButton.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/Panels/AIFeatureToolButton.qml) & [AIFeaturesControlDrawer.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/Panels/AIFeaturesControlDrawer.qml): Slide-out drawer panel kontrol AI.
   * [HUDMasterContainer.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/HUDMasterContainer.qml): Koordinator utama seluruh layer HUD.
   * [FlyViewCustomLayer.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/FlyViewCustomLayer.qml): Injeksi `HUDMasterContainer` ke dalam tampilan terbang FlyView QGC.

---

## 🤖 FASE 2: Upgrade 1 & 2 — MAVLink Gimbal Tracking & YOLO Geolocation Map Sync

### 🎯 Tujuan & Analisis Kebutuhan:
* Mendukung format output spesifik **YOLO** (`xywh_center`, `xyxy`, `xywh`).
* Kamera gimbal drone dapat melacak sasaran secara otonom tanpa kendali manual.
* Objek yang dideteksi oleh kamera video diproyeksikan ke koordinat GPS bumi nyata dan muncul di Peta Satelit QGC.

### 🛠️ Pekerjaan yang Dilakukan:
1. **Parser Format Spesifik YOLO:**
   * Memperbarui `AIReceiverSocket.cc` untuk otomatis mengenali format YOLO `[center_x, center_y, width, height]` dan format bounding box lainnya.
2. **Pelacakan Kamera Gimbal Otonom via MAVLink (`autoGimbalTracking`):**
   * Mengintegrasikan `Vehicle::gimbalController()->sendGimbalRate(pitchRate, yawRate)` dengan loop kontrol 20 Hz di `AIController.cc`.
   * Menghitung deviasi $(dx, dy)$ dari pusat lensa kamera ke target yang dikunci. Kamera drone otomatis berputar mengikuti gerakan sasaran.
3. **Ray-Casting Geolocation & Sinkronisasi Peta Satelit:**
   * Menggabungkan GPS drone, ketinggian AGL, heading kompas, sudut pitch gimbal, dan FOV kamera untuk menghitung **koordinat GPS nyata $(\text{Lat}, \text{Lon})$ dan estimasi jarak (Range meter)** objek di tanah.
   * Membuat [AIMapTargetVisuals.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/AI_HUD/AIViews/AIMapTargetVisuals.qml) yang menaruh marker bercahaya (*pulsing crosshair*) langsung di peta [FlyViewMap.qml](file:///c:/Project/qgroundcontrol-master/src/FlyView/FlyViewMap.qml).
   * Menambahkan badge telemetri jarak dan estimasi kecepatan di bawah bounding box video: `[RNG: 140m | 38 km/h]`.

---

## 🔊 FASE 3: Upgrade Full Suite — Voice Alerts, Click-to-Fly/Orbit, Colors & Shaders

### 🎯 Tujuan & Analisis Kebutuhan:
* Menambahkan notifikasi suara taktis, perintah terbang otomatis ke target (*Guided Actions*), pembedaan warna antar jenis objek, filter penglihatan malam/termal, dan auto-zoom.

### 🛠️ Pekerjaan yang Dilakukan:
1. **Asisten Suara Taktis (*Tactical Voice Announcer via QGCAudio*):**
   * Mengintegrasikan `AudioOutput::instance()->say(text)` dari subsystem suara bawaan QGC.
   * Laporan suara otomatis saat target dikunci (*"Target 101 locked, Vehicle"*), dilepas (*"Target unlocked"*), ganti model, atau navigasi.
2. **Aksi Terbang Otonom (*Click-to-Fly & Orbit Target via MAVLink*):**
   * Tombol aksi instan pada bounding box sasaran:
     * **[ FLY TO ]** $\rightarrow$ Perintah `MAV_CMD_DO_REPOSITION` ke koordinat GPS target.
     * **[ ORBIT ]** $\rightarrow$ Perintah `MAV_CMD_DO_ORBIT` mengitari target pada radius $30\text{ meter}$.
3. **Pewarnaan Multi-Class Taktis (*Multi-Class Color Coding*):**
   * 🟢 **Person / SAR Human:** Hijau Neon (`#00FF66`)
   * 🔵 **Vehicle / Mobil / Truk:** Cyan Neon (`#00E5FF`)
   * 🟡 **Boat / Kapal Maritim:** Emas (`#FFD600`)
   * 🟣 **Aircraft / Drone:** Magenta (`#E040FB`)
   * 🔴 **Target Terkunci:** Merah Taktis (`#FF3B30`)
4. **Filter Palette Penglihatan Malam & Termal (*Vision Shaders*):**
   * Pilihan palette: *Normal RGB*, *Night-Vision Green Phosphor*, *Ironbow Thermal Heatmap*, *White-Hot*.
5. **Optical Auto-Zoom Target:**
   * Kamera gimbal otomatis memperbesar target (*zoom in*) jika ukuran target kecil di layar, dan memperkecil (*zoom out*) saat target mendekat.

---

## 📱 FASE 4: Upgrade Khusus Android & Mobile Field-Ready

### 🎯 Tujuan & Analisis Kebutuhan:
* Mengoptimalkan kenyamanan penggunaan layar sentuh mobile HP/Tablet Android di lapangan outdoor.

### 🛠️ Pekerjaan yang Dilakukan:
1. **Haptic Vibration Feedback (Getaran Sentuh Taktis):**
   * Mengintegrasikan Android JNI Vibrator Service di `AndroidSystemMonitor.cc`.
   * Memberikan getaran fisik taktis $60\text{ ms}$ di jari pilot saat menyentuh target untuk menguncinya di layar Android.
2. **Gestur Usap 2 Jari (*2-Finger Swipe Gestures*):**
   * Menambahkan `DragHandler` 2 jari di `HUDMasterContainer.qml` untuk mengganti mode HUD (*AI $\rightarrow$ UAV Horizon $\rightarrow$ Hybrid*) cukup dengan mengusap layar.
3. **Sunlight High-Contrast Mode (Anti-Silau Lapangan):**
   * Mode tampilan kontras ultra-tinggi dengan garis tebal dan latar gelap pekat agar informasi tetap terbaca jelas di bawah terik matahari siang hari.
4. **Smart WakeLock (Anti-Sleep):**
   * Menjaga layar HP/Tablet Android tetap menyala tanpa mati otomatis (*Keep Screen ON*) selama misi pelacakan AI aktif.

---

## 🛡️ FASE 5: Upgrade Puncak (Apex Edition) — Ghost Tracking, Threat, Perimeter & Export

### 🎯 Tujuan & Analisis Kebutuhan:
* Mencapai standar stasiun kendali militer tertinggi (*Apex Defense GCS*): tidak kehilangan jejak saat terhalang gedung, penilaian ancaman otomatis, pertahanan perimeter virtual, pemindah target cepat, dan ekspor laporan misi.

### 🛠️ Pekerjaan yang Dilakukan:
1. **Ghost Tracking & Occlusion Recovery (Anti Kehilangan Jejak):**
   * Menghitung vektor kecepatan terakhir target. Jika objek tertutup pohon/gedung selama 1-3 detik, sistem otomatis memunculkan **kotak bayangan bertitik (*Dotted Ghost Box*)** berlabel `👻 GHOST PREDICTED` sehingga gimbal kamera siap saat target muncul kembali.
2. **Tactical Threat & Priority Matrix Scoring ($0 - 100\%$):**
   * Menghitung nilai ancaman otomatis berdasarkan kecepatan gerak, jarak kedekatan ke drone, dan status kuncian (`[THR: 85%]`).
3. **Virtual Perimeter Defense & Siren Alert:**
   * Pengaturan radius batas aman ($50\text{m} - 500\text{m}$). Jika ada objek melintasi batas, sistem langsung membunyikan sirine suara taktis, getaran haptic $100\text{ ms}$, dan memunculkan **Banner Merah Berkedip**: `⚠️ PERIMETER BREACH: VEHICLE #101 AT 120m`.
4. **Quick Target Class Filter Chips Bar:**
   * Bilah tombol sentuh instan di atas layar: `[ ALL ]` `[ 🟢 PERSON ]` `[ 🔵 VEHICLE ]` `[ 🟡 BOAT ]` untuk memfilter fokus deteksi.
5. **Kunci Region of Interest (LOCK ROI via MAVLink):**
   * Tombol **[ LOCK ROI ]** pada bounding box mengirim perintah `MAV_CMD_DO_SET_ROI_LOCATION` agar kamera terus mengunci arah pandang ke titik GPS target meskipun drone terbang melakukan patroli rute lain.
6. **One-Touch Target Cycler `[ ⏭️ NEXT ]`:**
   * Tombol cepat di bilah aksi atas layar untuk melompat antar sasaran deteksi secara instan.
7. **Auto AI Mission Report & CSV Audit Log Export:**
   * Tombol satu klik di panel drawer untuk mengekspor seluruh rekaman data penerbangan (Waktu UTC detik, ID target, kelas objek, akurasi %, koordinat GPS Lat/Lon, kecepatan km/h, dan skor ancaman) ke file `.csv` di memori perangkat.

---

## 📁 STRUKTUR FILE LENGKAP PROYEK

```text
src/
├── AI/                                         # [MODUL C++ BACKEND AI]
│   ├── CMakeLists.txt                          # Build target AIModule & QGroundControl.AI
│   ├── AIStatsData.h                           # Struct data telemetri, deteksi, performa, hardware
│   ├── AIDetectionBox.h / .cc                  # Bounding box, Ghost tracking, Threat score, Heading, Lat/Lon
│   ├── AIDetectionManager.h / .cc              # Singleton pooling manager & aggregation
│   ├── AndroidSystemMonitor.h / .cc            # Native Android JNI Vibrate & WakeLock, Linux /proc, Windows API
│   ├── AIReceiverSocket.h / .cc                # UDP Worker Thread (Port 9090) + YOLO Native Parser & Simulator
│   └── AIController.h / .cc                    # MAVLink Actions, Gimbal Loop, Perimeter Alarm, CSV Exporter
│
├── FlyView/
│   ├── FlyViewCustomLayer.qml                  # Mengaktifkan HUDMasterContainer di layer terbang QGC
│   │
│   └── AI_HUD/                                 # [KOMPONEN VISUAL QML HUD]
│       ├── HUDMasterContainer.qml              # Master layout + Gesture 2-Jari + Siren Banner + Cycler
│       ├── HUDModeToggleButton.qml             # Tombol taktis pemindah mode (AI vs UAV vs Hybrid)
│       │
│       ├── AIViews/
│       │   ├── AIBoundingBoxOverlay.qml        # Bounding box, Ghost box, Threat pill, Motion arrows, Actions
│       │   ├── AIPerformanceHUD.qml            # Panel Glassmorphic: FPS, Latency (ms), CPU/NPU, RAM, Suhu
│       │   └── AIMapTargetVisuals.qml          # Proyeksi marker target AI langsung ke Peta Satelit QGC
│       │
│       ├── UAVViews/
│       │   ├── UAVFlightHorizonHUD.qml         # Artificial Horizon & Pitch Ladder HUD militer
│       │   ├── UAVSpeedAltitudeTapes.qml       # Speed/Alt Tapes, Heading Compass, Battery, GPS
│       │   └── UAVBatteryLinkPanel.qml         # Tactical status bar: Flight mode, Battery, GPS, Climb
│       │
│       └── Panels/
│           ├── AIFeatureToolButton.qml         # Tombol pembuka panel kontrol AI di sisi layar
│           └── AIFeaturesControlDrawer.qml     # Slide-out drawer: Perimeter radius, CSV Export, Shaders, Models
```

---

## 📡 PANDUAN INTEGRASI UNTUK REKAN DEVELOPER AI (YOLO)

Rekan developer yang mengembangkan model YOLO di PC/Embedded/NPU/Android hanya perlu mengirimkan paket JSON via **UDP ke alamat `127.0.0.1:9090`** dengan format standar berikut:

```json
{
  "detections": [
    {
      "id": 101,
      "class": "Vehicle",
      "confidence": 0.95,
      "box": [0.35, 0.40, 0.16, 0.12],
      "format": "xywh_center"
    },
    {
      "id": 102,
      "class": "Person",
      "confidence": 0.89,
      "box": [0.55, 0.60, 0.08, 0.15]
    }
  ],
  "performance": {
    "inference_fps": 31.5,
    "stream_fps": 60.0,
    "latency_pre_ms": 2.1,
    "latency_inf_ms": 24.8,
    "latency_post_ms": 3.6
  },
  "hardware": {
    "cpu_usage_pct": 28.0,
    "gpu_usage_pct": 74.0,
    "ram_usage_mb": 320.0,
    "engine_backend": "YOLOv8 NPU (Qualcomm)"
  }
}
```

*Catatan: Socket receiver di QGroundControl secara otomatis mendukung format bounding box YOLO `xywh_center` `[center_x, center_y, width, height]`, format `xyxy` `[x1, y1, x2, y2]`, maupun standar normalized `xywh` `[x, y, w, h]`.*
