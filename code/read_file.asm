.include "macrolib.s"
.global read_from_file

read_from_file:
# Чтение текста из файла, задаваемого в диалоге, в буфер фиксированного размера
.eqv    NAME_SIZE 256	# Размер буфера для имени файла
    .data
prompt:         .asciz "Enter file path: "     # Путь до читаемого файла
incorrect_file:	.asciz	"Incorrect file name"
incorrect_read:	.asciz	"Incorrect read operation"

file_name:      .space	NAME_SIZE		# Имячитаемого файла

.text
    push(ra)
    push(s0)
    push(s1)
    push(s2)
    push(s3)
    mv	s1, a0
    mv	s2, a1
    addi	s2, s2, -1 # make place for \0
    
    # Getting input file name from user
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
    # open file
    li   	a7 1024     	
    la      a0 file_name    
    li   	a1 0        	
    ecall             		
    li		t0 -1			
    beq		a0 t0 er_name	# if file name is bad tell user
    mv   	s0 a0       	
    
    # read file
    li   a7, 63       
    mv   a0, s0       
    mv a1, s1   
    mv a2 s2 
    
    ecall             
    
    beq		a0 s1 er_read	# if there was an error while reading file tell user
    mv   	s3 a0       	# saving text
    
    # close file
    li   a7, 57       
    mv   a0, s0       
    ecall             
    
    # put \0 at the end of text
    mv	t0 s1	 
    add t0 t0 s3	 
    sub a0, t0, s1	# length of text
    
    addi t0 t0 1	 
    addi a0 a0 1	# length of text + \0
    sb	zero (t0)	 
    
    end_read:
    pop(s3)
    pop(s2)
    pop(s1)
    pop(s0)
    pop(ra)
    ret
    
 er_name:
    # message about bad file name
    	la	a0, incorrect_file
	li	a1, 2
	li 	 a7 55
	ecall
	li	a0, -1	# make length -1
	jal end_read
er_read:
    # message about an error while reading file
	la	a0, incorrect_read
	li	a1, 2
	li 	 a7 55
	ecall
        li	a0, -1		# make length -1
        jal end_read
