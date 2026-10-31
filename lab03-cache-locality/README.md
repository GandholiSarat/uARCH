# Lab 3: Cache and Memory Locality

**Status: Under development**

## Mission Brief

Use DynamoRIO `drcachesim` to investigate how working sets and access order interact with cache capacity, associativity, and line size.

## What You'll Explore

- Temporal and spatial locality.
- L1/L2 behaviour, capacity, associativity, and cache lines.
- Compulsory and conflict effects.
- The boundary between simulator output and hardware measurement.

## Before You Start

Complete the root setup and verify `drcachesim`. The finished investigation will require simulator configurations, deterministic workloads, and analysis scripts. This lab is not implemented yet.

## Explore

Begin with workloads that vary one property at a time: working-set size, access order, stride, or reuse distance. State the simulator assumptions before interpreting a hit or miss count.

## Build and Run

TODO: add supported configurations, command lines, and output interpretation.

## Investigate

Compare access patterns and configuration changes. Separate capacity pressure from conflict behaviour, and do not present simulator output as a measurement that applies to every CPU.

## What to Look For

No numerical result is asserted yet. The future implementation should make cache configuration and workload assumptions visible alongside every finding.

## Challenge Questions

- Which changes alter capacity pressure versus conflict behaviour?
- How does line size affect spatial locality?
- Why should simulator output not be presented as a measurement of every CPU?

## Deep Dive

Investigate multi-level cache interactions, working-set transitions, and whether two access patterns with similar hit rates produce different architectural stories.
