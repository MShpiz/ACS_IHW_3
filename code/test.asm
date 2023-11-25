.include "macrolib.s"
.eqv    TEXT_SIZE 512	# length of text
.data
test_1_file:	.asciz		"meow"
test_2_file:	.asciz		"test_files/empty.txt"
test_3_file:	.asciz		"test_files/small_text.txt"
test_4_file:	.asciz		"test_files/long_text.txt"
test_5_file:	.asciz		"test_files/longer_than_buffer.txt"
test_6_file:	.asciz		"test_files/10+kb_file.txt"

out_test_1_file:	.asciz		"test_results/test1.txt"
out_test_2_file:	.asciz		"test_results/test2.txt"
out_test_3_file:	.asciz		"test_results/test3.txt"
out_test_4_file:	.asciz		"test_results/test4.txt"
out_test_5_file:	.asciz		"test_results/test5.txt"
out_test_6_file:	.asciz		"test_results/test6.txt"

buff1:	.space TEXT_SIZE
buff2:	.space TEXT_SIZE
buff3:	.space TEXT_SIZE
buff4:	.space TEXT_SIZE
buff5:	.space TEXT_SIZE
buff6:	.space TEXT_SIZE

.text
test:
la a0 test_1_file
la a1 out_test_1_file
la a2 buff1
jal onetest

la a0 test_2_file
la a1 out_test_2_file
la a2 buff2
jal onetest

la a0 test_3_file
la a1 out_test_3_file
la a2 buff3
jal onetest

la a0 test_4_file
la a1 out_test_4_file
la a2 buff4
jal onetest

la a0 test_5_file
la a1 out_test_5_file
la a2 buff5
jal onetest

la a0 test_6_file
la a1 out_test_6_file
la a2 buff6
jal onetest

exit

onetest:
	push(ra)
	push(s0)
	push(s1)
	push(s2)
	mv 	s0 a0	# in file
	mv	s1 a1	# out file
	mv 	s2 a2	# buffer
	mv 	a0 s2
	li	a1 TEXT_SIZE
	mv	a2 s0
	jal read_from_file
	bltz	a0 endTest
	mv	a0, a1
	mv	a1, a2
	jal make_result_string		# make a sring from numbers in a0 and a1
	mv	a1 a0
	mv	a0 s1
	jal write_to_file
	endTest:
	pop(s2)
	pop(s1)
	pop(s0)
	pop(ra)
ret
