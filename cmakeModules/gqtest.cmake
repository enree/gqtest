option(NO_GQTESTS "Do not build tests" OFF)

if (NOT DEFINED GQTEST_INCLUDES)
    set(GQTEST_INCLUDES ${GQTEST_ROOT}/src)
endif()

# Add test component
macro(tests target)
    if (NOT NO_GQTESTS)
        add_subdirectory("${TESTS_PATH}/${target}" ${CMAKE_CURRENT_BINARY_DIR}/tests)
    endif()
endmacro()

# Add test executable
# Options:
# TARGET - test name (mandatory)
# SOURCES - list of source files to include to build
# GLOBBING - regexp for parsing sources recursively
# LIBS - list of libraries to link to target
# QT - list of Qt modules to add to target
# BOOST - list of boost modules to add to target
macro(gqtest TARGET)
    set(oneValueArgs RECURSIVE)
    set(multiValueArgs SOURCES LIBS QT BOOST GLOBBING)
    cmake_parse_arguments(OPTIONS "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    set(_srcInternal "")
    if (OPTIONS_GLOBBING)
        sources(
            _srcInternal
            GLOBBING ${OPTIONS_GLOBBING}
            RECURSIVE ${OPTIONS_RECURSIVE}
        )
    endif()

    get_target_property(GTEST_INCLUDE_DIR gmock_external GTEST_INCLUDE_DIR)
    get_target_property(GMOCK_INCLUDE_DIR gmock_external GMOCK_INCLUDE_DIR)
    get_target_property(GMOCK_LIBS_DIR gmock_external GMOCK_LIBS_DIR)
    link_directories(${GMOCK_LIBS_DIR})

    add_executable(${TARGET} ${OPTIONS_SOURCES} ${_srcInternal})

    target_include_directories(${TARGET} PRIVATE ${GTEST_INCLUDE_DIR}
        ${GMOCK_INCLUDE_DIR} ${GQTEST_INCLUDES})

    target_link_libraries(${TARGET} gqtest
        gtest gmock_main gmock
        ${OPTIONS_LIBS} Qt5::Core)
    threads(${TARGET})

    add_dependencies(${TARGET} gmock_external)

    add_test(${TARGET} ${TARGET_SYSTEM_EMULATOR} ${TARGET}
        --gtest_output=xml:${CMAKE_BINARY_DIR}/gtest/test_report_${TARGET}.xml)
endmacro()

enable_testing()
