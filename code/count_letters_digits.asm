.include "macrolib.s"
.global countLettersDigits

countLettersDigits:
push(ra)
push(s0)
push(s1)
push(s2)
push(s3)
push(s4)
push(s5)

li s0, 48	# 0
li s1, 57	# 9

li s2, 65	# A
li s3, 90	# Z

li s4, 97	# a
li s5, 122	# z
mv	t0, a0		# buffer

li      t1 0		# letter counter
li	t2 0		# digit counter
loopC:
    lb      t3 (t0)	# getting symbol
    beqz    t3 endCount	# end loop at end of string
    UpperLetter:			# if curr character is less than 'A', it can be a digit, if it is greater than 'Z', it can be lower case letter
    blt		t3, s2, digit
    bgt		t3, s3, LowerLetter
    addi	t1, t1, 1			# else it is upper case letter
    j next
    
    LowerLetter:
    blt		t3, s4, next		# if curr character is less than 'a' or greater than 'z', it is not needed
    bgt		t3, s5, next
    addi	t1, t1, 1
    j next
    
    digit:
    blt		t3, s0, next		# if curr character is less than '0' or greater than '9', it is not needed
    bgt		t3, s1, next
    addi	t2, t2, 1
    next:
    addi    t0 t0 1		# taking next symbol
    
    j       loopC
endCount:
mv a0 t1		# returning counters
mv a1 t2
pop(s5)
pop(s4)
pop(s3)
pop(s2)
pop(s1)
pop(s0)
pop(ra)
ret

