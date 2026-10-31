# Lab 4: Dynamic Instruction-Level Parallelism

**Status: Under development**

## Objective

Collect dynamic instruction operands, construct dependency information, estimate critical paths, and explore idealized issue width.

## Background

Instructions that are independent may overlap in an ideal machine, while dependencies constrain execution. A dependency graph and critical path provide a model of available instruction-level parallelism, subject to explicitly stated simplifications.

## Architecture Concepts

Register operands, true dependencies, dependency graphs, critical paths, ideal ILP, issue width, and limits of trace-derived models.

## Prerequisites and Tools

Complete the root setup. Future work will require a DynamoRIO tracing client, operand analysis, a graph representation, and a Python analyzer.

## Experiment Overview

TODO: define operand schema, dependency rules, graph format, and issue-width model.

## Instructions

Coming Soon. No tracing or dependency implementation is included yet.

## Expected Observations

Students should eventually compare sequential work with the longest dependency chain and explain why ideal ILP is not a direct prediction of measured throughput. No numerical results are asserted yet.

## Questions for Students

- Which dependencies are visible from register operands alone?
- How do loads, stores, and control flow complicate the model?
- What assumptions connect a critical path to an issue-width estimate?

## Further Exploration

TODO: compare workloads and add latency or functional-unit constraints.
