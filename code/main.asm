# variant 16
.include "macrolib.s"
.eqv    TEXT_SIZE 512	# length of text

.data
buff:	.space	TEXT_SIZE

.text
.global	main
main:
jal ask_file_name	# get initial file from user
mv	a2, a0		# passing file_name for reading
la	a0, buff	# passing buffer
li	a1, TEXT_SIZE	# passing lenght
jal read_from_file	# returns lenght of final string to a0
bltz	a0, program_end	# if resulting length of text is less than 0 (error occured) -> finish program
mv	a0, a1
mv	a1, a2
jal write_result
program_end:
exit
