# Optional Upstream DynamoRIO Development

The normal student setup uses the pinned official prebuilt package. Developers who need an unreleased feature can maintain a separate source build without changing the uARCH setup policy.

## Clone and configure

```bash
git clone https://github.com/DynamoRIO/dynamorio.git "$HOME/src/dynamorio"
cmake -S "$HOME/src/dynamorio" -B "$HOME/src/dynamorio/build" \
    -DCMAKE_BUILD_TYPE=Release
cmake --build "$HOME/src/dynamorio/build" --parallel
export DYNAMORIO_HOME="$HOME/src/dynamorio/build"
```

Use the upstream repository's own build documentation for additional options and supported host requirements. Keep this checkout outside the uARCH repository and do not commit its binaries. Before sharing an experiment, record the upstream commit, compiler, CMake version, and relevant build options so another developer can reproduce it.

This path is intentionally optional. Students should use `./setup.sh` and the pinned release unless an exercise explicitly requires an unreleased feature.
