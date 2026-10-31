#!/usr/bin/env bash
set -u

printf 'uARCH environment information\n'
printf 'OS: '; uname -srm
printf 'Machine: '; uname -m
for command_name in gcc g++ cmake make python3 git; do
    if command -v "$command_name" >/dev/null 2>&1; then
        printf '%s: ' "$command_name"
        "$command_name" --version 2>/dev/null | head -n 1
    else
        printf '%s: unavailable\n' "$command_name"
    fi
done
printf 'DYNAMORIO_HOME: %s\n' "${DYNAMORIO_HOME:-unset}"
