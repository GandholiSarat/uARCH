cmake_minimum_required(VERSION 3.16)
project(uarch_common LANGUAGES C CXX)

# Future DynamoRIO clients should be added as subdirectories or targets here.
# Point CMake at the installation with: -DDynamoRIO_DIR="$DYNAMORIO_HOME/cmake"
if(DEFINED DynamoRIO_DIR)
    find_package(DynamoRIO CONFIG REQUIRED)
    message(STATUS "DynamoRIO found at ${DynamoRIO_DIR}")
else()
    message(STATUS "DynamoRIO not configured; scaffolding-only configuration")
endif()
