# variant 16
.include "macrolib.s"
.eqv    TEXT_SIZE 512	# Размер буфера для текста

.data
buff:	.space	TEXT_SIZE

.text
.global	main
main:
la	a0, buff	# passing lenght of buffer
li	a1, TEXT_SIZE
addi	a1, a1, -1	# passing lenght of buffer -1 to have 1 byte for 0
jal read_from_file	# returns lenght of final string to a0
bltz	a0, program_end	# if resulting length of text is less than 0 (error occured) -> finish program
la	a0, buff	# passing string
jal countLettersDigits

jal write_result
program_end:
exit
