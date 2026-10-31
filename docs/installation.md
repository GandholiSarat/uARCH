# Installation

## Before You Start

The primary runtime target is 64-bit Ubuntu Linux. macOS and other Unix-like systems can support documentation and workload development, but verify DynamoRIO support on the target machine before tracing.

## Install the Foundation

```bash
sudo apt update
sudo apt install build-essential cmake make python3 git curl
git clone https://github.com/GandholiSarat/uARCH.git
cd uARCH
./setup.sh
./test.sh
```

The default setup downloads the latest official DynamoRIO prebuilt release from the GitHub Releases API. It does not clone or build DynamoRIO from source. The release API endpoint is recorded in `dynamorio-version.txt`, and every archive is checked against GitHub's published SHA-256 digest.

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

## Verify the Environment

```bash
./setup.sh
./test.sh
```

A missing dependency is reported with an actionable installation hint. Setup is repeatable, verifies the archive checksum, and avoids downloading the latest release again when it is already installed. It also creates local `build/`, `results/`, and `traces/` directories.

For source-based development of unreleased DynamoRIO features, see [upstream development](upstream-development.md).
