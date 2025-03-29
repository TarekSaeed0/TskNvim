#include <#{in_snake_case(name)}#.h>

#include <assert.h>
#include <string.h>

size_t #{in_snake_case(name)}#_filter(void *array, size_t length, size_t size, #{in_snake_case(name)}#_filter_predicate predicate) {
	assert((array != NULL || length == 0) && size != 0 && predicate != NULL);

	for (ptrdiff_t i = (ptrdiff_t)length - 1; i >= 0; --i) {
		if (!predicate((const char *)array + ((size_t)i * size))) {
			memmove(
				(char *)array + ((size_t)i * size),
				(const char *)array + ((size_t)(i + 1) * size),
				((length - (size_t)i - 1) * size)
			);
			--length;
		}
	}

	return length;

	return length;
}
