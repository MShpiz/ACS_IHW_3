.include "macrolib.s"
.global write_result

.eqv    OUT_NAME_SIZE 256	# length of name of output file
.data
prompt_out:         .asciz "Enter output file path: "     
prompt_console:         .asciz "Do you want to get results in console? (Y/N)"     
bad_answer:	.asciz "Invalid answer. Writing results to file."

out_file_name:      .space	OUT_NAME_SIZE		# name of output file
ansBuff: .space 3

.text
write_result:
push(ra)
push(s0)
jal make_result_string		# make a sring from numbers in a0 and a1
mv	s0, a0

# ask user if user wants results in console instead of file

la	a0, prompt_console
la 	a1 ansBuff
li  	a2 3
li 	 a7 54
ecall

la	t0, ansBuff		# if answer is Y or y write result to console
lb	t3 (t0)
li	t1, 89
li	t2, 121
beq	t3, t1, writeToConsole
beq	t3, t2, writeToConsole

li	t1, 78			# if answer is N or n write result to file
li	t2, 110
beq	t3, t1, writeToFile
beq	t3, t2, writeToFile

j	BadAnswer		# else
# write result to console
writeToConsole:			# writing to console
mv	a0, s0
li	a1, 1
li 	 a7 55
ecall

j end_write			# finish function
# get file name from user   
BadAnswer:		# informing user that results will be written to file

la	a0, bad_answer
li	a1, 1
li 	 a7 55
ecall

# write to file
writeToFile: 
    # Getting output file name from user
    la	a0, prompt_out
    la	a1 out_file_name
    li  a2 OUT_NAME_SIZE
    li  a7 54
    ecall
    # remove \n from file name
    li	t4 '\n'
    la	t5	out_file_name
loop1:
    lb	t6  (t5)
    beq t4	t6	replace1
    addi t5 t5 1
    bnez	t5 loop1
replace1:
    sb	zero (t5)
    la	a0 out_file_name
    mv	a1 s0
    jal write_to_file
end_write:

# finish program
pop(s0)
pop(ra)
ret

