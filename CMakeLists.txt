cmake_minimum_required(VERSION 3.9)
project(gqtest)

include(${CMAKE_SOURCE_DIR}/cmake/make.cmake)

# define *.cmake files to propogate to upper level
include(${CMAKE_CURRENT_SOURCE_DIR}/cmakeModules/gmock.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/cmakeModules/gqtest.cmake)

if (NOT DEFINED GQTEST_INCLUDES)
    set(GQTEST_INCLUDES ${CMAKE_CURRENT_SOURCE_DIR}/src)
endif()

# Project main source
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src)
