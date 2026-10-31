#!/usr/bin/env bash
set -u

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

printf 'uARCH environment setup\n========================\n'
printf 'Repository: %s\n\n' "$ROOT_DIR"

dependency_status=0
"$ROOT_DIR/scripts/check-dependencies.sh" || dependency_status=$?
printf '\n'
dynamorio_status=0
"$ROOT_DIR/scripts/check-dynamorio.sh" || dynamorio_status=$?

mkdir -p "$ROOT_DIR/build" "$ROOT_DIR/results" "$ROOT_DIR/traces"
printf '\nLocal workspace directories are ready: build/, results/, traces/\n'
printf 'No compilers, packages, or binaries were installed.\n'
printf 'Run ./test.sh for a readiness report.\n'

if [ "$dependency_status" -ne 0 ] || [ "$dynamorio_status" -ne 0 ]; then
	exit 1
fi
