.include "macrolib.s"
.global toString

# make string from numbers with 3 digits or less
toString:	# a0 - number, a1 - buffer for result string
push(ra)
li t0 100000	# tekuschiy razryad chisla
li t3, 10	# ten
loopp:
div	t1, a0, t0	# get first digit
addi	t2, t1, 48	# make it a characer of this digit
sb	t2, (a1)	# save new character
mul	t1, t0, t1
sub	a0, a0, t1	# make number less
addi 	a1, a1, 1	# move to next pos in string
div	t0, t0, t3	# make tekuschiy razryad chisla less
bnez	t0, loopp
sb	zero, (a1)	# put \0 in the end

pop(ra)
ret
