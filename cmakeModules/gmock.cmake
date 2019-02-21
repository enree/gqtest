cmake_minimum_required(VERSION 3.9)

include(ExternalProject)

set(GMOCK_SRC "${CMAKE_CURRENT_BINARY_DIR}/googletest-src")
set(GMOCK_BIN "${CMAKE_CURRENT_BINARY_DIR}/googletest-build")

if (NOT DEFINED GMOCK_GIT)
    set(GMOCK_GIT "https://github.com/google/googletest.git")
endif()

ExternalProject_Add(gmock_external
  GIT_REPOSITORY    ${GMOCK_GIT}
  GIT_TAG           master
  SOURCE_DIR        "${GMOCK_SRC}"
  BINARY_DIR        "${GMOCK_BIN}"
  CONFIGURE_COMMAND ${CMAKE_COMMAND} -S <SOURCE_DIR> -B <BINARY_DIR>
  BUILD_COMMAND ${CMAKE_COMMAND} -E echo "Starting gmock build"
  COMMAND       ${CMAKE_COMMAND} --build <BINARY_DIR>
  COMMAND       ${CMAKE_COMMAND} -E echo "gmock build complete"

  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
  UPDATE_DISCONNECTED TRUE

  LOG_DOWNLOAD TRUE
  LOG_BUILD TRUE
)

set(GTEST_INCLUDE_DIR "${GMOCK_SRC}/googletest/include")
set(GMOCK_INCLUDE_DIR "${GMOCK_SRC}/googlemock/include")

link_directories(${GMOCK_BIN}/lib)
