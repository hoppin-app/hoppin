#!/usr/bin/env bash
#
# setup.sh — get a fresh hoppin checkout ready to work in.
#
#   1. fetches every submodule (ios, server, website, lib, docs)
#   2. makes git pull / checkout keep them in step from now on
#   3. creates server/venv with the server's requirements
#
# Safe to run again.
#
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

log "fetching submodules"
git submodule update --init --recursive

log "making pull and checkout update submodules (this repo only)"
git config submodule.recurse true

# Each folder follows the parent's branch (`branch = .` in .gitmodules).
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
log "checking out '$BRANCH' in every submodule"
git submodule foreach --quiet "git checkout --quiet '$BRANCH' 2>/dev/null || echo \"  \$name: no '$BRANCH' branch, staying detached\""

PYTHON="${PYTHON:-python3}"
if [[ ! -x server/venv/bin/python ]]; then
    log "creating server/venv"
    "$PYTHON" -m venv server/venv
fi
log "installing the server's requirements"
server/venv/bin/pip install --quiet -r server/requirements.txt

log "done. Next: open ios/HopChat-1.xcodeproj, or run lib/run_tests.sh"
