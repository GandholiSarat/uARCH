#!/usr/bin/env bash
set -u

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
pass_count=0
fail_count=0

report() {
    label="$1"
    shift
    if "$@" >/dev/null 2>&1; then
        printf '[PASS] %s\n' "$label"
        pass_count=$((pass_count + 1))
    else
        printf '[FAIL] %s\n' "$label"
        fail_count=$((fail_count + 1))
    fi
}

has_command() { command -v "$1" >/dev/null 2>&1; }
check_dynamorio() { DYNAMORIO_QUIET=1 "$ROOT_DIR/scripts/check-dynamorio.sh"; }

printf 'uARCH environment readiness\n===========================\n'
report 'GCC' command -v gcc
report 'CMake' command -v cmake
report 'Make' command -v make
report 'Python' command -v python3
report 'Git' command -v git
report 'DynamoRIO' check_dynamorio
report 'drcachesim' sh -c 'command -v drcachesim >/dev/null 2>&1 || { [ -n "${DYNAMORIO_HOME:-}" ] && [ -x "${DYNAMORIO_HOME}/bin64/drcachesim" ]; }'

printf '\nPassed: %d | Failed: %d\n' "$pass_count" "$fail_count"
if [ "$fail_count" -ne 0 ]; then
    printf 'Environment is not ready. See docs/installation.md and docs/troubleshooting.md.\n'
    exit 1
fi
printf 'Environment is ready for the current repository foundation.\n'
