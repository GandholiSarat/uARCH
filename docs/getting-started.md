# Getting Started

```bash
git clone https://github.com/<organization>/uarch-dynamorio-workshop.git
cd uarch-dynamorio-workshop
export DYNAMORIO_HOME=/path/to/DynamoRIO
./setup.sh
./test.sh
```

Start by reading the [lab overview](workshop-overview.md), then inspect the workload descriptions and lab templates. The foundation currently contains no working instrumentation clients or lab solutions. Future client builds should use `common/` and keep generated files under `build/`, `results/`, or `traces/`.

A useful first exercise before the labs are implemented is to compile a small workload with `gcc` and record its command, input, compiler version, and machine details using `scripts/environment-info.sh`.
