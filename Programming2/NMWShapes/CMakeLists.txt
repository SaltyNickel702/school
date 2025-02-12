cmake_minimum_required(VERSION 3.31)

project(ShapeBuilder)

set(CXX_STANDARD 23)
set(CXX_STANDARD_REQUIRED True)

file(GLOB_RECURSE SOURCES "${CMAKE_SOURCE_DIR}/src/*.cpp")
add_executable(out ${SOURCES})