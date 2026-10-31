# Getting Started

## Mission Brief

Get the environment ready, then move quickly from setup to a real execution question.

```bash
git clone https://github.com/GandholiSarat/uARCH.git
cd uARCH
./setup.sh
./test.sh
```

Setup installs the latest official DynamoRIO package under `.uarch/dynamorio/` in this repository. For an existing installation, export `DYNAMORIO_HOME` before running setup. Start with the [lab overview](lab-overview.md), then choose a workload and frame a question you can answer with evidence. Lab 1 is the first active investigation; Labs 2-4 are being developed. Future client builds belong in `common/`, with generated files under `build/`, `results/`, or `traces/`.

## Build a Baseline

Compile a small workload with `gcc`, then record its command, input, compiler version, and machine details using `scripts/environment-info.sh`. Treat that baseline as the first piece of evidence in your investigation.
