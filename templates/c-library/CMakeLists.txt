cmake_minimum_required(VERSION #{vim.version.parse(vim.fn.system({ "cmake", "--version" })):match("[^\n]*"))}#)
project(
	#{in_snake_case(name)}#
	VERSION 1.0
	LANGUAGES C
	DESCRIPTION "A library written in c"
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_library(#{in_snake_case(name)}# src/#{in_snake_case(name)}#.c)
target_include_directories(#{in_snake_case(name)}# PUBLIC include)
target_compile_options(
	#{in_snake_case(name)}#
	PRIVATE -Werror
			-Wall
			-Wextra
			-pedantic
			-Wfloat-equal
			-Wundef
			-Wshadow
			-Wpointer-arith
			-Wcast-align
			-Wstrict-prototypes
			-Wstrict-overflow=5
			-Wwrite-strings
			-Wcast-qual
			-Wconversion
)

if(UNIT_TESTING)
	list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmocka)

	find_package(cmocka REQUIRED)

	include(AddCMockaTest)

	add_subdirectory(tests)
endif(UNIT_TESTING)
