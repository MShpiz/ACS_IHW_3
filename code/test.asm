.include "macrolib.s"

.data
test_1_par_a:	.double		10.0
test_1_par_b:	.double		10.0
test_1_interval_start:	.double	0.0
test_1_interval_end:	.double	0.0

test_2_par_a:	.double		0.0
test_2_par_b:	.double		0.0
test_2_interval_start:	.double	0.0
test_2_interval_end:	.double	1.0

test_3_par_a:	.double		10.0
test_3_par_b:	.double		0.0
test_3_interval_start:	.double	0.0
test_3_interval_end:	.double 1.0

test_4_par_a:	.double		1.0
test_4_par_b:	.double		1.0
test_4_interval_start:	.double	0.0
test_4_interval_end:	.double	1.0

test_5_par_a:	.double		1.0
test_5_par_b:	.double		1.0
test_5_interval_start:	.double	1.0
test_5_interval_end:	.double	0.0

test_6_par_a:	.double		0.0
test_6_par_b:	.double		1.0
test_6_interval_start:	.double	-1.0
test_6_interval_end:	.double	0.0

test_7_par_a:	.double		0.0
test_7_par_b:	.double		1.0
test_7_interval_start:	.double	0.0
test_7_interval_end:	.double	1.0

test_8_par_a:	.double		0.0
test_8_par_b:	.double		1.0
test_8_interval_start:	.double	-1.0
test_8_interval_end:	.double	1.0

test_9_par_a:	.double		0.0
test_9_par_b:	.double		0.00001
test_9_interval_start:	.double	1000.0
test_9_interval_end:	.double	1001.0


test:
print_str("test 1\n")
fld	fa0, test_1_par_a, t0		# passing a as an argument
fld	fa1, test_1_par_b, t0		# passing b as an argument
fld	fa2, test_1_interval_start, t0	# passing begining of interval as an argument
fld	fa3, test_1_interval_end, t0	# passing end of interval as an argument
jal onetest
print_str("test 2\n")
fld	fa0, test_2_par_a, t0		# passing a as an argument
fld	fa1, test_2_par_b, t0		# passing b as an argument
fld	fa2, test_2_interval_start, t0	# passing begining of interval as an argument
fld	fa3, test_2_interval_end, t0	# passing end of interval as an argument
jal onetest
print_str("test 3\n")
fld	fa0, test_3_par_a, t0		# passing a as an argument
fld	fa1, test_3_par_b, t0		# passing b as an argument
fld	fa2, test_3_interval_start, t0	# passing begining of interval as an argument
fld	fa3, test_3_interval_end, t0	# passing end of interval as an argument
jal onetest
print_str("test 4\n")
fld	fa0, test_4_par_a, t0		# passing a as an argument
fld	fa1, test_4_par_b, t0		# passing b as an argument
fld	fa2, test_4_interval_start, t0	# passing begining of interval as an argument
fld	fa3, test_4_interval_end, t0	# passing end of interval as an argument
jal onetest
print_str("test 5\n")
fld	fa0, test_5_par_a, t0		# passing a as an argument
fld	fa1, test_5_par_b, t0		# passing b as an argument
fld	fa2, test_5_interval_start, t0	# passing begining of interval as an argument
fld	fa3, test_5_interval_end, t0	# passing end of interval as an argument
jal onetest

print_str("test 6\n")
fld	fa0, test_6_par_a, t0		# passing a as an argument
fld	fa1, test_6_par_b, t0		# passing b as an argument
fld	fa2, test_6_interval_start, t0	# passing begining of interval as an argument
fld	fa3, test_6_interval_end, t0	# passing end of interval as an argument
jal onetest

print_str("test 7\n")
fld	fa0, test_7_par_a, t0		# passing a as an argument
fld	fa1, test_7_par_b, t0		# passing b as an argument
fld	fa2, test_7_interval_start, t0	# passing begining of interval as an argument
fld	fa3, test_7_interval_end, t0	# passing end of interval as an argument
jal onetest

print_str("test 8\n")
fld	fa0, test_8_par_a, t0		# passing a as an argument
fld	fa1, test_8_par_b, t0		# passing b as an argument
fld	fa2, test_8_interval_start, t0	# passing begining of interval as an argument
fld	fa3, test_8_interval_end, t0	# passing end of interval as an argument
jal onetest

print_str("test 9\n")
fld	fa0, test_9_par_a, t0		# passing a as an argument
fld	fa1, test_9_par_b, t0		# passing b as an argument
fld	fa2, test_9_interval_start, t0	# passing begining of interval as an argument
fld	fa3, test_9_interval_end, t0	# passing end of interval as an argument
jal onetest

exit

onetest:
	push(ra)
	fpush(fa0)		# pushing arguments to stack, to use them later for next function
	fpush(fa1)
	fpush(fa2)
	fpush(fa3)	
	jal print_equation	# passing a - a0, b - a1, start - a2, end - a3
	fpop(fa3)		
	fpop(fa2)		
	fpop(fa1)		
	fpop(fa0)		
	jal integrate		# passing a - a0, b - a1, start - a2, end - a3
	jal print_result	# passing result of integration by a0
	
	pop(ra)
ret
