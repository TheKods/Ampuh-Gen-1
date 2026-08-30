# Fix Android build by gating missing QOffscreenIntegrationPlugin

The `Qt6::QOffscreenIntegrationPlugin` is included unconditionally in the main `CMakeLists.txt`. However, this plugin is typically not available in Android Qt distributions, leading to build failures. This change gates the inclusion of the plugin using a target existence check, which is the idiomatic way to handle optional Qt plugins in CMake.

## Proposed Changes

### Build System

#### [MODIFY] [CMakeLists.txt](file:///C:/Project/qgroundcontrol-master/CMakeLists.txt)

- Separate `Qt6::QOffscreenIntegrationPlugin` from the mandatory `qt_import_plugins` block.
- Add a conditional check `if(TARGET Qt6::QOffscreenIntegrationPlugin)` before importing it.
- Keep `Qt6::QSvgPlugin` in the main block as it's generally available and required.

## Verification Plan

### Automated Tests
- Run `just configure` for a desktop platform to ensure the plugin is still imported when available.
- Run `just build` for the Android target to verify the "not known to the current Qt installation" error is resolved.

### Manual Verification
- Verify that unit tests (which use the offscreen platform) still function correctly on desktop.
