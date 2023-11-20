.include "macrolib.s"

.globl write_to_file
.text
write_to_file:
    push(ra)
    mv	t6 a0	# file name
    mv	t5 a1	#string
    mv   a0, t6	# open file for writing
    li   a7, 1024     
    li   a1, 1        
    ecall             
    mv   t0, a0       # save the file descriptor

    # Write string from t5 to file just opened
    li   a7, 64       
    mv   a0, t0       
    mv   a1, t5       
    li   a2, 37       
    ecall             
   
    # Close the file
    li   a7, 57       
    mv   a0, t0       # file descriptor to close
    ecall             # close file

pop(ra)
ret
