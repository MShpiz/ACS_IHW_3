.include "macrolib.s"

.globl ask_file_name

ask_file_name:
.eqv    NAME_SIZE 256	# Размер буфера для имени файла
.data
prompt:         .asciz "Enter file path: "     
file_name:      .space	NAME_SIZE		# Имячитаемого файла
.text

push(ra)

# Getting file name from user
    la	a0, prompt
    la	a1 file_name
    li  a2 NAME_SIZE
    li  a7 54
    ecall
    # remove \n
    li	t4 '\n'
    la	t5	file_name
loop:
    lb	t6  (t5)
    beq t4	t6	replace
    addi t5 t5 1
    b	loop
replace:
    sb	zero (t5)
   
   la a0 file_name # return file name

pop(ra)
ret