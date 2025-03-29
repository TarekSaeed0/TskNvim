/**
 * @file #{in_snake_case(name)}#.h
 * @brief Utility functions for array manipulation.
 *
 * This header provides general-purpose utility functions for handling
 * arrays.
 *
 * @author #{vim.fn.system("getent passwd $USER | cut -d':' -f5 | cut -d',' -f1"):gsub("\n", "")}#
 * @date #{os.date("%Y-%m-%d")}#
 */

#ifndef #{in_screaming_snake_case(name)}#_H
#define #{in_screaming_snake_case(name)}#_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stddef.h>

/**
 * @brief Function pointer type for filtering predicates.
 *
 * A predicate function determines whether a given element should be retained
 * in the array. It takes a pointer to the element as input and returns `true`
 * if the element should be kept, or `false` if it should be removed.
 *
 * @param value Pointer to the element being evaluated.
 *
 * @return `true` if the element should be kept, `false` otherwise.
 */
typedef bool (*#{in_snake_case(name)}#_filter_predicate)(const void *value);

/**
 * @brief Filters an array in-place based on a predicate function.
 *
 * This function iterates over the elements of the given array and applies the
 * provided predicate function to each element. Only elements for which the
 * predicate returns `true` are kept in the array. The function modifies the
 * array in place and returns the new length of the filtered array.
 *
 * @param[in,out] array Pointer to the array to be filtered. The function
 *                      modifies the array in place.
 * @param[in] length The number of elements in the array before filtering.
 * @param[in] size The size (in bytes) of each element in the array.
 * @param[in] predicate A function pointer to the predicate function, which
 *                      determines whether an element should be kept (`true`)
 *                      or removed (`false`).
 *
 * @return The new length of the array after filtering.
 *
 * @note The order of elements is preserved, The values of the elements of the array beyond the new
 * length are unspecified.
 */
size_t #{in_snake_case(name)}#_filter( void *array, size_t length, size_t size, #{in_snake_case(name)}#_filter_predicate predicate);

#ifdef __cplusplus
}
#endif

#endif // #{in_screaming_snake_case(name)}#_H
