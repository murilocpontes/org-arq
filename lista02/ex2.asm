	.data
size:	.word 3

array: .space 12

	.text
	.globl main
main:
	la t0, size	# t0 = &size
	lw t1, 0(t0)	# t1 = size
	addi t1, t1, -1	# t1 = size - 1
	li a0, 0	# a0 = i = 0 
	la t2, array	# t2 = &array
array_def:
	li t3, 7	# t3 = 7
	sw t3, 0(t2)	# array[0] = 7
	li t3, 3	# t3 = 3
	sw t3, 4(t2)	# array[1] = 3
	li t3, 5	# t3 = 5
	sw t3, 8(t2)	#array [3] = 5
for:	
	bge a0, t1, skip	# for(a0, a0 < t1, a0++) -> executa skip quando a0 >= t1 = size-1
	li t4, 4	# t4 = 4
	mul t5, a0, t4	# t5 = a0*t4 = i*4
	add t6, t2, t5	# t6 = &num[0] + 4*i = &num[i]
	lw a1, 0(t6)	# a1 = num[i]
	lw a2, 4(t6)	# a2 = num[i+1]
	add a3, a1, a2	# a3 = a1 + a2
	sw a3, 4(t6)	# num[i+1] = a3
	addi a0, a0, 1	# a0 += 1 = i
	j for
skip:
	lw a0, 4(t6)	# num[i] = a0
	li a7, 1	# a7 = 1 to print interger
	ecall
	li a7, 10	# a7 to end program
	ecall 
