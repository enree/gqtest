project(gqtest)

file(GLOB _src "*")

find_package(Qt5Core REQUIRED)

add_library(${PROJECT_NAME} SHARED ${_src})

get_target_property(GTEST_INCLUDE_DIR gmock_external GTEST_INCLUDE_DIR)
target_include_directories(${PROJECT_NAME} PRIVATE ${GTEST_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} Qt5::Core)

add_dependencies(${PROJECT_NAME} gmock_external)

tests("")
