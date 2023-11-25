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
    push(s5)
    mv	s1, a0		# buffer
    mv	s2, a1		# lenght
    mv  s4, a2		# file name
    li	s3, 0		# letter count
    li	s5, 0		# digit count
    
    addi	s2, s2, -1 # make place for \0
    
    # open file
    li   	a7 1024     	
    mv          a0 s4
    li   	a1 0        	
    ecall             		
    li		t0 -1			
    beq		a0 t0 er_name	# if file name is bad tell user
    mv   	s0 a0       	
    
read_loop:
    # reading file in portions

    read_addr_reg(s0, s1, s2) # read a prt of file to s1
    # check if reading was ok
    li		t0 -1
    beq		a0 t0 er_read	# if there was an error while reading file tell user
    mv   	t4 a0       	
    beq		t4 s2 count	# if length of new text is less than length of beffer add \0 in the end
    mv		t3, t4
    rem		t3 t3, s2
    add		t3, t3, s1
    sb		zero, (t3)
    count:
    
    mv		a0 s1
    jal 	countLettersDigits
    add		s3, s3, a0
    add		s5, s5, a1
    
    bne		t4 s2 end_loop  # if length of new text is less than length of beffer finnish reading.
    
    b read_loop				# read next portion of file
end_loop:
    
    # close file
    li   a7, 57       
    mv   a0, s0       
    ecall             
    
    
    li	a0, 0
    end_read:
    mv	a1, s3
    mv	a2, s5
    pop(s5)
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
