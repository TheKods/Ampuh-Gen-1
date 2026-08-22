# AMPUH Gen 1 GCS (Tactical UAV Ground Control Station)

Software Ground Control Station kustom berbasis QGroundControl dengan branding, tema warna, HUD instrumen, dan konfigurasi wahana mandiri.

## 🚀 Fitur Utama AMPUH Gen 1:
- **Branding & Visual Mandiri**: Nama aplikasi `AMPUH Gen 1`, logo vektor taktis, dan identitas brand `id.ampuh.gen1`.
- **AMPUH Tactical Cyber-Dark Theme**: Palet warna kontras tinggi yang dioptimalkan untuk pengoperasian di lapangan (Cyber Cyan, Stealth Slate, Emerald Green, Alert Amber).
- **Tactical Flight HUD (FlyView)**:
  - Top Compass Heading Ribbon digital (0° - 360° dengan pembacaan N, NE, E, SE, S, SW, W, NW).
  - Telemetry Quick Status Bar (Mode terbang, Status Armed/Disarmed, Ketinggian, Kecepatan, Jarak Home, Baterai).
  - Attitude & Artificial Horizon Indicator terintegrasi.
- **Konfigurasi Wahana Teroptimasi**: Setup esensial (Sensors, Radio, Flight Modes, Power, Safety) selalu tersedia, dengan fitur advanced (Airframe, Motor testing, PID Tuning) dalam Advanced Mode.

## 🛠️ Cara Build:
Proyek akan otomatis mendeteksi folder `custom/` saat melakukan build:
```bash
just configure
just build
```
atau via CMake langsung:
```bash
cmake -B build -S .
cmake --build build --config Release
```
