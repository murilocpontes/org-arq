	.data
	.align 0
string1:
	.space 100
string2:
	.space 100
	
	.text
	.globl main
main:
	la t0, string1	# t0 = &string1
	la t1, string2	# t1 = &string2
	li t2, 100	# t2 = 100
	li t3, 10 	# t3 = 10
	li a7, 12	# a7 = 12 = readChar
	add a1, x0, t0	# a1 = t0 (func parameter) 
	jal read_buffer
	add t5, x0, t4	# t5 = t4 (sizeof(string1))
	li t4, 0	# t4 = 0
	add a1, x0, t1	# a1 = t1
	jal read_buffer
	add a3, x0, t5
	add a4, x0, t4
	jal strcmp
strcmp:
	li t6, 0
	la t0, string1	# t0 = &strin1
	la t1, string2	# t1 = &string2
	bge a3, a4, for
	addi t2, a3, 0
	add a3, x0, a4
	add a4, x0, a3
for:
	bgt t6, t5, equal
	add a1, t0, t6
	add a2, t1, t6
	lb a1, 0(a1)
	lb a2, 0(a2)
	bne a1, a2, not_equal
	addi t6, t6, 1
	j for
	
not_equal:
	sub a0, a1, a2
	li a7, 1
	ecall			# print
 	li a7, 10		# a7 = exit code
 	ecall			# exit	

equal:
	li a0, 0
	li a7, 1
	ecall
	li a7 10
	ecall
	
read_buffer:
	bge t4, t2, end_read_buffer	# for(int i = 0, i < 100, i++)
	ecall				# scanf(%c)
	beq a0, t3, end_read_buffer	# if(a0 == '\n')
	sb a0, 0(a1)			# a1 = string[i]
	addi a1, a1, 1			# a1 = &string[i+]
	addi t4, t4, 1			# i++
	j read_buffer
end_read_buffer:
	ret