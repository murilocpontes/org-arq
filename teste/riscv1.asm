		.data
		.align 2
vlr_inteiro:	.word 157
		.align 0
string: 	.asciz "Hello World"

		.text
		.globl main
main:
		.align 2
		addi a7, x0, 4
		la a0, string
		ecall
		
		addi a7, x0, 10
		ecall
		