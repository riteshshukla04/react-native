# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

cmake_minimum_required(VERSION 3.13)
set(CMAKE_VERBOSE_MAKEFILE on)

include(${REACT_COMMON_DIR}/cmake-utils/react-native-flags.cmake)

file(GLOB logger_SRC CONFIGURE_DEPENDS *.cpp)
add_library(logger OBJECT ${logger_SRC})

target_include_directories(logger PUBLIC .)

target_link_libraries(logger glog)
target_compile_reactnative_options(logger PRIVATE)
