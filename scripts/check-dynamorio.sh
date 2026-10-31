#!/usr/bin/env bash
set -u

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
quiet="${DYNAMORIO_QUIET:-0}"
fail_count=0

say() { [ "$quiet" = 1 ] || printf '%s\n' "$1"; }
pass() { [ "$quiet" = 1 ] || printf '[PASS] %s\n' "$1"; }
fail() { [ "$quiet" = 1 ] || printf '[FAIL] %s\n' "$1"; fail_count=$((fail_count + 1)); }

resolve_home() {
    if [ -n "${DYNAMORIO_HOME:-}" ]; then
        printf '%s\n' "$DYNAMORIO_HOME"
    elif [ -d "$ROOT_DIR/dynamorio" ]; then
        printf '%s\n' "$ROOT_DIR/dynamorio"
    else
        return 1
    fi
}

home="$(resolve_home 2>/dev/null || true)"
if [ -z "$home" ] || [ ! -d "$home" ]; then
    fail 'DynamoRIO installation (set DYNAMORIO_HOME or run ./setup.sh)'
else
    say "DynamoRIO home: $home"
    version="unknown"
    if [ -f "$ROOT_DIR/dynamorio-version.txt" ]; then
        # shellcheck disable=SC1091
        . "$ROOT_DIR/dynamorio-version.txt"
        version="${DYNAMORIO_RELEASE_VERSION:-unknown}"
    fi

    drrun="$home/bin64/drrun"
    cache_tool="$home/tools/drcachesim.drrun64"
    if [ -x "$drrun" ]; then
        pass "drrun ($drrun)"
        if [ "$(uname -s)" = Linux ]; then
            detected_version="$($drrun -version 2>&1 | sed -n '1p' || true)"
            if [ -n "$detected_version" ]; then
                version="$detected_version"
            fi
        fi
    else
        fail "drrun missing or not executable ($drrun)"
    fi
    say "DynamoRIO version: $version"
    if [ -f "$cache_tool" ]; then
        pass "drcachesim ($cache_tool)"
    else
        fail "drcachesim tool missing ($cache_tool)"
    fi
    if [ -f "$home/cmake/DynamoRIOConfig.cmake" ]; then
        pass "DynamoRIO CMake configuration"
    else
        fail "DynamoRIO CMake configuration missing ($home/cmake/DynamoRIOConfig.cmake)"
    fi
    if [ -f "$home/include/dr_api.h" ]; then
        pass "DynamoRIO headers"
    else
        fail "DynamoRIO headers missing ($home/include/dr_api.h)"
    fi
    if [ -f "$home/lib64/release/libdynamorio.so" ]; then
        pass "DynamoRIO libraries"
    else
        fail "DynamoRIO libraries missing ($home/lib64/release/libdynamorio.so)"
    fi
fi

[ "$fail_count" -eq 0 ]
