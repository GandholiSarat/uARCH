# Lab 1: Dynamic Instruction & Hot-Code Profiling

**Status: Under development**

## Objective

Measure and interpret dynamic instruction execution, instruction classes, basic-block activity, and hot code.

## Background

Static instruction counts describe a binary; dynamic counts describe the instructions executed for one input. Basic blocks provide a compact view of control-flow execution, while hot-code analysis identifies frequently executed regions.

## Architecture Concepts

Instruction mix, dynamic frequency, basic blocks, control flow, hot paths, and the difference between static and dynamic behavior.

## Prerequisites and Tools

Complete the root setup. Future work will require DynamoRIO, a client build, a C/C++ workload, and a small analysis script.

## Experiment Overview

TODO: add the client, workload commands, output schema, and analysis procedure.

## Instructions

Coming Soon. No experiment is implemented in this repository version.

## Expected Observations

Students should eventually compare instruction categories and identify whether a small part of a workload accounts for a large fraction of dynamic execution. No numerical results are asserted yet.

## Questions for Students

- How does input size change the dynamic instruction mix?
- What makes a basic block hot, and what does that not tell you?
- Which conclusions depend on compiler options?

## Further Exploration

TODO: compare workloads, optimization levels, and hotness thresholds.
