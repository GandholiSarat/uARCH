#!/usr/bin/env python3
"""Analyser for DynamoRIO instrace_simple execution traces."""

import argparse
from collections import Counter
from pathlib import Path
import sys
from typing import Iterator, Tuple


def records(path: Path) -> Iterator[Tuple[str, str]]:
    """Yield (pc, opcode) tuples from the trace file.

    Skips header lines and blank lines. Tracks and reports malformed records.
    """
    malformed_count = 0
    with path.open(encoding="utf-8", errors="replace") as handle:
        for line in handle:
            line = line.strip()
            if not line:
                continue
            if line.startswith("Format:") or line.startswith("#"):
                continue

            parts = [p.strip() for p in line.split(",", 1)]
            if len(parts) != 2 or not parts[0] or not parts[1]:
                malformed_count += 1
                continue

            pc, opcode = parts
            yield pc, opcode

    if malformed_count > 0:
        print(f"Warning: Skipped {malformed_count} malformed record(s) in {path}", file=sys.stderr)


def categorize_opcode(opcode: str) -> str:
    """Categorise an opcode into broad instruction classes.

    TODO: Implement opcode categorisation rules (e.g., arithmetic, control flow,
    memory/data movement, logic, floating point, etc.) with an explicit fallback
    for unknown opcodes.
    """
    # TODO: Define opcode sets or prefix rules for categories such as:
    # - "control_flow": jmp, jz, jnz, je, jne, call, ret, etc.
    # - "arithmetic": add, sub, imul, mul, idiv, inc, dec, etc.
    # - "logic": and, or, xor, not, shl, shr, sar, etc.
    # - "memory": mov, lea, push, pop, etc. (Note: mov can be register-register or memory)
    # - "unknown": fallback category
    return "unknown"


def classify_workload(category_counts: Counter, total: int) -> str:
    """Classify the workload based on its instruction category mix.

    TODO: Implement workload classification (e.g., compute-intensive, memory-oriented,
    branch-intensive) based on instruction percentages.
    """
    # TODO: Analyse category distributions and return a classification string.
    return "unclassified"


def analyze_trace(trace_path: Path, top_n: int = 10) -> None:
    """Parse trace file, compute instruction metrics, and print summary report."""
    opcode_counts = Counter()
    pc_counts = Counter()
    category_counts = Counter()
    total_instructions = 0

    for pc, opcode in records(trace_path):
        total_instructions += 1
        pc_counts[pc] += 1
        opcode_counts[opcode] += 1
        category = categorize_opcode(opcode)
        category_counts[category] += 1

    if total_instructions == 0:
        print(f"No valid dynamic instructions found in {trace_path}")
        return

    unique_pcs = len(pc_counts)
    unique_opcodes = len(opcode_counts)

    print("=" * 60)
    print(f"Instruction Trace Analysis: {trace_path.name}")
    print("=" * 60)

    # 1. Total Dynamic Instructions
    print(f"\n1. Total Dynamic Instructions: {total_instructions:,}")

    # 2. Unique Instruction Addresses and Opcodes
    print(f"\n2. Unique Instruction Addresses (PCs): {unique_pcs:,}")
    print(f"   Unique Opcodes: {unique_opcodes:,}")

    # 3. Opcode Frequency and Top Instruction PCs
    print(f"\n3. Opcode Frequency (Top {min(top_n, unique_opcodes)}):")
    print(f"   {'Rank':<5} {'Opcode':<15} {'Count':>12} {'Percent':>10}")
    print(f"   {'-'*5} {'-'*15} {'-'*12} {'-'*10}")
    for rank, (opcode, count) in enumerate(opcode_counts.most_common(top_n), start=1):
        pct = (count / total_instructions) * 100
        print(f"   {rank:<5} {opcode:<15} {count:>12,} {pct:>9.2f}%")

    print(f"\n   Top Instruction PCs (Top {min(top_n, unique_pcs)}):")
    print(f"   {'Rank':<5} {'PC Address':<20} {'Count':>12} {'Percent':>10}")
    print(f"   {'-'*5} {'-'*20} {'-'*12} {'-'*10}")
    for rank, (pc, count) in enumerate(pc_counts.most_common(top_n), start=1):
        pct = (count / total_instructions) * 100
        print(f"   {rank:<5} {pc:<20} {count:>12,} {pct:>9.2f}%")

    # 4. Opcode Categorisation and Workload Classification (TODO)
    print("\n4. Opcode Categorisation & Workload Classification:")
    if set(category_counts.keys()) == {"unknown"}:
        print("   [TODO] Opcode categorisation is not yet implemented.")
        print("   Implement `categorize_opcode()` to classify opcodes into categories.")
        print("   Implement `classify_workload()` to classify workload behaviour.")
    else:
        print(f"   {'Category':<20} {'Count':>12} {'Percent':>10}")
        print(f"   {'-'*20} {'-'*12} {'-'*10}")
        for cat, count in category_counts.most_common():
            pct = (count / total_instructions) * 100
            print(f"   {cat:<20} {count:>12,} {pct:>9.2f}%")
        workload_type = classify_workload(category_counts, total_instructions)
        print(f"\n   Workload Classification: {workload_type}")

    print("\n" + "=" * 60)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Analyse DynamoRIO instrace_simple execution traces."
    )
    parser.add_argument("trace", type=Path, help="Path to instrace trace file")
    parser.add_argument(
        "--top",
        type=int,
        default=10,
        help="Number of top opcodes/PCs to display (default: 10)",
    )

    args = parser.parse_args()

    if not args.trace.exists():
        print(f"Error: Trace file '{args.trace}' not found.", file=sys.stderr)
        return 1

    analyze_trace(args.trace, top_n=args.top)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
