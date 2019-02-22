# @file
# @brief Adding test components
#
if (DEFINED GQTEST_ROOT)
    return()
endif()
set(GQTEST_ROOT ${CMAKE_CURRENT_LIST_DIR})

if (NOT DEFINED GQTEST_INCLUDES)
    set(GQTEST_INCLUDES ${GQTEST_ROOT}/src)
endif()

add_subdirectory(${GQTEST_ROOT})

include(${GQTEST_ROOT}/cmakeModules/gqtest.cmake)
