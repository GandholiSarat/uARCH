# Lab 1: Architectural Investigation & Performance Decision Questions

Answer every question based on your workload measurements, trace analysis, and architectural reasoning. Support your answers with concrete trace metrics, commands, and empirical evidence.

---

## Part 1: Workload Characterisation & Trace Analysis

### Question 1: Dynamic Execution Scaling vs. Static Code Footprint
Compare the static instruction count in the compiled binary (e.g., using `objdump -d` or `size`) with the dynamic instruction count from your trace.
- How does the dynamic instruction count scale as you increase workload input sizes (e.g., $N=8, 16, 64$)? Is the growth linear, polynomial ($O(N^2), O(N^3)$), or logarithmic?
- Explain how inner-loop execution and repetition explain the gap between static and dynamic instruction counts.

### Question 2: Dominant Opcodes & Computational Characterisation
Examine the top opcodes and overall instruction mix produced by your analyser for each workload.
- Which specific opcodes dominate execution (e.g., `mov`, `add`, `cmp`, `jne`)?
- How does the dynamic opcode breakdown distinguish compute-intensive, memory-oriented, and branch-intensive workloads?

### Question 3: Hot Code Regions, Basic Block Locality & Compiler Optimisation
Analyse the top executed instruction addresses (PCs) and their frequency distribution.
- What percentage of total dynamic execution is concentrated in the top 5 to 10 instruction PCs?
- What does high concentration in a handful of PCs reveal about hot loops and basic blocks? What specific compiler optimisations (e.g., loop unrolling, function inlining, vectorisation) could reduce instruction overhead in these hot spots?

### Question 4: Control Flow Density & Algorithmic Variation
Evaluate the role of control flow in dynamic execution across different workloads and implementations.
- What percentage of dynamic execution is dedicated to control-flow instructions (`jmp`, `jcc`, `call`, `ret`)?
- Can two different program implementations solving the same computational problem produce drastically different dynamic instruction counts and control-flow profiles? Explain with an example.

### Question 5: Trace Measurement Limits & Microarchitectural Inferences
Identify the boundary between what an opcode/PC trace can prove and what requires deeper architectural modeling or hardware counters.
- What essential performance determinants (e.g., cache hit/miss rates, memory latency, pipeline stalls, branch prediction accuracy, IPC) *cannot* be directly measured from an opcode-only trace?
- Based on your trace evidence, what microarchitectural features (e.g., wide issue width, out-of-order execution window, branch predictor accuracy, cache hierarchy sizing) would have the largest performance impact on your workload?

---

## Part 2: Real-World CPU Performance & Engineering Decisions

### Question 6: Cloud Server Architecture — Core Sizing (P-Core vs. E-Core)
**Scenario**: You are sizing a cloud compute fleet for a transactional key-value store.
**Trace & Profiler Data**:
- Instruction mix: 38% memory operations (`mov`), 24% branches (`cmp`, `test`, `je`, `jne`), 20% ALU operations, 18% stack/call (`push`, `pop`, `call`, `ret`).
- PC concentration: Top 10 PCs account for only 6% of total dynamic execution (flat execution distribution across a large codebase with pointer chasing and data-dependent branching).
- Dynamic instruction count: 1.2 billion instructions per transaction batch.

**Decision & Analysis**:
1. Would you deploy this workload on high-frequency, wide-issue Performance Cores (P-cores) or high-density, throughput-oriented Efficiency Cores (E-cores)? Justify using the instruction mix and PC distribution.
2. What hardware features (e.g., L2/L3 cache capacity, branch predictor table size, memory bandwidth) will be the primary performance bottlenecks?

---

### Question 7: Edge Processing — Vectorisation & SIMD Acceleration
**Scenario**: An edge camera gateway running an object detection pre-processing pipeline must process 1080p video frames within a strict 33 ms latency budget (30 FPS).
**Trace & Profiler Data**:
- Dynamic instructions: 120 million instructions per frame.
- Top PCs: 3 inner-loop instruction addresses account for 82% of all dynamic instructions.
- Opcode mix in hot loop: 45% scalar arithmetic (`add`, `imul`), 40% scalar memory (`mov`, `movzx`), 15% loop control (`inc`, `cmp`, `jne`).
- SIMD/Vector opcodes (`movaps`, `vfmadd`, etc.): 0%.

**Decision & Analysis**:
1. How does the extreme PC concentration guide your optimization strategy (e.g., compiler flags `-O3 -mavx2`, loop vectorisation, or handwritten intrinsics)?
2. If vectorising with 256-bit AVX2 reduces dynamic instruction count in the hot loop by $4\times$, estimate the new dynamic instruction count and explain how you decide whether a dedicated NPU/GPU accelerator is necessary.

---

### Question 8: High-Frequency Trading — Branch Penalties & Tail Latency
**Scenario**: An algorithmic trading execution engine requires deterministic, ultra-low p99 tail latency on incoming market packets.
**Trace & Profiler Data**:
- Control-flow instructions (`cmp`, `test`, `jcc`, `call`) constitute 36% of all executed instructions.
- Trace analysis shows branch density of 1 branch every 2.8 instructions.
- Execution traces under fluctuating market volatility show heavy variance in execution path length (between 1,200 and 18,000 dynamic instructions per packet).

**Decision & Analysis**:
1. Why does high control-flow density on a modern deep pipeline (14–19 stages) pose a severe tail-latency risk?
2. What architectural and software decisions (e.g., branchless programming with `cmov`, lookup tables, CPU selection with advanced TAGE branch predictors) would you take to eliminate latency spikes?

---

### Question 9: Scientific Simulation — Compute-Bound vs. Memory-Bound Scaling
**Scenario**: A grid-based physics simulation (stencil computation) is profiled at two different problem grid sizes ($N=128$ and $N=4096$).
**Trace & Profiler Data**:
- At $N=128$: 18 million dynamic instructions, 50% arithmetic, 35% memory, 15% control flow. Execution time: 5 ms.
- At $N=4096$: 72 billion dynamic instructions ($4000\times$ increase, matching $O(N^3)$ computational scaling), identical opcode percentage breakdown. Execution time: 140 seconds ($28,000\times$ increase).
- Measured cycles per instruction (CPI) increases from 0.6 at $N=128$ to 4.2 at $N=4096$.

**Decision & Analysis**:
1. While the opcode mix and algorithmic complexity remain constant, why does the execution time scale $7\times$ worse than the instruction count?
2. How does this data guide your decision between software restructuring (cache blocking/tiling) versus purchasing hardware with higher memory bandwidth (HBM / multi-channel DDR5)?

---

### Question 10: Web Backend Microservices — Instruction Cache & Binary Footprint
**Scenario**: A microservice handling REST API routing, authentication, and JSON serialization experiences high CPU utilization under moderate traffic.
**Trace & Profiler Data**:
- Total dynamic instructions: 45 million instructions per request.
- Unique PCs: 24,500 unique instruction addresses executed per request.
- Static binary size: 48 MB (compiled Go/Rust binary with many embedded dependencies).
- PC distribution: The single hottest PC accounts for only 0.4% of total execution; top 100 PCs account for less than 12% combined.

**Decision & Analysis**:
1. What does the combination of high unique PC count, large binary size, and flat PC distribution indicate about Instruction Cache (L1I) and Instruction TLB (iTLB) behaviour?
2. What software and compiler toolchain decisions (e.g., Profile-Guided Optimization [PGO], BOLT/AutoFDO binary layout optimization, selective inlining) would you deploy to improve instruction fetch efficiency?
