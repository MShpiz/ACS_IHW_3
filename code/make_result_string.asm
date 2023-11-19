.include "macrolib.s"
.global make_result_string


make_result_string:
.data
fileprompt: .asciz "Do you want to write result to the file? (Y/N)"

d_count: .asciz "\ndigit count: "
l_count: .asciz "letter count: "

d_cnt: .space 4
l_cnt: .space 4
resultBuff: .space 37
.text
push(ra)
push(s0)
push(s1)
mv	s0, a0
mv	s1, a1

mv	a0, s0
la	a1, l_cnt
jal	toString

mv	a0, s1
la	a1, d_cnt
jal	toString

la	t0, resultBuff
la	t1, l_count
li	t2, 14
strncpy(t0, t1, t2)



la	t0, resultBuff
addi	t0, t0, 13
la	t1, l_cnt
li	t2, 3
strncpy(t0, t1, t2)

la	t0, resultBuff
addi	t0, t0, 16
la	t1, d_count
li	t2, 14
strncpy(t0, t1, t2)


la	t0, resultBuff
addi	t0, t0, 30
la	t1, d_cnt
li	t2, 4
strncpy(t0, t1, t2)

la	t0, resultBuff
print_str_r(t0)
newline

la a0, resultBuff

pop(s1)
pop(s0)
pop(ra)
ret
