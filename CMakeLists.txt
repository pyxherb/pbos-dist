cmake_minimum_required(VERSION 3.23)
project(PbOS VERSION 0.1.0)
set(PbOS_SOURCE_DIR ${PROJECT_SOURCE_DIR})

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")

add_subdirectory("utils")

include(ExternalProject)
ExternalProject_Add(
    kernel
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/kernel
    BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/kernel
    CMAKE_ARGS
        # Use native toolchain
        --toolchain=${CMAKE_CURRENT_SOURCE_DIR}/kernel/cmake/platform/i386-pc-pbkim.cmake
        # Inherited variables
        -DPbOS_SOURCE_DIR=${PbOS_SOURCE_DIR}
        -DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
    BUILD_ALWAYS TRUE
)
ExternalProject_Add(
    init
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/init
    BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/init
    CMAKE_ARGS
        # Use native toolchain
        --toolchain=${CMAKE_CURRENT_SOURCE_DIR}/kernel/cmake/platform/i386-pc-pbkim.cmake
        # Inherited variables
        -DPbOS_SOURCE_DIR=${PbOS_SOURCE_DIR}
        -DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
    BUILD_ALWAYS TRUE
)

add_custom_target(
    pbkim
    COMMAND $<TARGET_FILE:kimgen> create ${PbOS_BINARY_DIR}/kernel/bootldr ${PbOS_BINARY_DIR}/kernel/pbkern ${PbOS_BINARY_DIR}/pbkim
    # BYPRODUCTS ${PROJECT_BINARY_DIR}/pbkim
    DEPENDS kernel
)

add_custom_target(
    initcar
    COMMAND $<TARGET_FILE:cargen> -c ${PbOS_BINARY_DIR}/initcar _ ${PbOS_BINARY_DIR}/init/pbinit
    # BYPRODUCTS ${PROJECT_BINARY_DIR}/initcar
    DEPENDS init
)
