#!/usr/bin/env bash
# KSP-STC launcher: starts KSP, then opens Kerbol Scope in your browser as soon as
# Telemachus starts answering. Steam launch options:
#     /path/to/stc-launch.sh %command%
# Or run directly:   ./stc-launch.sh /path/to/KSP.x86_64
# Settings (environment variables): STC_URL, STC_TIMEOUT (seconds, default 600)
set -u
URL="${STC_URL:-http://localhost:8085/telemachus/kerbol-scope.html}"
TIMEOUT="${STC_TIMEOUT:-600}"
if [ "$#" -eq 0 ]; then echo "usage: $0 <game command...>" >&2; exit 2; fi

open_url() {
  if command -v xdg-open >/dev/null 2>&1; then xdg-open "$1" >/dev/null 2>&1 &
  elif command -v open >/dev/null 2>&1; then open "$1"
  else echo "KSP-STC: open $1 in your browser" >&2; fi
}

"$@" &
GAME=$!
(
  waited=0
  while [ "$waited" -lt "$TIMEOUT" ] && kill -0 "$GAME" 2>/dev/null; do
    if curl -fsS -o /dev/null --max-time 2 "$URL" 2>/dev/null; then open_url "$URL"; exit 0; fi
    sleep 3; waited=$((waited + 3))
  done
) &
wait "$GAME"
