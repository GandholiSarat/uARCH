#!/usr/bin/env bash
set -u

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
DEFAULT_DYNAMORIO_HOME="$ROOT_DIR/dynamorio"
DEFAULT_ENV_FILE="$ROOT_DIR/dynamorio/env.sh"

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
		bash "$ROOT_DIR/scripts/install-dynamorio.sh" || dynamorio_status=$?
		if [ "$dynamorio_status" -ne 0 ]; then
			printf '[FAIL] DynamoRIO installation. See docs/troubleshooting.md.\n'
		fi
	fi
else
	printf 'Skipping DynamoRIO installation until host dependencies are fixed.\n'
	dynamorio_status=1
fi

if [ "$dynamorio_status" -eq 0 ]; then
	if [ -z "${DYNAMORIO_HOME:-}" ]; then
		export DYNAMORIO_HOME="$DEFAULT_DYNAMORIO_HOME"
	fi
	export PATH="$DYNAMORIO_HOME/bin64:$PATH"
	printf 'DynamoRIO home: %s\n' "$DYNAMORIO_HOME"
	printf 'drrun: %s/bin64/drrun\n' "$DYNAMORIO_HOME"
	"$ROOT_DIR/scripts/check-dynamorio.sh" || dynamorio_status=$?
fi

mkdir -p "$ROOT_DIR/build" "$ROOT_DIR/results" "$ROOT_DIR/traces"
printf '\nLocal workspace directories are ready: build/, results/, traces/\n'
if [ "$dynamorio_status" -eq 0 ]; then
	printf 'DynamoRIO is ready for this setup process.\n'
	if [ -f "$DEFAULT_ENV_FILE" ]; then
		printf 'For future shells, run: source "%s"\n' "$DEFAULT_ENV_FILE"
	fi
fi
printf 'Run ./test.sh for a complete readiness report.\n'

if [ "$dependency_status" -ne 0 ] || [ "$dynamorio_status" -ne 0 ]; then
	exit 1
fi
