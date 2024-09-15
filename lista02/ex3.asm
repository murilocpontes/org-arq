	.data
	.align 0
buffer:	.space 100
newline: .byte 10



	.text
	.globl main
main:
	la t0, buffer		# t0 = &buffer[0] 
	li t1, 100		# t1 = size(buffer)
	li t2, 0		# t2 = i
	li a7, 12		# readChar number
	li t4, 10		# t3 = newline
	
scanf:
	bge t2, t1, end_scanf	# for(i=0, i<100, i++)
	ecall			#scanf(%c)
	beq a0, t4, end_scanf	# if(a0 == '\n') end_scanf
	add t3, t0, t2		# t3 = buffer[i+1]
	sb a0, 0(t3)		# buffer[i] = a0
	addi t2, t2, 1		# t2 = i+1
	j scanf

 end_scanf:
 	li t5, 0
 	add, t3, t0, t2
 	sb t5, 0(t3)		# buffer[i] = '\0'
 	li t6, 0		# j = 0
 	li t5, 2		
 	div a2, t2, t5		# a2 = t2/2
 	addi t2, t2, -1		# t2 = t2-1 (p/ acessar a memória)
swap_string:
	bge  t6, a2, print_string	# for(j=0, j< a2, j++)
	add t1, t0, t6			# t1 = &string[j]
	lb t3, 0(t1)			# t3 = string[j]
	sub t4, t2, t6			# t4 = t2 - t6 = size - j
	add t4, t0, t4			# t4 = &string[size-j]
	lb t5, 0(t4)			# t5 = string[size-j] 
	sb t5, 0(t1)			# string[j] = string[size-j]
	sb t3, 0(t4)			# string[size-j] = string[j]
	addi t6, t6, 1			# j++
	j swap_string
	
 
 
print_string:
 	li a7, 4		# a7 = printString number
 	add a0, x0, t0		# a0 = &buffer[0] 
 	ecall			# print
 	li a7, 10		# a7 = exit code
 	ecall
 	
 	
 	
