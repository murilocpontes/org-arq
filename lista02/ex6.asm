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
	li t5, 0	# i = 0
strcpy:
	bge t5, t4, end_strcpy	# for(i = 0, i < sizeof(str1), i++)
	add a1, t0, t5		# a1 =&str1[i] 
	add a2, t1, t5		# a2 =&str2[i]
	lb a1, 0(a1)		# a1 =str1[i]
	sb a1, 0(a2)		# str2[i] = str1[i]
	addi t5, t5, 1		# i++
	j strcpy
end_strcpy:
	add a2, t1, t5		# str2[size] = '\n'
	sb x0, 0(a2)
	
print_string:
 	li a7, 4		# a7 = printString number
 	add a0, x0, t1		# a0 = &string2[0] 
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