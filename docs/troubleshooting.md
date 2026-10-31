# When Things Break

## `DYNAMORIO_HOME` Is Rejected

Check that the path is the root of the extracted distribution and contains `include/` and `cmake/`:

```bash
printf '%s\n' "$DYNAMORIO_HOME"
ls "$DYNAMORIO_HOME/include" "$DYNAMORIO_HOME/cmake"
```

## `drcachesim` Is Missing

Use a DynamoRIO distribution that includes `tools/drcachesim.drrun64`. The simulator is launched through `bin64/drrun -t drcachesim`; it is not a standalone `bin64/drcachesim` executable. Do not copy binaries from an unrelated installation. Re-run `./test.sh` after correcting the path.

## CMake Cannot Find DynamoRIO

Configure with `-DDynamoRIO_DIR="$DYNAMORIO_HOME/cmake"`. Do not point CMake at the `include/` directory; it needs the package configuration directory.

## Permission Denied

Scripts are intended to be executable. Restore permissions with `chmod +x setup.sh test.sh scripts/*.sh common/scripts/*.sh`.
