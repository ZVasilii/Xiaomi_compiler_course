project(game_of_life)
cmake_minimum_required(VERSION 3.0)
cmake_policy(VERSION 3.0...3.18.4)
find_package(SFML REQUIRED system window graphics)
add_subdirectory(src)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug)
endif()

message(STATUS "CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}")

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_CXX_FLAGS_DEBUG_INIT "-g -Wall -Wextra -Werror")
set(CMAKE_CXX_FLAGS_RELEASE_INIT "-O2")

target_link_libraries(game_of_life PRIVATE graphics sfml-graphics sfml-system sfml-window)
