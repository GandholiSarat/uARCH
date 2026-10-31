# Workloads

These directories reserve future shared workloads for later labs. Lab 1 keeps its four teaching programs together under `lab01-instruction-profiling/workloads/` so students have one simple place to start. Workloads should be easy to compile, use fixed inputs, and expose one architectural question at a time.

| Workload | Intended behavior |
| --- | --- |
| `matrix-multiplication/` | Compute-intensive loops with structured memory access. |
| `sorting/` | Data-dependent comparisons and control flow. |
| `linked-list/` | Pointer chasing and irregular memory access. |
| `branch-intensive/` | Repeated branch patterns for prediction experiments. |
| `memory-intensive/` | Working-set and memory-hierarchy experiments. |

The root directories are placeholders for future cross-lab programs. Lab 1's actual portable examples are `matrix_multiplication.c`, `sorting.c`, `linked_list.c`, and `branch_intensive.c` in the Lab 1 directory.
