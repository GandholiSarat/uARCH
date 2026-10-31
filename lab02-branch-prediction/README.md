# Lab 2: Branch Prediction

**Status: Under development**

## Objective

Trace dynamic branches and evaluate always-taken, 1-bit, and 2-bit saturating-counter predictors.

## Background

Branches create control-flow decisions. Predictors use recent history to guess an outcome so execution can continue speculatively; prediction accuracy depends on the branch pattern and predictor state.

## Architecture Concepts

Branch outcomes, prediction accuracy, predictor state, warm-up behavior, and hysteresis in saturating counters.

## Prerequisites and Tools

Complete the root setup. Future work will require DynamoRIO, a branch-tracing client, deterministic workloads, and a Python analysis tool.

## Experiment Overview

TODO: define trace format, predictor initialization, and workload matrix.

## Instructions

Coming Soon. No predictor implementation is included yet.

## Expected Observations

Students should eventually compare predictor accuracy across patterns and explain why two-bit state can resist a single unusual outcome. No numerical results are asserted yet.

## Questions for Students

- Which patterns defeat an always-taken predictor?
- How does initialization affect reported accuracy?
- What information is lost when outcomes are aggregated?

## Further Exploration

TODO: compare per-branch and global histories.
