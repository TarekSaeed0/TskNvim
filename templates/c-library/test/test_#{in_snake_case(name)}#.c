#include <setjmp.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

#include <cmocka.h>

#include <#{in_snake_case(name)}#.h>

static void test_#{in_snake_case(name)}#(void **state) {
	(void)state;
}

int main(void) {
	const struct CMUnitTest tests[] = {
		cmocka_unit_test(test_#{in_snake_case(name)}#),
	};

	return cmocka_run_group_tests(tests, NULL, NULL);
}
