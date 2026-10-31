# DynamoRIO Introduction

DynamoRIO is a dynamic binary instrumentation framework. It observes and optionally transforms machine-code execution at runtime, allowing a client to inspect instructions, basic blocks, memory references, and control flow without changing the original source program.

For this lab, the important distinction is:

- **Static analysis** reasons about the binary or source without running it.
- **Dynamic instrumentation** observes the paths and events that actually occur for a particular input.
- **Microarchitectural modeling** uses observations plus a stated model to estimate behavior; it is not identical to measuring hardware counters.

Future clients should use the DynamoRIO CMake package and avoid hardcoded paths. The expected installation boundary is `DYNAMORIO_HOME`, with headers under `include/`, CMake support under `cmake/`, and tools such as `drcachesim` under the distribution's `bin64/` directory.
