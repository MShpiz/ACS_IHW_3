.include "macrolib.s"
.global write_result

.eqv    NAME_SIZE 256	# Размер буфера для имени файла
.data
prompt:         .asciz "Enter file path: "     # Путь до читаемого файла
prompt_console:         .asciz "Do you want to get results in console? (Y/N)"     # Путь до читаемого файла

out_file_name:      .space	NAME_SIZE		# Имячитаемого файла
answer:		.space	3
ansBuff: .space 3
.text
write_result:
push(ra)
push(s0)
jal make_result_string
mv	s0, a0

# ask user about console

la	a0, prompt_console
la 	a1 answer
li  	a2 3
li 	 a7 54
ecall

la	t0, answer
lb	t3 (t0)
li	t1, 89
li	t2, 121
beq	t3, t1, writeToConsole
beq	t3, t2, writeToConsole

li	t1, 78
li	t2, 110
beq	t3, t1, writeToFile
beq	t3, t2, writeToFile

j	BadAnswer
# write result to console
writeToConsole:
mv	a0, s0
li	a1, 1
li 	 a7 55
ecall

j end_write
# get file name from user   
BadAnswer:

writeToFile: 
    ###############################################################
    # Вывод подсказки
    # Ввод имени файла с консоли эмулятора
    la	a0, prompt
    la	a1 out_file_name
    li  a2 NAME_SIZE
    li  a7 54
    ecall
    # Убрать перевод строки
    li	t4 '\n'
    la	t5	out_file_name
loop1:
    lb	t6  (t5)
    beq t4	t6	replace1
    addi t5 t5 1
    b	loop1
replace1:
    sb	zero (t5)
    li   a7, 1024     # system call for open file
    li   a1, 1        # Open for writing (flags are 0: read, 1: write)
    ecall             # open a file (file descriptor returned in a0)
    mv   t0, a0       # save the file descriptor
    ###############################################################
    # Write to file just opened
    li   a7, 64       # system call for write to file
    mv   a0, t0       # file descriptor
    mv   a1, s0       # address of buffer from which to write
    li   a2, 37       # hardcoded buffer length
    ecall             # write to file
    li t1, 37
    ###############################################################
    # Close the file
    li   a7, 57       # system call for close file
    mv   a0, s6       # file descriptor to close
    ecall             # close file
# write result to file
end_write:


pop(s0)
pop(ra)
ret

