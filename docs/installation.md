# Installation

## Primary platform

The lab targets 64-bit Ubuntu Linux. macOS and other Unix-like systems can be useful for documentation and workload development, but DynamoRIO support and the scripts should be verified on the student's machine.

## Host packages

```bash
sudo apt update
sudo apt install build-essential cmake make python3 git curl
git clone https://github.com/GandholiSarat/uARCH.git
cd uARCH
./setup.sh
./test.sh
```

The default setup downloads one pinned official DynamoRIO prebuilt release. It does not clone or build DynamoRIO from source, and it does not download an unpinned latest version. The pinned tag and SHA-256 digest are recorded in `dynamorio-version.txt`.

```bash
source "$HOME/.uarch/dynamorio/env.sh"
```

To use an existing approved installation instead, skip the download and run:

```bash
export DYNAMORIO_HOME=/path/to/DynamoRIO-Linux-11.91.20756
./setup.sh
./test.sh
```

The expected installation contains `bin64/drrun`, `tools/drcachesim.drrun64`, `include/dr_api.h`, `cmake/DynamoRIOConfig.cmake`, and `lib64/release/libdynamorio.so`.

## Verify

```bash
./setup.sh
./test.sh
```

A missing dependency is reported with an actionable installation hint. Setup is repeatable, verifies the archive checksum, and avoids downloading an already installed pinned release. It also creates local `build/`, `results/`, and `traces/` directories.

For source-based development of unreleased DynamoRIO features, see [upstream development](upstream-development.md).
