#!/bin/bash
# Build + Push + Restart Launcher3 (one-click workflow)
# Usage: ./bpr.sh [apk_path]

set -e

LAUNCHER_DIR="/Users/sihan.zhao/StudioProjects/Launcher3"
DEFAULT_APK="$LAUNCHER_DIR/build/outputs/apk/aospWithQuickstep/debug/Launcher3-aosp-withQuickstep-debug.apk"
APK="${1:-$DEFAULT_APK}"
DEVICE_PATH="/system_ext/priv-app/Launcher3QuickStep/Launcher3QuickStep.apk"
LAUNCHER_PKG="com.android.launcher3"

echo "==> [1/4] Building..."
cd "$LAUNCHER_DIR"
./gradlew assembleAospWithQuickstepDebug

if [ ! -f "$APK" ]; then
    echo "ERROR: APK not found at $APK"
    exit 1
fi

echo "==> [2/4] Root + remount"
adb root >/dev/null 2>&1
adb remount || { echo "ERROR: remount failed. Restart emulator with -writable-system"; exit 1; }

echo "==> [3/4] Pushing APK"
adb push "$APK" "$DEVICE_PATH"

echo "==> [4/4] Restarting Launcher"
adb shell am force-stop "$LAUNCHER_PKG"
sleep 1
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME >/dev/null 2>&1
