option(NO_GQTESTS "Do not build tests" OFF)

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
macro(gtest TARGET)
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

    add_executable(${TARGET} ${OPTIONS_SOURCES} ${_srcInternal})

    target_link_libraries(${TARGET} gqtest
        ${GTEST_LIBRARY} ${GMOCK_MAIN_LIBRARY} ${GMOCK_LIBRARY}
        ${OPTIONS_LIBS} Qt5::Core)
    threads(${TARGET})

    add_dependencies(${TARGET} ${GTEST_LIBRARY})

    # Tell ctest about my tests
    include(GoogleTest)
    gtest_add_tests(
        TARGET      ${TARGET}
        AUTO)

endmacro()

enable_testing()
