# Investigation Overview

## The uARCH Loop

1. Choose a small workload and fixed input.
2. Instrument or simulate its dynamic execution.
3. Collect a trace or summary.
4. Analyse the data with an explicit model.
5. Compare findings, explain limitations, and ask what investigation would distinguish competing explanations.

The lab series moves from instruction and basic-block counts through branch prediction and cache locality to dependency-based instruction-level parallelism. Lab 1 is the first active investigation; the later lab directories are templates with future work clearly marked.

Record commands, versions, inputs, configuration, and observations so findings are reproducible. Instructor reference solutions are intentionally not part of this public repository.

## What to Look For

Keep the line between measurement and inference visible. A trace is evidence about a particular binary and input, not a complete explanation of processor performance.
