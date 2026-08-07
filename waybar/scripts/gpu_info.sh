#!/bin/sh
GPU_NAME=$(lspci | grep -E 'VGA|3D' | cut -d: -f3 | xargs | awk '{print $1,$2}')
if command -v nvidia-smi >/dev/null 2>&1; then
    GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
elif [ -d /sys/class/drm/card0/device/hwmon ]; then
    GPU_USAGE=$(cat /sys/class/drm/card0/device/hwmon/hwmon*/device/gpu_busy_percent 2>/dev/null || echo "0")
else
    GPU_USAGE=$(cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null || echo "0")
fi
echo "${GPU_NAME}: ${GPU_USAGE}%"
