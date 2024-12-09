cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(xv6fs VERSION 0.0.1 LANGUAGES C CXX)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_FILE_OFFSET_BITS=64 -no-pie -Wall -Werror -Wno-write-strings")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS} --pedantic -g")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_FILE_OFFSET_BITS=64 -no-pie -Wall -Werror -Wno-write-strings")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} --pedantic -g")

set(CMAKE_CXX_STANDARD 20)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake" ${CMAKE_MODULE_PATH})

option(ENABLE_TESTS "Enable unit tests" OFF)

if(ENABLE_TESTS)
    add_compile_definitions(ENABLE_TESTS) # 添加宏定义
    enable_testing()
endif()


set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

find_package(FUSE REQUIRED)
include_directories(${FUSE_INCLUDE_DIR} ./inc ./inc/util)
add_executable("${PROJECT_NAME}" 
    "src/BlockCache.cxx"
    "src/Device.cxx"
    "src/File.cxx"
    "src/FileTable.cxx"
    "src/fs.cxx"
    "src/INode.cxx"
    "src/INodeCache.cxx"
    "src/Log.cxx" 
    "src/main.cxx"
    "src/op_access.cxx"
    "src/op_chmod.cxx"
    "src/op_chown.cxx"
    "src/op_create.cxx"
    "src/op_flush.cxx"
    "src/op_getxattr.cxx"
    "src/op_getattr.cxx"
    "src/op_init.cxx"
    "src/op_link.cxx"
    "src/op_mkdir.cxx"
    "src/op_mknod.cxx"
    "src/op_open.cxx"
    "src/op_read.cxx"
    "src/op_readdir.cxx"
    "src/op_release.cxx"
    "src/op_rename.cxx"
    "src/op_setxattr.cxx"
    "src/op_statfs.cxx"
    "src/op_truncate.cxx"
    "src/op_unlink.cxx"
    "src/op_utimens.cxx"
    "src/op_write.cxx"
    "src/Pipe.cxx"
    "src/SuperBlock.cxx"
    "src/xv6fs.cxx"
    )
target_link_libraries("${PROJECT_NAME}" ${FUSE_LIBRARIES})

if(ENABLE_TESTS)
    find_package(GTest REQUIRED)
    include_directories(${GTEST_INCLUDE_DIRS})
    target_link_libraries(${PROJECT_NAME} gtest gtest_main)
    add_test(NAME MyTests COMMAND ${PROJECT_NAME})
endif()

message("FUSE_INCLUDE_DIR ${FUSE_INCLUDE_DIR}")
message("FUSE_LIBRARIES ${FUSE_LIBRARIES}")
message("DIR_SRCS ${DIR_SRCS}")
message("!!!!!**CMAKE_GENERATOR** ${CMAKE_GENERATOR}")
