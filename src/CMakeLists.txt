project(gqtest)

file(GLOB _src "*")

find_package(Qt5 COMPONENTS Core REQUIRED)

add_library(${PROJECT_NAME} SHARED ${_src})

get_target_property(GTEST_INCLUDE_DIR ${GTEST_LIBRARY} "INTERFACE_INCLUDE_DIRECTORIES")
target_include_directories(${PROJECT_NAME} PRIVATE ${GTEST_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} Qt5::Core)

set_target_properties(${PROJECT_NAME} PROPERTIES
    "INTERFACE_INCLUDE_DIRECTORIES" "${CMAKE_CURRENT_SOURCE_DIR}")


add_dependencies(${PROJECT_NAME} ${GTEST_LIBRARY})

tests("")
