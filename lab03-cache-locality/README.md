# Lab 3: Cache & Memory Locality

**Status: Under development**

## Objective

Use DynamoRIO `drcachesim` to study cache configurations, locality, and hit/miss behavior.

## Background

Caches exploit temporal and spatial locality. Capacity, associativity, and cache-line size influence which accesses hit or miss for a given working set and access order.

## Architecture Concepts

L1/L2 behavior, cache capacity, associativity, line size, compulsory and conflict effects, and temporal versus spatial locality.

## Prerequisites and Tools

Complete the root setup and verify `drcachesim`. Future work will require simulator configuration files, deterministic workloads, and analysis scripts.

## Experiment Overview

TODO: add supported configurations, command lines, and output interpretation.

## Instructions

Coming Soon. No cache experiment is implemented yet.

## Expected Observations

Students should eventually compare access patterns and configuration changes while separating simulator assumptions from hardware measurements. No numerical results are asserted yet.

## Questions for Students

- Which changes alter capacity pressure versus conflict behavior?
- How does line size affect spatial locality?
- Why should simulator results not be presented as measurements of every CPU?

## Further Exploration

TODO: investigate multi-level cache interactions and working-set transitions.
