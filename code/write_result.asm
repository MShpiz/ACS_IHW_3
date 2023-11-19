.include "macrolib.s"
.global write_result

.data
prompt_console:         .asciz "Do you want to get results in console? (Y/N)"     
bad_answer:	.asciz "Invalid answer. Writing results to file."

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
    jal ask_file_name		# getting file to write results to from user
    mv	a1 s0			# passing string to write
    jal write_to_file
end_write:

# finish program
pop(s0)
pop(ra)
ret

