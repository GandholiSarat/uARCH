#!/usr/bin/env bash
set -u

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

printf 'uARCH environment setup\n========================\n'
printf 'Repository: %s\n\n' "$ROOT_DIR"

dependency_status=0
"$ROOT_DIR/scripts/check-dependencies.sh" || dependency_status=$?
printf '\n'

dynamorio_status=0
if [ "$dependency_status" -eq 0 ]; then
	if [ -n "${DYNAMORIO_HOME:-}" ]; then
		printf 'Using custom DynamoRIO installation from DYNAMORIO_HOME.\n'
	else
		"$ROOT_DIR/scripts/install-dynamorio.sh" || dynamorio_status=$?
	fi
else
	printf 'Skipping DynamoRIO installation until host dependencies are fixed.\n'
	dynamorio_status=1
fi

if [ "$dynamorio_status" -eq 0 ]; then
	if [ -z "${DYNAMORIO_HOME:-}" ]; then
		export DYNAMORIO_HOME="$HOME/.uarch/dynamorio/current"
	fi
	export PATH="$DYNAMORIO_HOME/bin64:$PATH"
	"$ROOT_DIR/scripts/check-dynamorio.sh" || dynamorio_status=$?
fi

mkdir -p "$ROOT_DIR/build" "$ROOT_DIR/results" "$ROOT_DIR/traces"
printf '\nLocal workspace directories are ready: build/, results/, traces/\n'
if [ "$dynamorio_status" -eq 0 ]; then
	printf 'DynamoRIO is ready for this setup process.\n'
	if [ -f "$HOME/.uarch/dynamorio/env.sh" ]; then
		printf 'For future shells, run: source "$HOME/.uarch/dynamorio/env.sh"\n'
	fi
fi
printf 'Run ./test.sh for a complete readiness report.\n'

if [ "$dependency_status" -ne 0 ] || [ "$dynamorio_status" -ne 0 ]; then
	exit 1
fi
