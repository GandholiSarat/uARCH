# Lab 4: Dynamic Instruction-Level Parallelism

**Status: Under development**

## Mission Brief

Collect dynamic operands, model dependencies, estimate critical paths, and explore idealised issue width. The objective is to reason about available instruction-level parallelism without confusing an ideal model with measured throughput.

## What You'll Explore

- Register operands and true dependencies.
- Dependency graphs and critical paths.
- Ideal ILP and issue-width assumptions.
- Limits of trace-derived execution models.

## Before You Start

Complete the root setup. The finished investigation will require a DynamoRIO tracing client, operand analysis, a graph representation, and a Python analyser. This lab is not implemented yet.

## Explore

Start by defining the operand schema and dependency rules. Decide how loads, stores, control flow, and unknown latency should be represented before building a graph.

## Build and Run

TODO: define the trace format, dependency rules, graph format, latency assumptions, and reproducible commands.

## Investigate

Compare sequential work with the longest dependency chain. Explain which dependencies are visible from the trace and which machine constraints are absent from an ideal ILP estimate.

## What to Look For

No numerical result is asserted yet. The future implementation should show how a critical path emerges from the trace and which assumptions connect it to an issue-width estimate.

## Challenge Questions

- Which dependencies are visible from register operands alone?
- How do loads, stores, and control flow complicate the model?
- What assumptions connect a critical path to an issue-width estimate?

## Deep Dive

Compare workloads and add latency or functional-unit constraints. Treat every added constraint as a modelling decision that needs justification.
