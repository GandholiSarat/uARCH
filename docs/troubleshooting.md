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

## `tar` Reports `Function not implemented`

If the repository lives on a mounted or shared filesystem such as `/Users/...`, archive extraction may fail because that filesystem does not support the required file operations. The installer extracts into native `/tmp` by default. If `/tmp` is restricted, set `UARCH_DYNAMORIO_TMPDIR` to a writable native Linux directory and rerun `./setup.sh`:

```bash
export UARCH_DYNAMORIO_TMPDIR=/tmp
./setup.sh
./test.sh
```
