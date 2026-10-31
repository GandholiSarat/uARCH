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
    elif [ -d "$ROOT_DIR/.uarch/dynamorio/current" ]; then
        printf '%s\n' "$ROOT_DIR/.uarch/dynamorio/current"
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

if check_dynamorio >/dev/null 2>&1; then
    printf '[PASS] DynamoRIO\n'
    pass_count=$((pass_count + 1))
else
    printf '[FAIL] DynamoRIO\n'
    fail_count=$((fail_count + 1))
fi

# Show the exact installation path so users can invoke drrun directly.
dynamorio_home="$(resolve_dynamorio_home 2>/dev/null || true)"
if [ -n "$dynamorio_home" ]; then
    printf 'DynamoRIO home: %s\n' "$dynamorio_home"
    printf 'drrun: %s/bin64/drrun\n' "$dynamorio_home"
    printf 'drcachesim: %s/tools/drcachesim.drrun64\n' "$dynamorio_home"
    if run_dynamorio "$dynamorio_home" >/dev/null 2>&1; then
        printf '[PASS] DynamoRIO app run\n'
        pass_count=$((pass_count + 1))
    else
        printf '[FAIL] DynamoRIO app run\n'
        fail_count=$((fail_count + 1))
    fi
    if run_drcachesim "$dynamorio_home" >/dev/null 2>&1; then
        printf '[PASS] drcachesim\n'
        pass_count=$((pass_count + 1))
    else
        printf '[FAIL] drcachesim\n'
        fail_count=$((fail_count + 1))
    fi
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
