# Lab 1: Ten Architectural Investigation Questions

Answer every question for each selected workload. Support claims with measurements from your own traces, commands, input sizes, and analyser output. Distinguish measured facts from hypotheses.

1. How many dynamic instructions does your workload execute, and how does this compare with the number of static instructions in its compiled binary?
2. Which instructions or opcodes dominate execution? What does this tell you about the workload's computational behaviour?
3. How does the dynamic instruction count change when you increase the workload's input size? Is the growth linear, logarithmic, or otherwise? Explain.
4. Which instruction addresses are executed most frequently? What can you infer about loops and hot code regions?
5. How does the instruction mix differ between compute-intensive, memory-oriented, and branch-intensive workloads?
6. What fraction of execution is associated with control-flow instructions? How might this affect branch prediction and pipeline behaviour?
7. What does the trace suggest about instruction-level repetition and opportunities for compiler optimisation?
8. Can two programs performing the same task have substantially different dynamic instruction counts? Demonstrate and explain.
9. What important processor-performance information cannot be inferred from your current trace? What additional instrumentation or hardware measurements would you need?
10. Based on your findings, what microarchitectural features would matter most for this workload, and why? Support your argument with trace evidence.
