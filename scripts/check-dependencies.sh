#!/usr/bin/env bash
set -u

missing=0
check() {
    name="$1"
    command_name="$2"
    if command -v "$command_name" >/dev/null 2>&1; then
        printf '[PASS] %-8s %s\n' "$name" "$(command -v "$command_name")"
    else
        printf '[FAIL] %-8s command not found: %s\n' "$name" "$command_name"
        missing=$((missing + 1))
    fi
}

printf 'Host dependencies\n------------------\n'
check GCC gcc
check G++ g++
check CMake cmake
check Make make
check Python python3
check Git git

if [ "$missing" -ne 0 ]; then
    printf '\nUbuntu: sudo apt update && sudo apt install build-essential cmake make python3 git\n'
    exit 1
fi
