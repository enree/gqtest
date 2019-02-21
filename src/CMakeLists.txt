project(gqtest)

file(GLOB _src "*")

find_package(Qt5Core REQUIRED)

add_library(${PROJECT_NAME} SHARED ${_src})
target_include_directories(${PROJECT_NAME} PRIVATE ${GTEST_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} Qt5::Core)

add_dependencies(${PROJECT_NAME} gmock_external)

tests("")
