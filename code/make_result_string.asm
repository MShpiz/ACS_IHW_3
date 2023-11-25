.include "macrolib.s"
.global make_result_string


make_result_string:
.data
fileprompt: .asciz "Do you want to write result to the file? (Y/N)"

d_count: .asciz "\ndigit count: "
l_count: .asciz "letter count: "

d_cnt: .space 7
l_cnt: .space 7
resultBuff: .space 50
.text
push(ra)
push(s0)
push(s1)
mv	s0, a0
mv	s1, a1

mv	a0, s0		# convert letter_count to string
la	a1, l_cnt
jal	toString

la	t0 l_cnt

mv	a0, s1		# convert digit_count to string
la	a1, d_cnt
jal	toString

la	t0 d_cnt

la	t0, resultBuff	# copy first text part of result string to buffer
la	t1, l_count
li	t2, 14
strncpy(t0, t1, t2)



la	t0, resultBuff	# copy string version of letter_count to result string to buffer
addi	t0, t0, 14
la	t1, l_cnt
li	t2, 6
strncpy(t0, t1, t2)

la	t0, resultBuff	# copy second text part of result string to buffer
addi	t0, t0, 20
la	t1, d_count
li	t2, 14
strncpy(t0, t1, t2)


la	t0, resultBuff # copy string version of digit_count to result string to buffer
addi	t0, t0, 34
la	t1, d_cnt
li	t2, 7
strncpy(t0, t1, t2)



la a0, resultBuff	# return adress of final string's buffer

pop(s1)
pop(s0)
pop(ra)
ret
