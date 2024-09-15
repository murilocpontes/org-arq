	.data
option: .word 0
	.align 0
menu_string: .asciz "\nEscolha:\n0. Pedra \n1. Papel \n2.Tesoura \n3. Sair\n"
	.text
	.globl main
main:
	la t0, option
	la t1, menu_string
	li t2, 0
	li t3, 1
	li t4, 3
menu:	
	bge t2, t3, end_menu
	li a7, 4
	add a0, x0, t1
	ecall
	li a7, 5
	ecall
	beq a0, t4, end_menu
	sw a0, 0(t0)
	j menu
end_menu:
	li a7, 10
	ecall