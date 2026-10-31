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

check_dynamorio() { DYNAMORIO_QUIET=1 "$ROOT_DIR/scripts/check-dynamorio.sh"; }
resolve_dynamorio_home() {
    if [ -n "${DYNAMORIO_HOME:-}" ]; then
        printf '%s\n' "$DYNAMORIO_HOME"
    elif [ -d "$HOME/.uarch/dynamorio/current" ]; then
        printf '%s\n' "$HOME/.uarch/dynamorio/current"
    else
        return 1
    fi
}
run_dynamorio() {
    home="$1"
    "$home/bin64/drrun" -quiet -- /bin/true
}
run_drcachesim() {
    home="$1"
    "$home/bin64/drrun" -quiet -t drcachesim -- /bin/true
}

printf 'uARCH environment readiness\n===========================\n'
report 'GCC' command -v gcc
report 'CMake' command -v cmake
report 'Make' command -v make
report 'Python' command -v python3
report 'Git' command -v git
report 'DynamoRIO' check_dynamorio
dynamorio_home="$(resolve_dynamorio_home 2>/dev/null || true)"
if [ -n "$dynamorio_home" ]; then
    report 'DynamoRIO app run' run_dynamorio "$dynamorio_home"
    report 'drcachesim' run_drcachesim "$dynamorio_home"
else
    printf '[FAIL] DynamoRIO app run\n'
    printf '[FAIL] drcachesim\n'
    fail_count=$((fail_count + 2))
fi

printf '\nPassed: %d | Failed: %d\n' "$pass_count" "$fail_count"
if [ "$fail_count" -ne 0 ]; then
    printf 'Environment is not ready. See docs/installation.md and docs/troubleshooting.md.\n'
    exit 1
fi
printf 'Environment is ready for the current repository foundation.\n'
