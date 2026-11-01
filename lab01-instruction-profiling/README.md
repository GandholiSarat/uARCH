# Lab 1: Dynamic Instruction Tracing & Microarchitectural Analysis

## From Instructions to Insights

Don't just run the code. Investigate it. Explore DynamoRIO, build and run its official `instrace_simple.c` sample, collect instruction traces, write your own Python analyser, and use measurements to reason about processor behaviour.

You do **not** write a DynamoRIO client here. The instrumentation comes from the official sample. Your work is understanding the tool, choosing workloads, parsing evidence, and defending conclusions.

## Mission Brief

Get inside a running program. Capture instruction-level execution and uncover what the workload reveals about processor behaviour.

## What You'll Explore

- Dynamic instruction count versus static instruction count.
- Opcode frequency, hot instruction addresses, and instruction mix.
- Workload behaviour across input sizes.
- The boundary between measured evidence and architectural inference.

## Explore

Read the official resources first:

- [DynamoRIO repository](https://github.com/DynamoRIO/dynamorio)
- [DynamoRIO documentation](https://dynamorio.org)
- [DynamoRIO API samples documentation](https://dynamorio.org/API_samples.html)
- [`instrace_simple.c`](https://github.com/DynamoRIO/dynamorio/blob/master/api/samples/instrace_simple.c)

The repository resolves the latest official release through the root `dynamorio-version.txt` configuration. Set up the environment from the repository root, then return here:

```bash
cd ..
./setup.sh
./test.sh
cd lab01-instruction-profiling
```

## Before You Start

Use 64-bit Ubuntu Linux, the latest official DynamoRIO environment, GCC, CMake, Make, and Python 3.

## What the Trace Contains

The sample records a per-thread text trace. Each record contains:

```text
Format: <instr address>,<opcode>
0x7f59c2d002d3,call
```

A PC/opcode trace supports dynamic instruction counts, unique PCs, opcode frequency, hot instruction addresses, and carefully documented broad categories. It does **not** provide operands, register dependencies, actual memory addresses, cache misses, branch outcomes, timing, or hardware counters.

Your first deliverable is a short explanation of how DynamoRIO instruments an application, how `instrace_simple.c` creates the trace, and what its limitations mean for your analysis.

## Build

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

## Run

Make sure you are in the `lab01-instruction-profiling` directory, then run DynamoRIO with your built workloads:

```bash
cd lab01-instruction-profiling
../dynamorio/bin64/drrun -c ../dynamorio/samples/bin64/libinstrace_simple.so -- ./build/workloads/linked_list
```

Anything after `--` is your workload command. You can replace it with any workload binary and arguments, for example:

```bash
../dynamorio/bin64/drrun -c ../dynamorio/samples/bin64/libinstrace_simple.so -- ./build/workloads/matrix_multiplication 8
```

This creates a trace log file, for example:

```text
Data file /path/to/dynamorio/samples/bin64/instrace.linked_list.<pid>.0000.log created
```

The exact path depends on your machine and current working directory.

Use the generated `instrace.*.log` file as input to your analyser in `trace_analyser.py`.

## Investigate

Run your trace files through [trace_analyser.py](trace_analyser.py):

```bash
python3 trace_analyser.py /path/to/instrace.*.log
```

The analyser already parses the trace and reports:
1. Total dynamic instructions.
2. Unique instruction addresses and opcodes.
3. Opcode frequency and top instruction PCs.

### Your Task

Extend [trace_analyser.py](trace_analyser.py) to complete the remaining TODOs:
4. **Categorise opcodes and classify workloads**: Implement `categorize_opcode()` and `classify_workload()`.
5. **Compare across workloads and input sizes**: Trace multiple workloads at different input sizes and analyse how the instruction profile changes.

Keep the analyser honest. For example, an opcode-only trace cannot reliably identify every `mov` as a load, store, or register move. It also cannot prove cache behaviour or branch prediction accuracy.

## Challenge Questions

Answer all ten questions in [questions.md](questions.md) for each selected workload.

## What to Ship

Ship the workload source and build commands, DynamoRIO commands, your analyser, a representative trace or reproducible trace instructions, and evidence-backed findings about what the trace can and cannot reveal.


## Deep Dive

Extend your investigation beyond synthetic microbenchmarks to real-world workloads, such as the [STREAM benchmark](https://www.cs.virginia.edu/stream/) or standard Unix utilities. Observe how memory-intensive streaming kernels, compiler vectorisation, and optimization levels (e.g., `-O0` vs `-O2`/`-O3`) impact dynamic instruction count, loop structures, and opcode distributions.

## Key Takeaways

Trace real execution, analyse the instruction stream, and keep every architectural claim tied to what the trace can actually measure.


