cmake_minimum_required(VERSION #{vim.version.parse(vim.fn.system({ "cmake", "--version" }):match("[^\n]*"))}#)
project(
	#{in_snake_case(name)}#
	VERSION 1.0
	LANGUAGES C
	DESCRIPTION "A project written in c"
)

add_executable(#{in_snake_case(name)}# src/main.c)
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
