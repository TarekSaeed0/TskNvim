cmake_minimum_required(VERSION #{vim.version.parse(vim.fn.system({ "cmake", "--version" }):match("[^\n]*"))}#)
project(
	#{in_snake_case(name)}#
	VERSION 1.0
	LANGUAGES CXX
	DESCRIPTION "A solution of a codeforces problem written in cpp"
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(#{in_snake_case(name)}# src/main.cpp)
