#!/usr/bin/env python3
"""Student scaffold for analysing DynamoRIO instrace_simple records."""

from collections import Counter
from pathlib import Path
import sys


def records(path: Path):
    # TODO: Skip the exact Format header and blank lines.
    # TODO: Validate each remaining line as PC,opcode.
    # TODO: Count malformed records instead of silently hiding them.
    with path.open(encoding="utf-8") as handle:
        for line in handle:
            yield line.rstrip("\n")


def main() -> int:
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} TRACE", file=sys.stderr)
        return 2

    opcode_counts = Counter()
    pc_counts = Counter()
    total = 0

    for record in records(Path(sys.argv[1])):
        # TODO: Parse the PC and opcode, then update the counters.
        print(f"TODO: {record}")
        # TODO: total += 1

    # TODO: Report total instructions and unique PCs/opcodes.
    # TODO: Add documented broad categories with an unknown fallback.
    # TODO: Write CSV summaries and charts.
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
