#include <setjmp.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

#include <cmocka.h>

#include <#{in_snake_case(name)}#.h>

#define ARRAY_LENGTH(array) (sizeof(array) / sizeof(array[0]))

bool is_even(const void *value) {
	return *(const int *)value % 2 == 0;
}

static void test_filter(void **state) {
	(void)state;

	int array[] = { 1, 2, 3, 4, 5 };
	const int expected[] = { 2, 4 };
	assert_int_equal(
		#{in_snake_case(name)}#_filter(array, ARRAY_LENGTH(array), sizeof(array[0]), is_even), 
		ARRAY_LENGTH(expected)
	);
	assert_memory_equal(array, expected, sizeof(expected));
}

int main(void) {
	const struct CMUnitTest tests[] = {
		cmocka_unit_test(test_filter),
	};

	return cmocka_run_group_tests(tests, NULL, NULL);
}
