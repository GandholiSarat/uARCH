#!/usr/bin/env bash
set -u

quiet="${DYNAMORIO_QUIET:-0}"
fail() { [ "$quiet" = 1 ] || printf '[FAIL] %s\n' "$1"; return 1; }
pass() { [ "$quiet" = 1 ] || printf '[PASS] %s\n' "$1"; }

home="${DYNAMORIO_HOME:-}"
if [ -n "$home" ]; then
    if [ ! -d "$home" ]; then fail "DynamoRIO (DYNAMORIO_HOME does not exist: $home)"; exit 1; fi
    if [ ! -d "$home/include" ] || [ ! -d "$home/cmake" ]; then
        fail "DynamoRIO (expected include/ and cmake/ under $home)"; exit 1
    fi
    pass "DynamoRIO ($home)"
else
    found=""
    for candidate in /usr/local/DynamoRIO* /opt/DynamoRIO* "$HOME"/DynamoRIO*; do
        if [ -d "$candidate/include" ] && [ -d "$candidate/cmake" ]; then found="$candidate"; break; fi
    done
    if [ -n "$found" ]; then
        pass "DynamoRIO ($found; consider exporting DYNAMORIO_HOME)"
    else
        fail 'DynamoRIO (set DYNAMORIO_HOME=/path/to/DynamoRIO)'; exit 1
    fi
fi

if command -v drcachesim >/dev/null 2>&1; then
    pass "drcachesim ($(command -v drcachesim))"
elif [ -n "$home" ] && [ -x "$home/bin64/drcachesim" ]; then
    pass "drcachesim ($home/bin64/drcachesim)"
else
    [ "$quiet" = 1 ] || printf '[WARN] drcachesim not found; install a DynamoRIO distribution containing it.\n'
fi
