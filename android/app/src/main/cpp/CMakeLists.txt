# Minimum CMake version required
cmake_minimum_required(VERSION 3.10)

# Project name
project(meta_verse)

# Specify the C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

# Add the native library
# Replace 'native_lib.cpp' with your actual C++ source files
add_library(
    native_lib
    SHARED
    native_lib.cpp
)

# Include directories (if any)
# target_include_directories(native_lib PRIVATE include)

# Find Android log library
find_library(
    log-lib
    log
)

# Link the native library against the log library
target_link_libraries(
    native_lib
    ${log-lib}
)
