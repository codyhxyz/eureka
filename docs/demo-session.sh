#!/usr/bin/env bash
# Deterministic simulated session for the eureka hero GIF.
# Driven by docs/demo.tape via `vhs docs/demo.tape`.

set -e

CYAN=$'\033[36m'
DIM=$'\033[2m'
BOLD=$'\033[1m'
RESET=$'\033[0m'

slow_print() {
  local text="$1"
  local delay="${2:-0.025}"
  for (( i=0; i<${#text}; i++ )); do
    printf "%s" "${text:$i:1}"
    sleep "$delay"
  done
  echo
}

printf "%s" "${DIM}user:${RESET} "
slow_print "Tree view lags at 10k+ nodes. Virtualization and memoization aren't cutting it."
sleep 0.6

echo
printf "%s\n" "${CYAN}[eureka] surfacing load-bearing assumptions…${RESET}"
sleep 1.2

cat <<EOF

${BOLD}<assumptions>${RESET}
1. Every visible node must live in the DOM.
2. Layout and hit-testing must run on the main thread.
3. The tree must be stored hierarchically, keyed by node id.
${BOLD}</assumptions>${RESET}

${BOLD}Option A — Conservative${RESET}
Windowed virtualization + row-level memoization; measure before tuning.
Trade-off: 2–4x win on scroll, leaves the architecture intact. Low blast radius.

${BOLD}Option B — Medium${RESET}
Flatten the tree into a contiguous array with parent/next-sibling indices; render a
flat list with absolute positioning. Cache-friendly traversal, O(1) reparenting.
Trade-off: meaningful refactor of the store; ~10x on random-access patterns (estimate).

${BOLD}Option C — Wild${RESET}
Skip the DOM. Render to an OffscreenCanvas in a Web Worker; hit-test against the
flat index with a quadtree. The main thread does input only.
Trade-off: bespoke a11y + text selection, but 60fps at 100k+ nodes is on the table.

${BOLD}Recommendation:${RESET} Ship B. Highest leverage for the smallest blast radius, and
it's the prerequisite that makes C cheap later if you ever need it.
EOF

sleep 3
