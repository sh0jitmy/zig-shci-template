#!/usr/bin/env bash
set -eu

# version.zigのバージョン定数から先頭vを削除し、build.zig.zonの.versionを更新する
# Usage: ./update-version.sh

ROOT_DIR=$(cd "$(dirname "$0")" && pwd)
VERSION_FILE="$ROOT_DIR/src/version.zig"
ZON_FILE="$ROOT_DIR/build.zig.zon"

if [ ! -f "$VERSION_FILE" ]; then
  echo "error: $VERSION_FILE not found" >&2
  exit 1
fi
if [ ! -f "$ZON_FILE" ]; then
  echo "error: $ZON_FILE not found" >&2
  exit 1
fi

# version stringを取得
VERSION_FULL=$(grep -E 'pub const version\s*=\s*"' "$VERSION_FILE" | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')
if [ -z "$VERSION_FULL" ]; then
  echo "error: version string not found in $VERSION_FILE" >&2
  exit 1
fi

# vプレフィックス除去
VERSION_STRIPPED=${VERSION_FULL#v}

if [ "$VERSION_STRIPPED" = "$VERSION_FULL" ]; then
  echo "info: version has no leading 'v': $VERSION_FULL"
else
  echo "info: stripping leading 'v' from version: $VERSION_FULL -> $VERSION_STRIPPED"
fi

# build.zig.zonを更新（sed）
# src/version.zig のプレフィックス除去結果で上書き
#REPLACE_EXPR="s@(\\.version\\s*=\\s*\")[^\"]+\"@\\1${VERSION_STRIPPED}\"@"
REPLACE_EXPR="s@(\\.version[[:space:]]*=[[:space:]]*\")[^\"]+\"@\\1${VERSION_STRIPPED}\"@"
#if sed --version >/dev/null 2>&1; then
#  sed -E -i "$REPLACE_EXPR" "$ZON_FILE"
#else
#  sed -E -i '' "$REPLACE_EXPR" "$ZON_FILE"
#fi

echo "=== BEFORE ==="
grep '\.version' "$ZON_FILE"

echo "=== sed test ==="
sed -E "$REPLACE_EXPR" "$ZON_FILE" | grep '\.version'




if command -v gsed >/dev/null 2>&1; then
  SED=gsed
  SED_INPLACE=(-i)
else
  SED=sed
  SED_INPLACE=(-i '')
fi

"$SED" -E "${SED_INPLACE[@]}" "$REPLACE_EXPR" "$ZON_FILE"


cat <<EOF
updated:
  $ZON_FILE: .version = "$VERSION_STRIPPED"
EOF
