#!/usr/bin/env bash
set -eu

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)"
: "${DYNAMORIO_HOME:?Set DYNAMORIO_HOME to a DynamoRIO installation}"

cmake -S "$ROOT_DIR/common" -B "$ROOT_DIR/build/common" \
    -DDynamoRIO_DIR="$DYNAMORIO_HOME/cmake"
cmake --build "$ROOT_DIR/build/common" --parallel
