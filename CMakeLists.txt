cmake_minimum_required(VERSION 3.9)
project(gqtest)

include(${CMAKE_SOURCE_DIR}/cmake/make.cmake)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmakeModules/external_gtest.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/cmakeModules/gqtest.cmake)
#include(${CMAKE_CURRENT_SOURCE_DIR}/cmakeModules/gqtest.cmake)

# Project main source
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src)
