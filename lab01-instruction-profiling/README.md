# Lab 1: Dynamic Instruction Tracing & Microarchitectural Analysis

## From Instructions to Insights

This lab is a student-driven investigation into real program execution. You will explore DynamoRIO, build and run its official `instrace_simple.c` sample, collect instruction traces, write your own Python analyser, and use measurements to reason about processor behaviour.

Students do **not** write a DynamoRIO client here. The instrumentation comes from the official sample. Your work is understanding the tool, choosing workloads, parsing evidence, and defending conclusions.

## Start Here

Read the official resources first:

- [DynamoRIO repository](https://github.com/DynamoRIO/dynamorio)
- [DynamoRIO documentation](https://dynamorio.org)
- [DynamoRIO API samples documentation](https://dynamorio.org/API_samples.html)
- [`instrace_simple.c`](https://github.com/DynamoRIO/dynamorio/blob/master/api/samples/instrace_simple.c)

The repository pins a release in the root `dynamorio-version.txt`. Set up the environment from the repository root, then return here:

```bash
cd ..
./setup.sh
./test.sh
cd lab01-instruction-profiling
```

## What You Investigate

The sample records a per-thread text trace. Each record contains:

```text
Format: <instr address>,<opcode>
0x7f59c2d002d3,call
```

A PC/opcode trace supports dynamic instruction counts, unique PCs, opcode frequency, hot instruction addresses, and carefully documented broad categories. It does **not** provide operands, register dependencies, actual memory addresses, cache misses, branch outcomes, timing, or hardware counters.

Your first deliverable is a short explanation of how DynamoRIO instruments an application, how `instrace_simple.c` creates the trace, and what its limitations mean for your analysis.

## Workloads

The four starting points are intentionally small and portable:

| File | Starting question |
| --- | --- |
| `workloads/matrix_multiplication.c` | How do compute and data reuse appear in a loop-heavy program? |
| `workloads/sorting.c` | How do comparisons, branches, and data movement change with input size? |
| `workloads/linked_list.c` | What does pointer chasing look like in dynamic instruction behaviour? |
| `workloads/branch_intensive.c` | How much execution is associated with control-flow decisions? |

Compile them with configurable input sizes:

```bash
mkdir -p build/workloads
for source in workloads/*.c; do
    name="$(basename "$source" .c)"
    gcc -std=c11 -O0 -g -Wall -Wextra "$source" -o "build/workloads/$name"
done
./build/workloads/matrix_multiplication 8
```

You may write a custom C workload when it gives you a better performance question. Record the source, compiler flags, and inputs.

## Build and Run the Official Sample

The sample source is maintained by DynamoRIO, so students can inspect and build it directly from the official repository. Use the same pinned tag as the repository setup:

```bash
export DYNAMORIO_HOME="$HOME/.uarch/dynamorio/current"
export DR_SOURCE="$HOME/src/dynamorio"
export DR_BUILD="$HOME/build/dynamorio-samples"

git clone --branch cronbuild-11.91.20756 --depth 1 \
    https://github.com/DynamoRIO/dynamorio.git "$DR_SOURCE"
cmake -S "$DR_SOURCE/api/samples" -B "$DR_BUILD" \
    -DDynamoRIO_DIR="$DYNAMORIO_HOME/cmake"
cmake --build "$DR_BUILD" --target instrace_simple --parallel

find "$DR_BUILD" -type f -name 'libinstrace_simple.so' -print
```

Build the workloads first, then run the sample directly:

```bash
mkdir -p traces
CLIENT="$(find "$DR_BUILD" -type f -name 'libinstrace_simple.so' -print -quit)"
"$DYNAMORIO_HOME/bin64/drrun" \
    -quiet -logdir "$PWD/traces" \
    -c "$CLIENT" -- \
    "$PWD/build/workloads/matrix_multiplication" 8
```

Inspect every generated `instrace*` file before writing your analyser. Keep a small representative trace or record exact reproducible generation commands. The sample writes per-thread files and has no instruction-count limit; control size with workload inputs. Do not silently truncate or merge away evidence.

## Write Your Analyser

Write your own analyser in [trace_analyser.py](trace_analyser.py). Begin by parsing the header and `PC,opcode` records, then add measurements in stages:

1. Total dynamic instructions.
2. Unique instruction addresses and opcodes.
3. Opcode frequency and top instruction PCs.
4. Broad categories with documented rules and an explicit unknown fallback.
5. CSV summaries and charts.
6. Comparisons across workloads and input sizes.

Keep the analyser honest. For example, an opcode-only trace cannot reliably identify every `mov` as a load, store, or register move. It also cannot prove cache behaviour or branch prediction accuracy.

## Questions and Submission

Answer all ten questions in [questions.md](questions.md) for each selected workload. Submit workload source and build commands, DynamoRIO commands, your analyser, a representative trace or reproducible trace instructions, CSVs/charts, and a conclusion about what the trace can and cannot reveal.

AI assistance is allowed for documentation, workload code, parser code, and debugging. You must understand your own parsing logic, data structures, classification rules, and results. Be prepared to explain one function, modify one metric, and defend one conclusion from your trace.

## Optional Advanced Work

After the primary path, inspect `instrace_x86.c` and consider what richer operands or memory-reference information would enable. Do not implement Labs 2, 3, or 4 here.

The maintainer's macOS environment can validate the workload and analyser scaffolding, but the pinned Linux DynamoRIO client build and real trace generation require Ubuntu x86-64.
