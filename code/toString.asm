.include "macrolib.s"
.global toString

toString:
push(ra)
li t0 100
li t3, 10
loopp:
div	t1, a0, t0
addi	t2, t1, 48
sb	t2, (a1)
mul	t1, t0, t1
sub	a0, a0, t1
addi 	a1, a1, 1
div	t0, t0, t3
bnez	t0, loopp
sb	zero, (a1)

pop(ra)
ret