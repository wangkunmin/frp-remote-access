#!/usr/bin/env bash
# 把 _src/*.html 渲染成 images/*.png（2x 高清）
# 用法: ./shoot.sh <name> [height]
#   例: ./shoot.sh fig1-architecture 880
set -euo pipefail

NAME="${1:?用法: ./shoot.sh <name> [height]}"
HEIGHT="${2:-900}"
SRC="$(cd "$(dirname "$0")" && pwd)"
OUT="$(dirname "$SRC")/images"

# 自动找 Chrome / Chromium（macOS / Linux 都能用）
find_chrome() {
  for c in \
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
    "/Applications/Chromium.app/Contents/MacOS/Chromium" \
    "$(command -v google-chrome 2>/dev/null || true)" \
    "$(command -v google-chrome-stable 2>/dev/null || true)" \
    "$(command -v chromium 2>/dev/null || true)" \
    "$(command -v chromium-browser 2>/dev/null || true)"; do
    if [ -n "$c" ] && [ -x "$c" ]; then echo "$c"; return 0; fi
  done
  return 1
}
CHROME="$(find_chrome)" || { echo "找不到 Chrome/Chromium，请先安装。" >&2; exit 1; }
WIDTH=1600
PROFILE="$(mktemp -d /tmp/chrome-fig.XXXXXX)"
trap 'rm -rf "$PROFILE"' EXIT

mkdir -p "$OUT"
rm -f "$OUT/${NAME}.png"

"$CHROME" \
  --headless=new \
  --disable-gpu \
  --no-sandbox \
  --hide-scrollbars \
  --force-device-scale-factor=2 \
  --user-data-dir="$PROFILE" \
  --virtual-time-budget=4000 \
  --window-size="${WIDTH},${HEIGHT}" \
  --screenshot="$OUT/${NAME}.png" \
  "file://${SRC}/${NAME}.html" 2>/dev/null

if [ -f "$OUT/${NAME}.png" ]; then
  echo "✓ ${OUT}/${NAME}.png  ($(du -h "$OUT/${NAME}.png" | cut -f1))"
else
  echo "✗ 截图失败: ${NAME}" >&2
  exit 1
fi
