# Common Infrastructure

This directory is the shared home for future DynamoRIO clients, helper headers, source files, and build utilities. The current repository intentionally contains no instrumentation implementation.

## Adding a client

A future client should be a focused subdirectory with its own target in a CMake project. Configure the shared project with:

```bash
cmake -S common -B build/common -DDynamoRIO_DIR="$DYNAMORIO_HOME/cmake"
cmake --build build/common
```

DynamoRIO's CMake package supplies include paths, libraries, and client linking conventions. Prefer `find_package(DynamoRIO CONFIG REQUIRED)` over hardcoded installation paths. Keep generated output in `build/` and document any client-specific runtime options.
