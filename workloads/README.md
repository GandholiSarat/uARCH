# Workloads

These directories reserve small, deterministic programs for experiments. Workloads should be easy to compile, use fixed inputs, and expose one architectural question at a time.

| Workload | Intended behavior |
| --- | --- |
| `matrix-multiplication/` | Compute-intensive loops with structured memory access. |
| `sorting/` | Data-dependent comparisons and control flow. |
| `linked-list/` | Pointer chasing and irregular memory access. |
| `branch-intensive/` | Repeated branch patterns for prediction experiments. |
| `memory-intensive/` | Working-set and memory-hierarchy experiments. |

Sample programs may be added later. They should remain portable, deterministic, and uncomplicated; this foundation does not claim that benchmark implementations are present.
