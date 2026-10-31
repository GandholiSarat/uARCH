# Installation

## Primary platform

The lab targets 64-bit Ubuntu Linux. macOS and other Unix-like systems can be useful for documentation and workload development, but DynamoRIO support and the scripts should be verified on the student's machine.

## Host packages

```bash
sudo apt update
sudo apt install build-essential cmake make python3 git
```

The repository does not install DynamoRIO or download arbitrary binaries. Obtain a compatible DynamoRIO release from the official project or an approved course mirror, extract it somewhere you control, and configure:

```bash
export DYNAMORIO_HOME="$HOME/opt/DynamoRIO"
```

The directory should contain `include/`, `cmake/`, and, for cache simulation, `bin64/drcachesim`. The scripts also detect common installation locations, but an explicit `DYNAMORIO_HOME` is recommended.

## Verify

```bash
./setup.sh
./test.sh
```

A missing dependency is reported with an actionable installation hint. Setup is repeatable and only creates local `build/`, `results/`, and `traces/` directories.
