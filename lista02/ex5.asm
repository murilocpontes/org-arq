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
	add a1, x0, t1
	jal read_buffer
	li t6, 0	# t6 = 0
	add a1, t0, t5	# a1 = &string1[t5]
	addi a1, a1, -1	# a1 = &string1[t5-1]
strcat:
	bge t6, t4, end_strcat	#for(1=0, i < sizeof(string2), i++)
	add a2, t1, t6	# a2 = &string2[i]
	addi a1, a1, 1	# a1 = &string1[t5+i]
	lb a2, 0(a2)	# a2 = string2[i]
	sb a2, 0(a1)	# string[t5+i] = a2
	addi t6, t6, 1	# i++
	j strcat
end_strcat:
	addi a1, a1, 1	# a1 = &string[t5+t4]
	sb x0, 0(a1)	#string[t5+t4] = '\0'
print_string:
 	li a7, 4		# a7 = printString number
 	add a0, x0, t0		# a0 = &string1[0] 
 	ecall			# print
 	li a7, 10		# a7 = exit code
 	ecall			# exit
	
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