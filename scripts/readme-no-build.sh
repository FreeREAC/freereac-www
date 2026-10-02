#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# scripts/readme-no-build.sh [README.md] [--self-test]
#
# The README is the pitch and the install; the build lives in BUILDING.md. This fails when
# the README's code (fenced blocks and inline `spans`) names a build command, so build steps
# cannot drift back onto it. Prose is not read: "make sure" is not a command.
# Run by `npm run generate` (pregenerate) and `npm test`.
set -uo pipefail

BUILD='(^|[^[:alnum:]_.-])(make|meson|cmake|ninja|rpmbuild|mock|cargo build|go build|(npm|pnpm|yarn)( run)? (build|generate|dev|preview|ci|install)|nuxi? (build|generate|dev|preview))([^[:alnum:]_-]|$)'

# <file>: prints the README's code, one line per fenced line or inline span.
readme_code() {
  awk '
    /^[[:space:]]*(```|~~~)/ { fenced = !fenced; next }
    fenced { print; next }
    {
      line = $0
      while (match(line, /`[^`]+`/)) {
        print substr(line, RSTART + 1, RLENGTH - 2)
        line = substr(line, RSTART + RLENGTH)
      }
    }
  ' "$1"
}

check() { # <file>
  local hits
  [ -f "$1" ] || { echo "README-NO-BUILD FAIL: no $1"; return 1; }
  hits=$(readme_code "$1" | grep -E "$BUILD")
  if [ -n "$hits" ]; then
    echo "README-NO-BUILD FAIL: $1 names a build command; move it to BUILDING.md:"
    printf '%s\n' "$hits" | sed 's/^/  /'
    return 1
  fi
  echo "README-NO-BUILD OK $1"
}

self_test() {
  local d ok=1
  d=$(mktemp -d)
  st() { # <name> <expect 0|1> <content>
    printf '%s\n' "$3" > "$d/README.md"
    if check "$d/README.md" > /dev/null; then got=0; else got=1; fi
    if [ "$got" = "$2" ]; then echo "ok   self-test: $1"; else echo "FAIL self-test: $1"; ok=0; fi
  }
  st "a fenced npm run generate is refused" 1 $'# x\n\n```\nnpm install\nnpm run generate\n```'
  st "an inline make is refused" 1 'Run `make` in the top directory.'
  st "a fenced meson setup is refused" 1 $'~~~sh\nmeson setup build\n~~~'
  st "an indented fence is still read" 1 $'  ```\n  rpmbuild -ba x.spec\n  ```'
  st "prose is not read: make sure" 0 'Make sure the stagebox is on the network, then build nothing.'
  st "a user install command passes" 0 $'```\nsudo dnf install reac-pw\n```'
  st "a path that contains a command word passes" 0 'See `.github/workflows/pages.yml` and `docs/make-notes`.'
  rm -rf "$d"
  if [ $ok = 1 ]; then echo "SELF-TEST OK"; return 0; fi
  echo "SELF-TEST FAILED"; return 1
}

case "${1:-}" in
  --self-test) self_test ;;
  *) check "${1:-README.md}" ;;
esac
