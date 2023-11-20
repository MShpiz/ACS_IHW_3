.include "macrolib.s"
.global read_from_file

read_from_file:

.data
incorrect_file:	.asciz	"Incorrect file name"
incorrect_read:	.asciz	"Incorrect read operation"

.text
    push(ra)
    push(s0)
    push(s1)
    push(s2)
    push(s3)
    push(s4)
    mv	s1, a0		# buffer
    mv	s2, a1		# lenght
    mv  s4, a2		# file name
    print_str_r(s4)
    newline
    addi	s2, s2, -1 # make place for \0
    
    # open file
    li   	a7 1024     	
    mv          a0 s4
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
    li	a0, 0
    end_read:
    pop(s4)
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
