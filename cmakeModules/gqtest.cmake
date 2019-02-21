option(NO_TESTS "Do not build tests" OFF)

#if (NOT NO_TESTS)
#    configure_file(${CMAKE_CURRENT_LIST_DIR}/CMakeLists-gtest.txt
#        googletest-download/CMakeLists.txt)

#    execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
#        RESULT_VARIABLE result
#        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )

#    if(result)
#        message(FATAL_ERROR "CMake step for googletest failed: ${result}")
#    endif()

##    execute_process(COMMAND ${CMAKE_COMMAND} --build .
##        RESULT_VARIABLE result
##        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )

##    if(result)
##        message(FATAL_ERROR "Build step for googletest failed: ${result}")
##    endif()

#    # Prevent overriding the parent project's compiler/linker
#    # settings on Windows
#    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)


#    # Add googletest directly to our build. This defines
#    # the gtest and gtest_main targets.
#    add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/googletest-src
#                    ${CMAKE_CURRENT_BINARY_DIR}/googletest-build
#                    EXCLUDE_FROM_ALL)
#endif()

# Add test component
macro(tests target)
    if (NOT NO_TESTS)
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
macro(test TARGET)
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
    target_include_directories(${PROJECT_NAME} PRIVATE ${GTEST_INCLUDE_DIR}
        ${GMOCK_INCLUDE_DIR} ${GQTEST_INCLUDES})

    target_link_libraries(${TARGET} gqtest gtest gmock_main gmock
        ${OPTIONS_LIBS} Qt5::Core)
    threads(${TARGET})

    add_dependencies(${TARGET} gmock_external)

    add_test(${TARGET} ${TARGET_SYSTEM_EMULATOR} ${TARGET}
        --gtest_output=xml:${CMAKE_BINARY_DIR}/gtest/test_report_${TARGET}.xml)
endmacro()

enable_testing()
