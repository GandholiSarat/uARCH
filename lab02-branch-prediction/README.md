# Lab 2: Branch Prediction

**Status: Under development**

## Mission Brief

Trace dynamic branch behaviour and build a compact predictor model. The goal is to connect branch patterns, predictor state, and accuracy to the control flow you can observe in real workloads.

## What You'll Explore

- Branch outcomes and dynamic control flow.
- Always-taken, 1-bit, and 2-bit saturating-counter predictors.
- Warm-up behaviour, hysteresis, and prediction accuracy.
- The difference between a trace-derived model and hardware behaviour.

## Before You Start

Complete the root setup. The finished investigation will require DynamoRIO, a branch-tracing client, deterministic workloads, and a Python analysis tool. This lab is not implemented yet.

## Explore

Start with a workload that produces a visible pattern of taken and not-taken branches. Identify what information a branch trace must preserve and how predictor initialization affects the first predictions.

## Build and Run

TODO: define the trace format, predictor initialization, workload matrix, and reproducible commands.

## Investigate

Compare prediction accuracy across patterns. Explain why a 2-bit counter can resist a single unusual outcome and identify which details are lost when outcomes are aggregated.

## What to Look For

No numerical result is asserted yet. The future implementation should make warm-up, per-branch behaviour, and predictor state visible rather than presenting one unexplained accuracy number.

## Challenge Questions

- Which patterns defeat an always-taken predictor?
- How does initialization affect reported accuracy?
- What information disappears when branch outcomes are aggregated?

## Deep Dive

Compare per-branch history with global history and test patterns that have the same taken rate but different orderings.
